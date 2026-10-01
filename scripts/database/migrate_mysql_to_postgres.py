"""Copy the current MySQL schema and data into PostgreSQL."""

from __future__ import annotations

import os
from pathlib import Path

from sqlalchemy import (
    Boolean,
    Column,
    Date,
    DateTime,
    Float,
    ForeignKeyConstraint,
    Index,
    Integer,
    LargeBinary,
    MetaData,
    Numeric,
    SmallInteger,
    String,
    Table,
    Text,
    Time,
    UniqueConstraint,
    create_engine,
    text,
)
from sqlalchemy.dialects.mysql import ENUM as MySQLEnum
from sqlalchemy.dialects.mysql import JSON as MySQLJSON
from sqlalchemy.dialects.mysql import TINYINT
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.sql.sqltypes import BIGINT, JSON, REAL


ROOT = Path(__file__).resolve().parents[2]
MYSQL_URL = os.getenv(
    "MYSQL_URL",
    "mysql+mysqlconnector://root:root@127.0.0.1:3306/anexo_de_datos",
)
POSTGRES_URL = os.getenv(
    "POSTGRES_URL",
    "postgresql+psycopg://docstry_app:change_me_locally@127.0.0.1:5432/anexo_de_datos",
)


def postgres_type(source_type):
    if isinstance(source_type, (MySQLEnum, String)):
        length = getattr(source_type, "length", None)
        return String(length) if length else Text()
    if isinstance(source_type, (MySQLJSON, JSON)):
        return JSONB()
    if isinstance(source_type, TINYINT):
        return Boolean() if getattr(source_type, "display_width", None) == 1 else SmallInteger()
    if isinstance(source_type, BIGINT):
        return BIGINT()
    if isinstance(source_type, SmallInteger):
        return SmallInteger()
    if isinstance(source_type, Integer):
        return Integer()
    if isinstance(source_type, (Numeric,)):
        return Numeric(source_type.precision, source_type.scale)
    if isinstance(source_type, (Float, REAL)):
        return Float()
    if isinstance(source_type, DateTime):
        return DateTime()
    if isinstance(source_type, Date):
        return Date()
    if isinstance(source_type, Time):
        return Time()
    if isinstance(source_type, LargeBinary):
        return LargeBinary()
    if isinstance(source_type, Text):
        return Text()
    return String(getattr(source_type, "length", None))


def build_target_metadata(source_metadata):
    target_metadata = MetaData()
    target_tables = {}

    for source_table in source_metadata.sorted_tables:
        columns = []
        for source_column in source_table.columns:
            columns.append(
                Column(
                    source_column.name,
                    postgres_type(source_column.type),
                    primary_key=source_column.primary_key,
                    nullable=source_column.nullable,
                    autoincrement=bool(source_column.autoincrement),
                )
            )

        target_table = Table(source_table.name, target_metadata, *columns)
        target_tables[source_table.name] = target_table

        for constraint in source_table.constraints:
            if isinstance(constraint, UniqueConstraint):
                target_table.append_constraint(
                    constraint.__class__(
                        *[target_table.c[column.name] for column in constraint.columns],
                        name=constraint.name,
                    )
                )

    for source_table in source_metadata.sorted_tables:
        target_table = target_tables[source_table.name]
        for foreign_key in source_table.foreign_key_constraints:
            target_table.append_constraint(
                ForeignKeyConstraint(
                    [target_table.c[column.name] for column in foreign_key.columns],
                    [
                        f"{element.column.table.name}.{element.column.name}"
                        for element in foreign_key.elements
                    ],
                    name=foreign_key.name,
                )
            )

        for source_index in source_table.indexes:
            index_name = f"ix_{source_table.name}_{source_index.name}"[:63]
            Index(
                index_name,
                *[target_table.c[column.name] for column in source_index.columns],
                unique=source_index.unique,
            )

    return target_metadata, target_tables


def copy_table_data(source_connection, target_connection, source_table, target_table):
    rows = source_connection.execute(source_table.select()).mappings()
    batch = []
    copied = 0
    for row in rows:
        values = dict(row)
        for column in target_table.columns:
            if isinstance(column.type, Boolean) and values.get(column.name) is not None:
                values[column.name] = bool(values[column.name])
        batch.append(values)
        if len(batch) >= 500:
            target_connection.execute(target_table.insert(), batch)
            copied += len(batch)
            batch.clear()
    if batch:
        target_connection.execute(target_table.insert(), batch)
        copied += len(batch)
    return copied


def reset_sequences(connection, target_tables):
    for table in target_tables.values():
        for column in table.columns:
            if not column.primary_key or not column.autoincrement:
                continue
            qualified_name = f"public.{table.name}"
            statement = text(
                f'SELECT setval(pg_get_serial_sequence(:table_name, :column_name), '
                f'COALESCE(MAX("{column.name}"), 1), '
                f'MAX("{column.name}") IS NOT NULL) FROM "{table.name}"'
            )
            connection.execute(
                statement,
                {"table_name": qualified_name, "column_name": column.name},
            )


def main():
    source_engine = create_engine(MYSQL_URL)
    target_engine = create_engine(POSTGRES_URL)
    source_metadata = MetaData()

    print("[1/4] Reflejando esquema MySQL")
    source_metadata.reflect(bind=source_engine)
    target_metadata, target_tables = build_target_metadata(source_metadata)

    print("[2/4] Creando esquema PostgreSQL")
    target_metadata.drop_all(target_engine)
    target_metadata.create_all(target_engine)

    total_rows = 0
    print("[3/4] Copiando datos")
    with source_engine.connect() as source_connection, target_engine.begin() as target_connection:
        for source_table in source_metadata.sorted_tables:
            copied = copy_table_data(
                source_connection,
                target_connection,
                source_table,
                target_tables[source_table.name],
            )
            total_rows += copied
            print(f"  {source_table.name}: {copied} filas")
        reset_sequences(target_connection, target_tables)

    print(f"[4/4] Migracion completada: {len(target_tables)} tablas, {total_rows} filas")


if __name__ == "__main__":
    main()