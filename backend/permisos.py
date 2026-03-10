# ════════════════════════════════════════════════════════════════════════════════
# SISTEMA DE PERMISOS Y ROLES
# ════════════════════════════════════════════════════════════════════════════════

ROLES_DISPONIBLES = {
    'server_admin': {
        'nombre': 'Administrador del Sistema',
        'permisos': {
            'crear_usuario': True,
            'editar_usuario': True,
            'borrar_usuario': True,
            'crear_estudiante': True,
            'editar_estudiante': True,
            'borrar_estudiante': True,
            'crear_calificacion': True,
            'editar_calificacion': True,
            'borrar_calificacion': True,
            'crear_grado': True,
            'editar_grado': True,
            'borrar_grado': True,
            'crear_materia': True,
            'editar_materia': True,
            'borrar_materia': True,
            'crear_planilla': True,
            'editar_planilla': True,
            'borrar_planilla': True,
            'ver_reportes': True,
            'generar_reportes': True,
            'acceso_administrativo': True,
        }
    },
    # ROL: Rector (id_rol=1) - Mismo nombre que en BD
    'Rector': {
        'nombre': 'Rector',
        'permisos': {
            'crear_usuario': True,
            'editar_usuario': True,
            'borrar_usuario': True,
            'crear_estudiante': True,
            'editar_estudiante': True,
            'borrar_estudiante': True,
            'crear_calificacion': True,  
            'editar_calificacion': True,
            'borrar_calificacion': True,
            'crear_grado': True,
            'editar_grado': True,
            'borrar_grado': True,
            'crear_materia': True,
            'editar_materia': True,
            'borrar_materia': True,
            'crear_planilla': True,
            'editar_planilla': True,
            'borrar_planilla': True,
            'ver_reportes': True,
            'generar_reportes': True,
            'acceso_administrativo': True,
        }
    },
    # ROL: Coordinador (id_rol=2) - Mismo nombre que en BD
    'Coordinador': {
        'nombre': 'Coordinador Académico',
        'permisos': {
            'crear_usuario': True,
            'editar_usuario': True,
            'borrar_usuario': True,
            'crear_estudiante': True,
            'editar_estudiante': True,
            'borrar_estudiante': True,
            'crear_calificacion': True,
            'editar_calificacion': True,
            'borrar_calificacion': True,
            'crear_grado': True,
            'editar_grado': True,
            'borrar_grado': True,
            'crear_materia': True,
            'editar_materia': True,
            'borrar_materia': True,
            'crear_planilla': True,
            'editar_planilla': True,
            'borrar_planilla': True,
            'ver_reportes': True,
            'generar_reportes': True, 
            'acceso_administrativo': True,
        }
    },
    # ROL: Profesor (id_rol=4) - Mismo nombre que en BD
    'Profesor': {
        'nombre': 'Profesor',
        'permisos': {
            'crear_usuario': False,
            'editar_usuario': False, 
            'borrar_usuario': False,
            'crear_estudiante': True, 
            'editar_estudiante': True, 
            'borrar_estudiante': True, 
            'crear_calificacion': True,
            'editar_calificacion': True,
            'borrar_calificacion': True,
            'crear_grado': True,
            'editar_grado': True,
            'borrar_grado': True, 
            'crear_materia': True, 
            'editar_materia': True,
            'borrar_materia': True, 
            'crear_planilla': True, 
            'editar_planilla': True,
            'borrar_planilla': True,
            'ver_reportes': True, 
            'generar_reportes': True, 
            'acceso_administrativo': True, 
        }
    }
}

def tiene_permiso(user_role, permiso):
    """Verifica si un rol tiene un permiso específico"""
    if user_role not in ROLES_DISPONIBLES:
        return False
    
    permisos = ROLES_DISPONIBLES[user_role]['permisos']
    return permisos.get(permiso, False)

def puede_borrar(user_role):
    """Verifica si un rol puede borrar datos"""
    return user_role in ['server_admin', 'Rector']

def puede_editar(user_role):
    """Verifica si un rol puede editar datos"""
    return user_role in ['server_admin', 'Rector', 'Coordinador', 'Profesor']
