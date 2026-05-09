"""Backup current DB and restore db_dump.sql.
Usage: ./.venv/Scripts/python.exe scripts/backup_and_restore.py
"""
import os
import re
import time
from datetime import datetime
import mysql.connector

# read .env
env_path = os.path.join(os.path.dirname(__file__), '..', 'backend', '.env')
env = {}
with open(env_path, 'r', encoding='utf-8') as f:
    for line in f:
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        if '=' in line:
            k, v = line.split('=', 1)
            env[k.strip()] = v.strip()

DB_HOST = env.get('DB_HOST', 'localhost')
DB_PORT = int(env.get('DB_PORT', '3306'))
DB_USER = env.get('DB_USER', 'root')
DB_PASSWORD = env.get('DB_PASSWORD', '')
DB_NAME = env.get('DB_NAME', '')

print(f"[*] Connecting to {DB_USER}@{DB_HOST}:{DB_PORT}/{DB_NAME}")
try:
    conn = mysql.connector.connect(
        host=DB_HOST, 
        port=DB_PORT, 
        user=DB_USER, 
        password=DB_PASSWORD,
        database=DB_NAME
    )
except Exception as e:
    print(f"[ERROR] {e}")
    raise

cur = conn.cursor()

# backup: dump all data from current DB
print("[*] Step 1: Backing up current database...")
backup_path = os.path.join(
    os.path.dirname(__file__),
    '..',
    f'anexo_de_datos_backup_{datetime.now().strftime("%Y%m%d_%H%M%S")}.sql'
)

# get all tables
cur.execute('SHOW TABLES')
tables = [row[0] for row in cur.fetchall()]
print(f"    Found {len(tables)} tables")

with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(f"-- Backup of {DB_NAME} at {datetime.now().isoformat()}\n")
    f.write(f"-- Tables: {', '.join(tables)}\n\n")
    
    for table in tables:
        # get CREATE TABLE
        cur.execute(f"SHOW CREATE TABLE `{table}`")
        create_stmt = cur.fetchone()[1]
        f.write(create_stmt + ";\n\n")
        
        # get data
        try:
            cur.execute(f"SELECT * FROM `{table}`")
            rows = cur.fetchall()
            if rows:
                # get column names
                col_names = [desc[0] for desc in cur.description]
                col_names_str = ', '.join(f"`{c}`" for c in col_names)
                for row_data in rows:
                    # escape values
                    values = []
                    for val in row_data:
                        if val is None:
                            values.append('NULL')
                        elif isinstance(val, str):
                            escaped = val.replace("'", "''")
                            values.append(f"'{escaped}'")
                        elif isinstance(val, (int, float)):
                            values.append(str(val))
                        else:
                            escaped = str(val).replace("'", "''")
                            values.append(f"'{escaped}'")
                    f.write(f"INSERT INTO `{table}` ({col_names_str}) VALUES ({', '.join(values)});\n")
        except Exception as e:
            print(f"    [WARN] Could not back up {table}: {e}")

print(f"[+] Backup saved to: {backup_path}")

# restore: read and execute db_dump.sql
dump_path = os.path.join(os.path.dirname(__file__), '..', 'db_dump.sql')
print(f"[*] Step 2: Reading {dump_path}...")

with open(dump_path, 'r', encoding='utf-8', errors='ignore') as f:
    dump_content = f.read()

# split by statements (simple split by ;)
statements = []
current = ''
for line in dump_content.split('\n'):
    stripped = line.strip()
    if not stripped or stripped.startswith('--'):
        continue
    current += ' ' + line
    if ';' in line:
        stmt = current.strip()
        if stmt:
            statements.append(stmt)
        current = ''

print(f"    Found ~{len(statements)} SQL statements")

# execute drop + create + restore
print("[*] Step 3: Dropping and recreating database...")
try:
    cur.execute(f"DROP DATABASE IF EXISTS `{DB_NAME}`")
    cur.execute(f"CREATE DATABASE `{DB_NAME}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
    conn.commit()
    print("    [+] Database dropped and recreated")
except Exception as e:
    print(f"    [ERROR] {e}")
    conn.rollback()
    raise

# reconnect to new DB
conn.close()
time.sleep(1)
conn = mysql.connector.connect(
    host=DB_HOST, 
    port=DB_PORT, 
    user=DB_USER, 
    password=DB_PASSWORD,
    database=DB_NAME
)
cur = conn.cursor()

print("[*] Step 4: Restoring data from db_dump.sql...")
executed = 0
errors = []
for i, stmt in enumerate(statements):
    if not stmt.strip():
        continue
    try:
        cur.execute(stmt)
        executed += 1
        if (i + 1) % 50 == 0:
            print(f"    Executed {executed} statements...")
    except Exception as e:
        errors.append((i, stmt[:100], str(e)))

conn.commit()
print(f"[+] Restoration complete: {executed} statements executed")

if errors:
    print(f"[!] {len(errors)} errors encountered:")
    for idx, stmt_preview, err in errors[:10]:
        print(f"    Line {idx}: {err}")

cur.close()
conn.close()

# final check
print("[*] Step 5: Verifying restoration...")
conn = mysql.connector.connect(
    host=DB_HOST, 
    port=DB_PORT, 
    user=DB_USER, 
    password=DB_PASSWORD,
    database=DB_NAME
)
cur = conn.cursor()
cur.execute('SHOW TABLES')
final_tables = [row[0] for row in cur.fetchall()]
print(f"[+] Final table count: {len(final_tables)} tables")

cur.close()
conn.close()
print("[*] Done!")
