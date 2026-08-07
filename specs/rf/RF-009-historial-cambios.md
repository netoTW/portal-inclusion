# RF-009 — Historial de cambios de la solicitud

**Módulo:** solicitudes
**Prioridad:** alta
**Depende de:** RF-002, audit, RF-018 (complementario)
**Inferencia:** del bloque Solicitudes (cap. 7: "historial de cambios"). Lo
distinguimos de RF-018 (acciones/eventos del caso): esto es el versionado del
CONTENIDO — qué valores tenía la solicitud y cómo cambiaron.

## Descripción
Todo cambio al contenido de una solicitud después de enviada —documentos agregados por
antecedentes (RF-014), correcciones de catálogo por GDI, datos académicos
re-sincronizados— queda versionado: qué campo, valor anterior, valor nuevo, quién y
cuándo. La solicitud siempre puede leerse "como fue enviada" y "como está hoy".

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver el historial de SU solicitud (campos no internos) |
| Sede (DAE) | ver historial no-clínico de casos de su sede [S-20] |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | ver historial al resolver (clínico vía clinical_gate) |
| Equipo nacional GDI | ver todo; efectuar correcciones (siempre versionadas) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: versiones del contenido de la solicitud (snapshot o diff por campo,
  respaldadas en audit — una sola fuente de verdad, audit.md).
- ¿Datos clínicos? Los diffs de campos sensibles viven en `clinical` y siguen la regla
  de referencias opacas de audit.md para quien no cruza el gate.

## Flujo principal
1. La solicitud enviada fija su versión 1 ("como fue enviada", inmutable).
2. Cada cambio posterior crea versión nueva con diff, autor y motivo (obligatorio para
   correcciones manuales de GDI).
3. La vista de la solicitud ofrece "ver historial": línea de versiones comparables
   (v1 vs actual, o cualquier par).

## Flujos alternos / casos borde
- El estudiante NO edita su solicitud enviada: solo agrega lo pedido vía RF-014
  (cada aporte = versión nueva). Si necesita corregir algo de fondo → observación a
  su sede/GDI, que corrige con motivo.
- Re-sincronización académica (RF-004) que cambia un dato del espejo: genera versión
  con autor "Plataforma (sincronización)".
- Fusión de catálogos (RF-003): el re-mapeo masivo aparece en el historial de cada
  solicitud afectada con referencia a la operación.

## Criterios de aceptación
- [ ] CA-1: agregar un documento por RF-014 y una corrección de catálogo por GDI
      produce v2 y v3 con diffs, autores y motivos correctos; v1 sigue íntegra.
- [ ] CA-2: la comparación v1 ↔ actual muestra exactamente los campos cambiados.
- [ ] CA-3 (negativo): en el historial visible para DAE no aparecen valores de campos
      sensibles (referencia opaca); para Docente/Jefatura el historial no existe (403).
- [ ] CA-4 (accesibilidad): la vista de comparación es una tabla semántica navegable
      por teclado (no un diff visual por color solamente); axe 0.

## Propiedades (fuzzing)
- P1: para toda secuencia de cambios, reconstruir desde v1 + diffs = estado actual
  (consistencia con audit P4).
- P2: las versiones son inmutables: ningún cambio altera una versión previa.

## Fuera de alcance
- Eventos del caso (RF-018) y bitácora inmutable (audit.md) — esto es la CAPA de
  contenido sobre ellas.
- Versionado de documentos generados (resoluciones — RF-021+).

## Dudas abiertas
- ¿El estudiante debe poder pedir formalmente una rectificación de datos desde la
  plataforma (derecho ARCO/21.719)? Hoy: canal vía observación a sede; formalizarlo
  depende del levantamiento jurídico (ADR-003).
