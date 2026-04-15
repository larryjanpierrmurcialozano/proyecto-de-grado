#!/usr/bin/env python3
"""
Respaldo y restauracion de base de datos MySQL/MariaDB.

Ejemplos:
  python backend/scripts/db_backup.py export --out backend/backup/db_dump.sql
  python backend/scripts/db_backup.py import --in backend/backup/db_dump.sql
    python backend/scripts/db_backup.py import-if-missing --in backend/backup/db_dump.sql
"""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

from dotenv import load_dotenv


ROOT = Path(__file__).resolve().parents[2]
BACKEND_DIR = ROOT / "backend"
DEFAULT_ENV = BACKEND_DIR / ".env"
DEFAULT_DUMP = BACKEND_DIR / "backup" / "db_dump.sql"


def _load_env(env_path: Path | None) -> None:
    if env_path and env_path.exists():
        load_dotenv(env_path)
    else:
        load_dotenv()


def _get_db_config() -> tuple[str, int, str, str, str]:
    host = os.getenv("DB_HOST", "localhost")
    port_raw = os.getenv("DB_PORT", "3306")
    user = os.getenv("DB_USER", "root")
    password = os.getenv("DB_PASSWORD", "")
    database = os.getenv("DB_NAME", "")

    try:
        port = int(port_raw)
    except ValueError:
        print("[ERROR] DB_PORT no es valido.")
        raise SystemExit(2)

    if not database:
        print("[ERROR] DB_NAME no esta definido en .env.")
        raise SystemExit(2)

    return host, port, user, password, database


def _require_tool(name: str) -> str:
    path = shutil.which(name)
    if not path:
        print(f"[ERROR] No se encontro '{name}' en PATH.")
        print("Instala el cliente de MySQL/MariaDB y agrega su carpeta a PATH.")
        raise SystemExit(2)
    return path


def _run_with_password(cmd: list[str], password: str, *, stdin=None, stdout=None) -> subprocess.CompletedProcess:
    env = os.environ.copy()
    if password:
        # MYSQL_PWD evita mostrar la clave en el listado de procesos.
        env["MYSQL_PWD"] = password
    return subprocess.run(cmd, stdin=stdin, stdout=stdout, stderr=subprocess.PIPE, env=env)


def export_db(out_path: Path) -> None:
    mysqldump = _require_tool("mysqldump")
    host, port, user, password, database = _get_db_config()

    out_path.parent.mkdir(parents=True, exist_ok=True)

    cmd = [
        mysqldump,
        f"--host={host}",
        f"--port={port}",
        f"--user={user}",
        "--routines",
        "--triggers",
        "--single-transaction",
        "--set-gtid-purged=OFF",
        "--databases",
        database,
    ]

    print(f"[OK] Exportando a {out_path}")
    with out_path.open("wb") as handle:
        res = _run_with_password(cmd, password, stdout=handle)

    if res.returncode != 0:
        err = res.stderr.decode(errors="ignore").strip()
        if err:
            print(err)
        print("[ERROR] Fallo el respaldo de la base de datos.")
        raise SystemExit(2)

    print("[OK] Respaldo completado.")


def import_db(in_path: Path) -> None:
    if not in_path.exists():
        print(f"[ERROR] No existe el archivo: {in_path}")
        raise SystemExit(2)

    mysql = _require_tool("mysql")
    host, port, user, password, _database = _get_db_config()

    cmd = [
        mysql,
        f"--host={host}",
        f"--port={port}",
        f"--user={user}",
    ]

    print(f"[OK] Importando desde {in_path}")
    with in_path.open("rb") as handle:
        res = _run_with_password(cmd, password, stdin=handle)

    if res.returncode != 0:
        err = res.stderr.decode(errors="ignore").strip()
        if err:
            print(err)
        print("[ERROR] Fallo la restauracion de la base de datos.")
        raise SystemExit(2)

    print("[OK] Restauracion completada.")


def _db_exists(database: str) -> bool:
    mysql = _require_tool("mysql")
    host, port, user, password, _database = _get_db_config()

    safe_db = database.replace("'", "''")
    query = (
        "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA "
        f"WHERE SCHEMA_NAME='{safe_db}';"
    )

    cmd = [
        mysql,
        f"--host={host}",
        f"--port={port}",
        f"--user={user}",
        "-N",
        "-B",
        "-e",
        query,
    ]

    res = _run_with_password(cmd, password, stdout=subprocess.PIPE)
    if res.returncode != 0:
        err = res.stderr.decode(errors="ignore").strip()
        if err:
            print(err)
        print("[ERROR] No se pudo verificar si la base existe.")
        raise SystemExit(2)

    output = res.stdout.decode(errors="ignore").strip()
    return bool(output)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Respaldo y restauracion de BD")
    parser.add_argument(
        "--env",
        default=str(DEFAULT_ENV),
        help="Ruta al archivo .env (opcional)",
    )

    sub = parser.add_subparsers(dest="command", required=True)

    export_p = sub.add_parser("export", help="Generar archivo .sql")
    export_p.add_argument(
        "--out",
        default=str(DEFAULT_DUMP),
        help="Ruta destino del respaldo .sql",
    )

    import_p = sub.add_parser("import", help="Restaurar desde archivo .sql")
    import_p.add_argument(
        "--in",
        dest="in_path",
        default=str(DEFAULT_DUMP),
        help="Ruta del respaldo .sql",
    )

    import_missing_p = sub.add_parser(
        "import-if-missing",
        help="Restaurar solo si la base no existe",
    )
    import_missing_p.add_argument(
        "--in",
        dest="in_path",
        default=str(DEFAULT_DUMP),
        help="Ruta del respaldo .sql",
    )

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    env_path = Path(args.env) if args.env else None
    _load_env(env_path)

    if args.command == "export":
        export_db(Path(args.out))
        return 0

    if args.command == "import":
        import_db(Path(args.in_path))
        return 0

    if args.command == "import-if-missing":
        _host, _port, _user, _password, database = _get_db_config()
        if _db_exists(database):
            print(f"[OK] La base '{database}' ya existe. No se importo.")
            return 0
        import_db(Path(args.in_path))
        return 0

    return 1


if __name__ == "__main__":
    raise SystemExit(main())
