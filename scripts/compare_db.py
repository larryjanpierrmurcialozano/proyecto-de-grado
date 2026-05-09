"""Compare MySQL database (local) with SQL dump file (db_dump.sql).
Reads DB credentials from backend/.env and compares table presence and row counts.
Run with the project's venv Python: ./.venv/Scripts/python.exe scripts/compare_db.py
"""
import re
import os
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

print(f"Using DB: {DB_USER}@{DB_HOST}:{DB_PORT}/{DB_NAME}")

# parse dump
dump_path = os.path.join(os.path.dirname(__file__), '..', 'db_dump.sql')
with open(dump_path, 'r', encoding='utf-8', errors='ignore') as f:
    dump = f.read()

# find tables created in dump
create_re = re.compile(r"CREATE TABLE `(?P<table>[^`]+)`", re.IGNORECASE)
insert_re = re.compile(r"INSERT INTO `(?P<table>[^`]+)`\s+VALUES\s*(?P<vals>\([^;]+?\));", re.IGNORECASE | re.DOTALL)

tables_in_dump = set(m.group('table') for m in create_re.finditer(dump))
insert_counts = {}
for m in insert_re.finditer(dump):
    table = m.group('table')
    vals = m.group('vals')
    # count rows in this VALUES group: count '),(' + 1
    rows = vals.count('),(') + 1
    insert_counts[table] = insert_counts.get(table, 0) + rows

print(f"Tables found in dump: {len(tables_in_dump)}")
print(f"Tables with insert counts parsed: {len(insert_counts)}")

# connect to MySQL
try:
    conn = mysql.connector.connect(host=DB_HOST, port=DB_PORT, user=DB_USER, password=DB_PASSWORD, database=DB_NAME)
except Exception as e:
    print('ERROR connecting to MySQL:', e)
    raise

cur = conn.cursor()
# get tables in live DB
cur.execute('SHOW TABLES')
rows = cur.fetchall()
live_tables = set(r[0] for r in rows)
print(f"Tables in live DB: {len(live_tables)}")

# compare presence
only_in_dump = sorted(tables_in_dump - live_tables)
only_in_live = sorted(live_tables - tables_in_dump)

if only_in_dump:
    print('\nTables present in dump but missing in live DB:')
    for t in only_in_dump:
        print('  -', t)
else:
    print('\nNo tables missing in live DB (from dump set).')

if only_in_live:
    print('\nTables present in live DB but not in dump:')
    for t in only_in_live[:100]:
        print('  -', t)
else:
    print('\nNo extra tables in live DB (compared to dump).')

# compare row counts for tables present in both
common = sorted(tables_in_dump & live_tables)
if not common:
    print('\nNo common tables to compare row counts.')
else:
    print(f"\nComparing row counts for {len(common)} common tables:")
    diffs = []
    for t in common:
        try:
            cur.execute(f"SELECT COUNT(*) FROM `{t}`")
            live_count = cur.fetchone()[0]
        except Exception as e:
            live_count = f'ERROR: {e}'
        dump_count = insert_counts.get(t, 0)
        if isinstance(live_count, int) and live_count == dump_count:
            status = 'OK'
        else:
            status = 'DIFF'
            diffs.append((t, dump_count, live_count))
        print(f"{t}: dump={dump_count}  live={live_count}  => {status}")

    if diffs:
        print('\nTables with differences (table, dump_count, live_count):')
        for t, d, l in diffs:
            print(f"  {t}: {d} vs {l}")
    else:
        print('\nAll compared tables have matching row counts based on parsed INSERTs.')

cur.close()
conn.close()
print('\nDone.')
