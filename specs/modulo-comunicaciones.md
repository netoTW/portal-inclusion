# Módulo Comunicaciones — índice (RF-063 a RF-070)

**El último bloque RF y el sistema circulatorio de todos los demás:** cada "notifica",
"avisa", "recuerda" y "acusa" de las tandas anteriores se materializa aquí. Principio
rector (cap. 4, módulo 8): **"el correo avisa; el trabajo ocurre en la plataforma"** —
y su corolario del cap. 2: la sobrecarga de correos es la barrera nº1, así que el
volumen se gobierna (RF-070), no solo se automatiza.
**ADVERTENCIA DE INFERENCIA:** nombres y reparto inferidos del bloque del cap. 7,
módulo 8 del cap. 4 y el pedido de las sedes (cap. 2). Specs ancladas a capacidad.

## Los 8 RF y su orden interno de construcción
| RF | Nombre (inferido) | Prioridad | Depende de |
|---|---|---|---|
| [RF-064](rf/RF-064-plantillas-comunicaciones.md) | Plantillas administrables | crítica | patrón RF-021 |
| [RF-063](rf/RF-063-catalogo-eventos-notificacion.md) | Catálogo de eventos de notificación | crítica | workflow, RF-064 |
| [RF-065](rf/RF-065-motor-envio.md) | Motor de envío multicanal | crítica | RF-063/064 |
| [RF-066](rf/RF-066-registro-envios-acuses.md) | Registro de envíos y acuses | crítica | RF-065, audit |
| [RF-067](rf/RF-067-bandeja-notificaciones.md) | Bandeja en la plataforma (campana) | alta | RF-065 |
| [RF-068](rf/RF-068-comunicacion-del-caso.md) | Espacio de comunicación del caso | crítica | RF-065, authz |
| [RF-069](rf/RF-069-notas-internas.md) | Notas internas de gestión | alta | RF-068 |
| [RF-070](rf/RF-070-preferencias-digest.md) | Agrupación y preferencias (anti-spam) | alta | RF-063/065 |

## Cobertura del texto del PDF
| Término | RF dueño |
|---|---|
| "Avisos automáticos de todo el ciclo" (cap. 7) | RF-063 (matriz) + RF-065 (envío) |
| "mediante plantillas administrables" (cap. 7/4) | RF-064 |
| "con registro de envíos y acuses" (cap. 7) / "registro de envíos" (cap. 4) | RF-066 |
| "El correo avisa; el trabajo ocurre en la plataforma" (cap. 4) | RF-065 + RF-067 |
| "Notificaciones automáticas de cambio de estado" (pedido sedes, cap. 2) | RF-063 |
| "Espacio de comunicación dentro del sistema" (pedido sedes, cap. 2) | RF-068 |
| "Notas internas de gestión" (cap. 8, exclusión del estudiante) | RF-069 |
| Sobrecarga de correos = barrera nº1 (cap. 2) | RF-070 |

## Reglas transversales del módulo
- Ningún aviso/correo/digest contiene datos clínicos ni sensibles — el correo es el
  canal menos controlado; asunto neutro + folio + deep link autenticado (RF-064/065;
  en cuidados ni siquiera el nombre del proceso — RF-040).
- Avisos de sistema no desactivables (acuses, aviso docente, escalamientos) — RF-063.
- El estudiante ve TODO lo que se le dirige (hilo con él, sus avisos); lo interno es
  interno por régimen (RF-068/069), no por omisión.
- Las metas de constancia del cap. 11 se PRUEBAN con RF-066 (acuses reales, no envíos).

## Dudas del módulo elevadas a DUDAS.md
- ¿Correo institucional o personal del estudiante? (RF-065 — cambia el análisis del canal)
- Política ante solicitud de acceso del estudiante a notas internas (21.719/ADR-003) (RF-069)
- Detección activa de datos sensibles en hilos vs advertencia + redacción GDI (RF-068)
- Frecuencias de digest preferidas por las DAE reales (RF-070) · SLA de respuesta al estudiante en hilos (RF-068)
