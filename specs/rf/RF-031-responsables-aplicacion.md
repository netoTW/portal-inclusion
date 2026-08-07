# RF-031 — Responsables y tareas de aplicación

**Módulo:** adecuaciones
**Prioridad:** crítica
**Depende de:** RF-029, RF-011 (asignación), RF-012 (etapa 5)
**Inferencia:** del bloque Adecuaciones (cap. 7: "responsables") y etapa 5 del PDF
("abre tareas fechadas, registra el acuse de recibo y la comunicación efectiva a
cada docente" — Sede, Escuela y docentes, 3 días hábiles). Meta cap. 11: confirmación
de recepción de sede 100% (hoy 9,6%).

## Descripción
Firmada la resolución, la plataforma abre la etapa de Aplicación con tareas fechadas
y responsables concretos: la sede ACUSA RECIBO del caso (meta 100%), la jefatura
registra el aviso a cada docente (RF-032), y cada adecuación queda con su responsable
de implementación según el tipo (docente para las de aula, sede para accesibilidad,
etc.). Nada queda "comunicado" sin constancia de quién debía hacer qué.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver que su caso está "en aplicación" |
| Sede (DAE) | acusar recibo (1 click), ver sus tareas de aplicación |
| Jefatura de Escuela | sus tareas: registrar aviso a docentes (RF-032) |
| Docente | sus tareas de implementación (desde su panel, evidencia-eventos) |
| Secretaría General | consulta |
| Equipo nacional GDI | ver el estado de aplicación nacional; reasignar |
| Rectoría/Vicerrectorías | agregados |

## Datos que toca
- Entidades: tarea de aplicación {caso, adecuación(es), responsable (rol+persona),
  fecha límite (SLA 3dh), estado, acuse}. El acuse de RECEPCIÓN de la sede es una
  tarea siempre presente.
- ¿Datos clínicos? NO (las tareas hablan de adecuaciones, no de causas).

## Flujo principal
1. Resolución firmada → etapa Aplicación: se abren las tareas fechadas según el tipo
   de cada adecuación (mapa tipo→responsable, catálogo GDI).
2. La sede acusa recibo en 1 click (patrón atestación) — primer hito medible.
3. Cada responsable completa su tarea; los avisos a docentes corren por RF-032; la
   implementación en aula se acredita después por evidencia-eventos (ADR-004).
4. Todas las tareas completas → la etapa avanza (RF-012); vencimientos → RF-016/017.

## Flujos alternos / casos borde
- Docente sin identificar para un ramo (asignación académica incompleta): tarea
  bloqueada visible + alerta (nunca "avisado" sin destinatario real).
- Cambio de docente a mitad de semestre: re-dispara el aviso al nuevo (RF-032) y sus
  tareas; el historial del anterior queda.
- Estudiante sin ramos inscritos aún (inicio de semestre): tareas de aula quedan en
  espera de inscripción, visibles como tales.

## Criterios de aceptación
- [ ] CA-1: resolución firmada seed → tareas correctas por tipo de adecuación con
      fechas SLA; acuse de sede en 1 click queda registrado con timestamp (el
      indicador de recepción sube al 100% en seed).
- [ ] CA-2: tarea sin destinatario resoluble → bloqueada visible + alerta GDI.
- [ ] CA-3 (negativo): las tareas no exponen causa clínica; DAE no ve tareas de otra
      sede; docente solo las suyas.
- [ ] CA-4 (accesibilidad): bandeja de tareas de aplicación operable por teclado,
      acuse accesible; axe 0.

## Propiedades (fuzzing)
- P1: toda adecuación materializada tiene su(s) tarea(s) de aplicación o una espera
  declarada visible — nunca cero rastro.

## Fuera de alcance
- El aviso a docentes en sí (RF-032) y la acreditación de implementación
  (evidencia-eventos/RF-045).

## Dudas abiertas
- Mapa real tipo-de-adecuación → responsable de implementación (seed propone;
  levantamiento confirma).
