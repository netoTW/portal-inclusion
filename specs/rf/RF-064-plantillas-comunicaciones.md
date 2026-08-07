# RF-064 — Plantillas administrables de comunicaciones

**Módulo:** comunicaciones
**Prioridad:** crítica
**Depende de:** RF-063, patrón RF-021 (plantillas de documentos)
**Inferencia:** EXPLÍCITO: "plantillas administrables por el equipo funcional"
(cap. 4, módulo 8; cap. 7).

## Descripción
El texto de cada aviso (asunto, cuerpo, botón de acción) es una plantilla que el
equipo funcional (GDI) edita desde el panel: campos de combinación tipados, vista
previa con caso seed, versionada. Mismo patrón que RF-021 con el matiz de canal:
variante correo (HTML simple) y variante campana (corta), editadas juntas.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Equipo nacional GDI | crear/editar/publicar plantillas |
| Secretaría General | consulta |
| (resto) | nada |

## Datos que toca
- Entidades: plantilla de aviso {clave, variantes por canal, campos, versión}.
- ¿Datos clínicos? PROHIBIDO por catálogo de campos (idéntico a RF-021): ningún
  aviso puede combinar diagnóstico, condición ni contenido clínico — los avisos
  refieren folio, tipo de pendiente y deep link (regla verificada por test de
  corpus en RF-016 CA-3, RF-032 CA-3, RF-044 CA-3).

## Flujo principal
1. GDI edita con vista previa por canal (correo y campana) sobre un caso seed.
2. Validación: campos existentes, no clínicos, deep link presente cuando la regla
   lo exige (todo aviso accionable lleva SU link — "el correo avisa, el trabajo
   ocurre en la plataforma").
3. Publica → versión nueva; los envíos ya emitidos conservan la versión con que
   salieron (registro RF-066).

## Flujos alternos / casos borde
- Tono y lenguaje: chileno claro; plantillas dirigidas a estudiantes en registro
  cercano, a autoridades en registro formal — la guía de estilo vive en el manual
  del panel (contenido GDI).
- Plantilla usada por regla activa: no eliminable (versionar/deshabilitar).
- Largo de campana: la variante corta tiene límite validado (una notificación no es
  un ensayo).

## Criterios de aceptación
- [ ] CA-1: editar la plantilla del acuse de recibo cambia el siguiente envío sin
      deploy; el registro del envío anterior conserva su versión.
- [ ] CA-2: plantilla sin deep link para regla accionable no publica; campo clínico
      no publica.
- [ ] CA-3 (negativo): no-GDI 403 en el panel + audit.
- [ ] CA-4 (accesibilidad): correos generados con HTML accesible (texto real,
      contraste, alt); el editor operable por teclado; axe 0.

## Propiedades (fuzzing)
- P1: ningún aviso renderizado contiene marcadores sin resolver ni campos clínicos
  (espejo de RF-021 P1 sobre el corpus de avisos).

## Fuera de alcance
- La matriz de reglas (RF-063) y el envío (RF-065).

## Dudas abiertas
- ¿Textos institucionales aprobados por comunicaciones AIEP? (seed marcado
  provisional).
