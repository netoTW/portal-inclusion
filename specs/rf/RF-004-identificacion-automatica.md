# RF-004 — Identificación automática del estudiante

**Módulo:** solicitudes
**Prioridad:** crítica
**Depende de:** contracts (BannerAdapter, IdentityAdapter), RF-003
**Inferencia:** del módulo 1 del cap. 4 ("identificación automática del estudiante") y
etapa 2 del cap. 6 ("identifica al estudiante"). Sistema académico = Banner [S-06].

## Descripción
El estudiante entra autenticado (SSO institucional; login dev en desarrollo) y la
plataforma trae sola su identidad y contexto académico: RUT, nombre, matrícula vigente,
sede, escuela, carrera y asignaturas. No digita nada de eso — imposible equivocarse de
sede (la raíz de las 32 variantes muere aquí).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver SUS datos académicos precargados; reportar que un dato viene mal (no editarlo) |
| Sede (DAE) | ver datos académicos de estudiantes con caso en su sede |
| Jefatura de Escuela | ver datos académicos de sus estudiantes |
| Docente | ver identificación mínima de sus asignados (nombre, carrera; nunca más) |
| Secretaría General | ver datos académicos al resolver |
| Equipo nacional GDI | ver todo; forzar re-sincronización de un estudiante |
| Rectoría/Vicerrectorías | nada individual |

## Datos que toca
- Entidades: perfil académico del estudiante (espejo local del adapter, con fecha de
  sincronización), vínculo usuario-autenticado ↔ estudiante.
- ¿Datos clínicos? NO (identidad y matrícula son `public`).

## Flujo principal
1. Primer ingreso: la plataforma resuelve al estudiante contra BannerAdapter por su
   identidad SSO, crea el perfil espejo y lo muestra para confirmación visual.
2. Al crear una solicitud, sede/escuela/carrera se toman del perfil espejo (RF-002
   los precarga, solo lectura).
3. El perfil se refresca: al iniciar una solicitud nueva y por job periódico; cada
   sincronización queda auditada con diff.

## Flujos alternos / casos borde
- Sin matrícula vigente: mensaje claro ("no encontramos matrícula vigente; contacta a
  tu sede") y NO puede crear solicitud — ver duda (¿postulantes/congelados?).
- No resuelto en Banner (inconsistencia): tarea a GDI, el estudiante no queda en un
  callejón sin salida (pantalla con siguiente paso humano).
- Cambio de sede a mitad de un caso: el caso conserva la sede de ORIGEN para su
  gestión (el scoping no salta); el perfil espejo se actualiza; GDI decide si migrar
  el caso de sede (acción explícita auditada). [Regla inferida — ver dudas.]
- Adapter caído: los datos espejo siguen sirviendo (con fecha visible); crear
  solicitud sigue posible; la re-validación corre al volver el servicio.

## Criterios de aceptación
- [ ] CA-1: estudiante seed entra por login dev → su solicitud nueva trae sede/escuela/
      carrera correctas precargadas y no editables.
- [ ] CA-2: estudiante sin matrícula vigente recibe el mensaje y no puede enviar.
- [ ] CA-3 (negativo): docente pide el perfil académico completo de un asignado → solo
      identificación mínima; campos de contacto/estado de matrícula no viajan.
- [ ] CA-3b (negativo): DAE no resuelve perfiles de estudiantes sin caso en su sede.
- [ ] CA-4 (accesibilidad): la confirmación de identidad es legible y navegable por
      teclado; axe 0.

## Propiedades (fuzzing)
- P1: todo caso referencia un estudiante con perfil espejo existente; la sede del caso
  es la del perfil AL MOMENTO de crearlo (invariante de scoping histórico).

## Fuera de alcance
- SSO real (specs/sso-m365.md) y el mock de Banner (specs/mock-banner.md).
- Progresión académica (ProgresionAdapter, módulo reportes).

## Dudas abiertas
- ¿Pueden solicitar estudiantes SIN matrícula vigente (postulantes, congelados,
  en proceso de matrícula)? Hoy: no.
- ¿Regla institucional ante cambio de sede con caso abierto? Hoy: caso queda en sede
  de origen salvo migración explícita de GDI.
