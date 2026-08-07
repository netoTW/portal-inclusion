# RF-001 — Tipos de solicitud configurables

**Módulo:** solicitudes
**Prioridad:** crítica
**Depende de:** RF-019 (panel admin), validacion-documental (catálogo de requisitos)
**Inferencia:** del bloque Solicitudes (cap. 7: "tipos de solicitud configurables") y
módulo 1 del cap. 4 ("formularios dinámicos por tipo de apoyo"). Tipos seed [S-15].

## Descripción
GDI define desde el panel los tipos de solicitud disponibles (adecuación menor,
adecuación mayor, cuidados, etc.), cada uno con su proceso, formulario, checklist
documental y reglas de vigencia/renovación. Agregar o modificar un tipo es
configuración, nunca desarrollo.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver el catálogo de tipos VIGENTES con descripción en chileno simple y elegir uno para solicitar |
| Sede (DAE) | ver el catálogo (para orientar estudiantes) |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | ver el catálogo |
| Equipo nacional GDI | crear, editar, habilitar/deshabilitar tipos; TODO |
| Rectoría/Vicerrectorías | nada (los agregados por tipo van vía reportes) |

## Datos que toca
- Entidades: tipo de solicitud {clave, nombre, descripción para el estudiante,
  proceso asociado, formulario, checklist documental (validacion-documental),
  tipo(s) de apoyo resultantes [S-17], renovable sí/no, vigente sí/no}.
- ¿Datos clínicos? NO (el tipo es metadato).

## Flujo principal
1. GDI crea un tipo desde el panel: lo describe, asocia proceso y formulario, arma el
   checklist desde el catálogo de requisitos, marca si es renovable.
2. Lo publica → aparece de inmediato en la vista "Nueva solicitud" del estudiante.
3. Las solicitudes creadas con ese tipo entran al proceso asociado.

## Flujos alternos / casos borde
- Deshabilitar un tipo: no admite solicitudes nuevas; los casos en vuelo terminan su
  ciclo; los borradores existentes de ese tipo avisan al estudiante al retomarlos.
- Editar checklist/formulario de un tipo: versiona junto al proceso (workflow.md);
  solicitudes ya enviadas no cambian de exigencias retroactivamente.
- Tipo sin proceso asociado publicable: imposible (validación).

## Criterios de aceptación
- [ ] CA-1: GDI crea el tipo "Adecuación menor" completo vía panel y un estudiante
      seed lo ve y solicita, sin deploy.
- [ ] CA-2: deshabilitar el tipo lo saca de "Nueva solicitud" sin afectar casos en vuelo.
- [ ] CA-3 (negativo): perfil no-GDI recibe 403 en las rutas de administración de
      tipos + audit.
- [ ] CA-4 (accesibilidad): el catálogo del estudiante (tarjetas/lista de tipos) es
      navegable por teclado, descripciones legibles; axe 0.

## Propiedades (fuzzing)
- P1: toda solicitud referencia un tipo que estaba vigente al momento de crearse.

## Fuera de alcance
- El render del formulario (RF-002) y la validación documental (RF-005).
- El editor de procesos en sí (RF-019).

## Dudas abiertas
- Catálogo real de tipos y su granularidad (¿"adecuación menor" es UN tipo o uno por
  familia de apoyo?) — [S-15], doc extendido.
