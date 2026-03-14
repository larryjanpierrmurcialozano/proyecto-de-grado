#!/usr/bin/env python3
"""
Instalador automático de imports para el proyecto.

Uso:
  python backend/instalador_imports.py [--yes] [--dry-run]

Opciones:
  --yes     Ejecuta instalaciones sin pedir confirmación.
  --dry-run Solo lista paquetes que instalaría.

Funcionamiento básico:
  - Escanea todos los archivos .py del repositorio (salta venv y __pycache__).
  - Extrae nombres de módulos importados.
  - Filtra módulos de la stdlib y módulos locales del proyecto.
  - Para los módulos no instalados, ejecuta `python -m pip install <modulo>`.

Notas:
  - No existe una correspondencia perfecta entre nombre de import y nombre pip
    (ej: `bs4` vs `beautifulsoup4`). Este script intenta instalar usando el
    nombre del paquete igual al nombre del import.
"""

from __future__ import annotations

import argparse
import ast
import os
import subprocess
import sys
import openpyxl
from openpyxl import *
import importlib.util
from pathlib import Path
from typing import Set


ROOT = Path(__file__).resolve().parents[1]


def find_py_files(root: Path) -> Set[Path]:
    skip_dirs = {".venv", "venv", "__pycache__", "node_modules", "env"}
    files = set()
    for dirpath, dirnames, filenames in os.walk(root):
        # modify dirnames in-place to skip
        dirnames[:] = [d for d in dirnames if d not in skip_dirs and not d.startswith(".")]
        for f in filenames:
            if f.endswith('.py'):
                files.add(Path(dirpath) / f)
    return files


def extract_imports_from_file(path: Path) -> Set[str]:
    try:
        src = path.read_text(encoding='utf-8')
    except Exception:
        return set()
    mods: Set[str] = set()
    try:
        tree = ast.parse(src)
    except Exception:
        return set()
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            for n in node.names:
                mods.add(n.name.split('.')[0])
        elif isinstance(node, ast.ImportFrom):
            if node.module:
                mods.add(node.module.split('.')[0])
    return mods


def is_local_module(name: str, root: Path) -> bool:
    # check for package dir or module file in project
    if (root / f"{name}.py").exists():
        return True
    if (root / name).is_dir():
        return True
    return False


def is_stdlib_module(name: str) -> bool:
    # Prefer sys.stdlib_module_names when available (Py3.10+)
    try:
        import sys
        stdlib = getattr(sys, 'stdlib_module_names', None)
        if stdlib is not None:
            return name in stdlib
    except Exception:
        pass

    # Fallback: use importlib.util.find_spec and inspect origin
    try:
        spec = importlib.util.find_spec(name)
        if spec is None:
            return False
        origin = spec.origin
        if origin is None:
            return True
        origin = str(origin)
        # heurística: si está en site-packages o dist-packages -> no stdlib
        if 'site-packages' in origin or 'dist-packages' in origin:
            return False
        # si el path contiene Python\Lib (Windows) o /lib/pythonX (Unix) -> stdlib
        if 'lib/python' in origin.replace('\\','/') or ('\\Lib\\' in origin):
            return True
    except Exception:
        pass
    return False


def is_installed(name: str) -> bool:
    try:
        return importlib.util.find_spec(name) is not None
    except Exception:
        return False


def install_package(name: str) -> bool:
    cmd = [sys.executable, '-m', 'pip', 'install', name]
    try:
        print(f"Ejecutando: {' '.join(cmd)}")
        res = subprocess.run(cmd, check=True)
        return res.returncode == 0
    except subprocess.CalledProcessError:
        return False


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description='Instalador automático de imports')
    p.add_argument('--yes', action='store_true', help='Instala sin pedir confirmación')
    p.add_argument('--dry-run', action='store_true', help='Solo lista paquetes a instalar')
    p.add_argument('--root', default=str(ROOT), help='Raíz del proyecto (opcional)')
    args = p.parse_args(argv)

    root = Path(args.root)
    print(f"Escaneando {root} en busca de archivos .py ...")
    py_files = find_py_files(root)
    print(f"Se encontraron {len(py_files)} archivos .py")

    imports: Set[str] = set()
    for f in sorted(py_files):
        imports.update(extract_imports_from_file(f))

    # filtrar nombres inválidos y propios
    candidates: Set[str] = set()
    for name in imports:
        if not name or name.startswith('_'):
            continue
        if is_local_module(name, root):
            continue
        if is_stdlib_module(name):
            continue
        candidates.add(name)

    if not candidates:
        print('No se encontraron paquetes externos para instalar.')
        return 0

    to_install = [n for n in sorted(candidates) if not is_installed(n)]
    if not to_install:
        print('Todos los paquetes detectados ya están instalados en el entorno.')
        return 0

    print('\nPaquetes detectados para instalar:')
    for n in to_install:
        print(' -', n)

    if args.dry_run:
        print('\n--dry-run activado, no se instalará nada.')
        return 0

    if not args.yes:
        ok = input('\nDeseas instalar estos paquetes ahora? [y/N]: ').strip().lower()
        if ok not in ('y', 's', 'si', 'yes'):
            print('Cancelado por usuario.')
            return 1

    success = []
    fail = []
    for name in to_install:
        print(f'Instalando {name} ...')
        ok = install_package(name)
        if ok:
            success.append(name)
        else:
            fail.append(name)

    print('\nResumen:')
    print('Instalados:', ', '.join(success) if success else 'ninguno')
    print('Fallaron:', ', '.join(fail) if fail else 'ninguno')

    return 0 if not fail else 2


if __name__ == '__main__':
    raise SystemExit(main())
