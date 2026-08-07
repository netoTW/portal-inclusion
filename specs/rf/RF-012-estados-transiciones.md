# RF-012 — Estados del caso y cambio de estado automático

**Módulo:** workflow
**Prioridad:** crítica
**Depende de:** — (es la base del módulo; usa authz, audit, sla-engine)
**Inferencia:** inferido del bloque Workflow (cap. 7: "cambio de estado automáticos…
aprobaciones y rechazos") y del motor de specs/workflow.md. Reconciliar con doc extendido.

## Descripción
Todo caso vive en una máquina de estados definida por METADATOS de su proceso (etapas,
transiciones, guardas). Los cambios de estado ocurren automáticamente al cumplirse las
condiciones (documentos completos, decisión registrada, plazo vencido) o por acción
autorizada de un responsable. Nadie mueve un caso "por fuera".

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver el estado de sus casos; desistir antes de resolución firmada [S-19] |
| Sede (DAE) | ejecutar transiciones de su responsabilidad en casos de SU sede |
| Jefatura de Escuela | ejecutar sus transiciones (ej. registrar aviso a docentes) |
| Docente | ejecutar sus atestaciones (según S-04) |
| Secretaría General | transiciones de resolución y cierre administrativo [S-09] |
| Equipo nacional GDI | todas las transiciones + anulación administrativa [S-19] |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: caso (etapa activa, sub-estado en_espera, terminales cerrado/anulado),
  historia de transiciones, definición de proceso (versionada).
- ¿Datos clínicos? NO directamente (las guardas evalúan metadatos, ej. "checklist
  completo", nunca contenido clínico).

## Flujo principal
1. Ocurre un evento (acción de usuario autorizada, condición cumplida, timer SLA).
2. El motor busca la transición aplicable en la definición (versión del caso) y evalúa
   guardas: permiso authz + condiciones de datos.
3. Ejecuta: cambia etapa, dispara acciones configuradas (asignar RF-011, notificar,
   generar documento, abrir tareas), reinicia/pausa relojes según sla-engine.
4. Registra transición completa en audit (actor, evento, guardas evaluadas).

## Flujos alternos / casos borde
- Guarda no satisfecha → rechazo con motivo legible; nada cambia; intento auditado.
- Estudiante congela/se retira a mitad de proceso → anulación según workflow.md [S-19].
- Vencimiento de SLA NO fuerza transición por defecto: marca atrasado y escala (RF-017),
  salvo que la etapa configure otra cosa (`al_vencer`).
- Estados terminales (cerrado, anulado): rechazan toda transición posterior (P5 de workflow.md).
- Renovación semestral: instancia hija creada por recurrencia (workflow.md [S-05]).

## Criterios de aceptación
- [ ] CA-1: recorrido completo del proceso seed (7 etapas) con los actores correctos
      deja la historia exacta esperada en audit.
- [ ] CA-2: transición con guarda insatisfecha (checklist incompleto) → rechazo con
      motivo; el caso no se mueve.
- [ ] CA-3 (negativo): docente autenticado intenta ejecutar una transición de GDI vía
      API → 403 + audit. DAE de sede A no transiciona casos de sede B.
- [ ] CA-3b (negativo): no existe transición que lleve a "cerrado" sin evidencia
      validada cuando el proceso la exige (regla de oro; ver CA-4 de workflow.md).
- [ ] CA-4 (accesibilidad): las acciones de transición en la UI (botones de decisión,
      atestaciones) son operables por teclado y anuncian su resultado (aria-live); axe 0.

## Propiedades (fuzzing)
- P1: exactamente una etapa activa por caso, siempre (workflow.md P1).
- P2: toda transición ejecutada existe en la definición de la versión del caso (P2).
- P3: terminales no admiten transiciones (P5).

## Fuera de alcance
- Semántica de plazos (RF-015/sla-engine) y contenido de notificaciones (RF-063+).
- Editor de definiciones (RF-019).

## Dudas abiertas
- ¿Aprobaciones/rechazos parciales (aprobar unas adecuaciones y rechazar otras en el
  mismo caso)? El PDF no lo dice; asumimos DECISIÓN ÚNICA por caso — impacta RF-029+.
  Respaldo del supuesto: el cap. 1 del PDF registra las solicitudes como unidad binaria
  (391 aprobadas de 541) y las solicitudes COMPLEMENTARIAS (22,7%) son el mecanismo
  existente para apoyos adicionales: la operación actual de AIEP ya funciona con
  decisión única por solicitud. La duda al levantamiento se mantiene.
