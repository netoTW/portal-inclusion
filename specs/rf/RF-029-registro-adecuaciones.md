# RF-029 — Registro de adecuaciones asociado a la resolución

**Módulo:** adecuaciones
**Prioridad:** crítica
**Depende de:** RF-022 (resolución), RF-003 (catálogo de tipos de apoyo [S-17])
**Inferencia:** del bloque Adecuaciones (cap. 7: "asociación a resolución") y módulo
4 del cap. 4 ("registro asociado a la resolución").

## Descripción
Cada adecuación/medida otorgada existe como REGISTRO ESTRUCTURADO nacido de la
resolución firmada: tipo (del catálogo), condiciones exactas de aplicación, ramos o
ámbito donde aplica, vigencia y responsables. Es la fuente única que alimenta el
panel del docente, el checklist de evidencias (RF-045), los avisos (RF-032) y la
renovación (RF-034). No hay adecuación "en el texto de un PDF": lo otorgado es dato.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver SUS adecuaciones vigentes en lenguaje claro |
| Sede (DAE) | ver las de sus casos |
| Jefatura de Escuela | ver las de sus estudiantes (cap. 8 explícito) |
| Docente | ver las de sus asignados: adecuación + recomendaciones, jamás causa |
| Secretaría General | consulta |
| Equipo nacional GDI | administrar el catálogo de adecuaciones; corregir registros (auditado) |
| Rectoría/Vicerrectorías | conteos agregados vía reportes |

## Datos que toca
- Entidades: adecuación otorgada {caso, resolución de origen, tipo (catálogo),
  condiciones, ámbito (ramos/general), vigencia (RF-030), modo de evidencia
  (ADR-004, derivado del tipo), estado}.
- ¿Datos clínicos? NO en el registro: la adecuación describe el AJUSTE, no la causa.
  El vínculo causa↔adecuación vive en el expediente clínico.

## Flujo principal
1. La resolución se firma (RF-024) → sus adecuaciones aprobadas se materializan como
   registros con las condiciones exactas del documento.
2. Cada registro queda vigente según RF-030 y visible en las vistas por perfil.
3. GDI mantiene el catálogo de tipos de adecuación (con su modo de evidencia y
   recomendaciones de aplicación por defecto — editable sin código).

## Flujos alternos / casos borde
- Discrepancia registro↔documento firmado: imposible por construcción (los registros
  se materializan DE los datos que generaron el documento, no se digitan aparte).
- Revocación (caso anulado post-resolución [S-19] o decisión GDI): estado revocada
  con motivo y fecha — historial permanece (RF-035).
- Corrección de un registro (error material): versionada y auditada; si altera lo
  resuelto, exige nueva resolución (no diseñada — duda modificatoria de RF-022).

## Criterios de aceptación
- [ ] CA-1: resolución seed con 2 adecuaciones firmada → 2 registros exactos
      (condiciones, ámbito, vigencia) visibles en cada vista según perfil.
- [ ] CA-2: catálogo editable por GDI; tipo nuevo disponible sin código.
- [ ] CA-3 (negativo): la vista del docente no contiene causa ni diagnóstico (test
      de allowlist + vector red team permanente); docente no ve adecuaciones de no
      asignados.
- [ ] CA-4 (accesibilidad): vistas de adecuaciones navegables por teclado, lenguaje
      claro; axe 0.

## Propiedades (fuzzing)
- P1: toda adecuación otorgada referencia una resolución firmada que la contiene.

## Fuera de alcance
- Vigencia (RF-030), avisos (RF-032), renovación (RF-034), enforcement (RF-036).

## Dudas abiertas
- Catálogo real de adecuaciones y sus condiciones tipo — doc extendido [S-15/S-17].
