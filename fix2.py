import re

with open('backend/backend/templates/modules html/horarios-gestion.html', 'r', encoding='utf-8') as f:
    text = f.read()

repl = {
    'Ã¢â‚¬â€': '—',
    'â†’': '→',
    'â€”': '—'
}
for k,v in repl.items():
    text = text.replace(k,v)

with open('backend/backend/templates/modules html/horarios-gestion.html', 'w', encoding='utf-8') as f:
    f.write(text)

with open('backend/backend/static/js/modules/horarios-gestion.js', 'r', encoding='utf-8') as f:
    textjs = f.read()

repljs = {
    'MiÃ©rcoles': 'Miércoles',
    'MiÃƒÂ©rcoles': 'Miércoles',
    'gestiÃ³n': 'gestión',
    'Ã¢â‚¬â€': '—',
    'â€”': '—',
    'habÃ\xada': 'había',
    'selecciÃ³n': 'selección',
    'botÃ³n': 'botón',
    'Ãº': 'ú',
    'versiÃ³n': 'versión',
    'Ã¡': 'á',
    'Ã©': 'é',
    'Ã³': 'ó',
    'Ã­': 'í',
    'Â©': '©',
    'Â®': '®',
    'Âº': 'º',
}
for k,v in repljs.items():
    textjs = textjs.replace(k,v)

textjs = re.sub(r'ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬*', '─', textjs)
textjs = re.sub(r'Ã¢â€â‚¬Ã¢â€â‚¬*', '─', textjs)
textjs = re.sub(r'ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬', '─', textjs)
textjs = re.sub(r'Ã¢â€”\x84.*', '─', textjs)
textjs = textjs.replace('ÃƒÂ©', 'é')
textjs = textjs.replace('— Todos los grados —', '— Todos los grados —')
textjs = textjs.replace('— Seleccionar docente —', '— Seleccionar docente —')

with open('backend/backend/static/js/modules/horarios-gestion.js', 'w', encoding='utf-8') as f:
    f.write(textjs)
