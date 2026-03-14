"""Sincronizador Git para Planillas

Este script copia los archivos dentro de `PLANILLAS_DIR` hacia un repositorio local/clonado
y realiza `git add/commit/push` usando el autor configurado para que los commits aparezcan
como tuyos en GitHub.

Configuración esperada (variables de entorno):
- GIT_REMOTE: URL del remoto (https o ssh). Si usas HTTPS y quieres autenticación automática,
  puedes proporcionar `GIT_PAT` y el script insertará el token temporalmente en la URL.
- GIT_REPO_DIR: carpeta local donde clonar/actualizar el repo (por defecto: ./planillas_repo)
- GIT_BRANCH: rama destino (por defecto: planillas)
- GIT_USER_NAME: nombre que aparecerá como autor del commit
- GIT_USER_EMAIL: email asociado a tu cuenta GitHub (debe coincidir con cuenta para atribución)
- GIT_PAT: (opcional) Personal Access Token para push vía HTTPS

Uso:
  set las variables de entorno y ejecutar:
    .venv\Scripts\python.exe backend\scripts\git_sync_planillas.py

Nota de seguridad: almacenar tokens en variables de entorno es aceptable para pruebas locales;
para producción usa un vault o GitHub App.
"""
import os
import shutil
import subprocess
import sys
from datetime import datetime

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
from routes.calificaciones import PLANILLAS_DIR


def run(cmd, cwd=None, check=True, env=None):
    print('> ', ' '.join(cmd))
    res = subprocess.run(cmd, cwd=cwd, env=env)
    if check and res.returncode != 0:
        raise RuntimeError(f'Comando falló: {cmd} (code {res.returncode})')
    return res.returncode


def ensure_clone(remote, repo_dir, pat=None):
    if os.path.exists(repo_dir) and os.path.isdir(os.path.join(repo_dir, '.git')):
        print('[git] Repo ya clonado, haciendo fetch...')
        run(['git', 'fetch', '--all'], cwd=repo_dir)
        return

    clone_url = remote
    if pat and clone_url.startswith('https://'):
        # insertar token en la URL (temporal)
        clone_url = clone_url.replace('https://', f'https://{pat}@')

    print('[git] Clonando', clone_url)
    run(['git', 'clone', clone_url, repo_dir])


def copy_planillas_to_repo(repo_dir, target_subdir='planillas'):
    src = os.path.abspath(PLANILLAS_DIR)
    dest = os.path.join(os.path.abspath(repo_dir), target_subdir)
    print(f'[sync] Copiando desde {src} a {dest}')
    if not os.path.exists(src):
        raise FileNotFoundError(f'No existe PLANILLAS_DIR: {src}')
    if os.path.exists(dest):
        shutil.rmtree(dest)
    shutil.copytree(src, dest)
    return dest


def main():
    remote = os.environ.get('GIT_REMOTE')
    repo_dir = os.environ.get('GIT_REPO_DIR', os.path.join(ROOT, 'planillas_repo'))
    branch = os.environ.get('GIT_BRANCH', 'planillas')
    user_name = os.environ.get('GIT_USER_NAME')
    user_email = os.environ.get('GIT_USER_EMAIL')
    pat = os.environ.get('GIT_PAT')

    if not remote:
        print('Error: establece la variable de entorno GIT_REMOTE con la URL del repo')
        sys.exit(1)
    if not user_name or not user_email:
        print('Error: establece GIT_USER_NAME y GIT_USER_EMAIL (para atribución de commits)')
        sys.exit(1)

    ensure_clone(remote, repo_dir, pat=pat)

    # Checkout/crear rama
    try:
        run(['git', 'checkout', branch], cwd=repo_dir)
    except Exception:
        run(['git', 'checkout', '-b', branch], cwd=repo_dir)

    # Copiar planillas
    target = copy_planillas_to_repo(repo_dir)

    # Git add/commit
    run(['git', 'add', '-A'], cwd=repo_dir)
    now = datetime.now().strftime('%Y-%m-%d %H:%M')
    msg = f'Planillas sync: {now} (automático)'

    # Commit usando autor explícito
    author = f'{user_name} <{user_email}>'
    try:
        run(['git', 'commit', '--author', author, '-m', msg], cwd=repo_dir)
    except RuntimeError:
        print('[git] No hay cambios para commitear')

    # Push
    push_env = os.environ.copy()
    if pat and remote.startswith('https://'):
        # preparar URL con token temporal para push
        push_url = remote.replace('https://', f'https://{pat}@')
        run(['git', 'remote', 'set-url', 'origin', push_url], cwd=repo_dir)

    run(['git', 'push', 'origin', branch], cwd=repo_dir)

    # Opcional: restaurar remote sin token si lo cambiamos
    if pat and remote.startswith('https://'):
        run(['git', 'remote', 'set-url', 'origin', remote], cwd=repo_dir)

    print('[done] sincronización completada')


if __name__ == '__main__':
    main()
