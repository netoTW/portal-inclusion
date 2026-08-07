# RF-023 — Cartas y comunicaciones formales

**Módulo:** documentos
**Prioridad:** alta
**Depende de:** RF-021, RF-022 (patrón), RF-014 (antecedentes)
**Inferencia:** del módulo 3 del cap. 4: "cartas de aprobación y rechazo, solicitudes
de antecedentes e informes". Todo documento formal distinto de la resolución.

## Descripción
La plataforma genera automáticamente los documentos formales del ciclo distintos de
la resolución: carta de aprobación (versión comunicable de la resolución), carta de
rechazo (con fundamento no clínico y vías de re-solicitud), solicitud formal de
antecedentes (el documento que respalda RF-014) e informes de caso o de período a
demanda de GDI. Mismos cimientos: plantillas RF-021, versionado RF-025.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | recibir/descargar SUS cartas |
| Sede (DAE) | ver cartas de casos de su sede; solicitar informes de su sede |
| Jefatura de Escuela | ver cartas dirigidas a su rol |
| Docente | nada (sus avisos son del módulo comunicaciones, no cartas formales) |
| Secretaría General | firmar las cartas que lo requieran (config por tipo) |
| Equipo nacional GDI | generar todo; configurar qué tipos exigen firma |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: documento formal {tipo, caso/alcance, plantilla+versión, contenido,
  destinatarios, requiere_firma (config), estado}.
- ¿Datos clínicos? NO en el contenido (RF-021 lo garantiza). La carta de rechazo es
  el caso delicado: fundamento en términos administrativos/normativos, JAMÁS
  diagnóstico ("no acompaña certificado vigente", no "su condición no califica").

## Flujo principal
1. Un evento del proceso dispara la carta (aprobación/rechazo tras firma de
   resolución; solicitud de antecedentes al activarse RF-014) o GDI la genera a
   demanda (informes).
2. Generación desde plantilla + (si el tipo lo exige) cola de firma RF-024.
3. Entrega por el canal del proceso (notificación con documento, RF-063+) y archivo
   en el expediente (RF-027).

## Flujos alternos / casos borde
- Informes con alcance agregado (período/sede): respetan el perfil del solicitante
  (un informe pedido por DAE solo contiene su sede).
- Carta a destinatario externo al sistema (ej. Dirección de Sede [S-08]): se emite
  por correo con registro; el documento vive en la plataforma.
- Tipos de carta nuevos: crear plantilla + asociar a evento del proceso vía
  configuración (RF-019/021) — sin código.

## Criterios de aceptación
- [ ] CA-1: rechazo seed → carta generada con fundamento no clínico y vías de
      re-solicitud, entregada y archivada; el texto proviene de la plantilla vigente.
- [ ] CA-2: solicitud de antecedentes (RF-014) queda respaldada por su documento
      formal en el expediente.
- [ ] CA-3 (negativo): corpus de cartas generadas en seed no contiene términos del
      catálogo clínico ni campos del esquema clinical (test de contenido); informes
      respetan scoping del solicitante.
- [ ] CA-4 (accesibilidad): PDFs estructurados; vistas de generación operables por
      teclado; axe 0.

## Propiedades (fuzzing)
- P1: todo documento formal entregado tiene su registro de entrega y su copia en el
  expediente (nunca "se envió" sin respaldo).

## Fuera de alcance
- Notificaciones no formales (módulo comunicaciones, RF-063+).
- Resolución (RF-022) y firma (RF-024).

## Dudas abiertas
- Catálogo institucional de cartas/informes y cuáles exigen firma de Secretaría —
  doc extendido/levantamiento (seed: aprobación y rechazo con firma; antecedentes sin).
