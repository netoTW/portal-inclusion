# RF-022 — Generación automática de resoluciones

**Módulo:** documentos
**Prioridad:** crítica
**Depende de:** RF-021, RF-012 (transición de decisión), validacion-documental (post-decisión)
**Inferencia:** del bloque Documentos (cap. 7) y etapa 4 del PDF ("genera y firma la
resolución, registra la decisión y asocia las adecuaciones aprobadas" — GDI y
Secretaría General, 5 días hábiles).

## Descripción
Al registrar GDI la decisión (aprobar/rechazar, con 1 click sobre la recomendación —
validacion-documental.md), la plataforma genera la resolución desde la plantilla:
datos del caso, decisión, adecuaciones aprobadas con sus condiciones, fundamento.
El documento nace asociado al caso, entra al flujo de firma (RF-024) y, firmado,
dispara la notificación al estudiante y la etapa de Aplicación. Hoy: generar
resoluciones a mano es parte del cuello de botella del equipo nacional.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver/descargar SU resolución firmada (RF-026) |
| Sede (DAE) | ver resoluciones de casos de su sede |
| Jefatura de Escuela | ver resoluciones de sus estudiantes (cap. 8 lo dice explícito) |
| Docente | NO ve la resolución completa — recibe las adecuaciones vigentes vía módulo adecuaciones |
| Secretaría General | revisar el documento generado, firmarlo (RF-024) |
| Equipo nacional GDI | registrar decisión, regenerar antes de firma |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: resolución {caso, decisión, plantilla+versión, contenido generado,
  estado: generada → en_firma → firmada, folio de resolución (RF-028)}.
- ¿Datos clínicos? El documento NO contiene diagnósticos (garantizado por RF-021);
  el FUNDAMENTO clínico de la decisión queda en el expediente (clinical), no en la
  resolución que circula.

## Flujo principal
1. GDI registra la decisión (click sobre recomendación, o decisión contraria con
   motivo — validacion-documental).
2. La plataforma genera la resolución desde la plantilla vigente, asociando las
   adecuaciones aprobadas con sus condiciones exactas (insumo del checklist de
   evidencias, RF-045).
3. El documento queda "generada" → entra a la cola de firma de Secretaría (RF-024).
4. Firmada → notificación automática al estudiante con el documento (post-decisión de
   punta a punta) → dispara etapa de Aplicación.

## Flujos alternos / casos borde
- Regeneración pre-firma (GDI corrige la decisión o un dato): versión nueva del
  documento (RF-025), la anterior queda en historial; post-firma NO se regenera —
  el camino es una resolución modificatoria (nuevo documento que referencia la
  original — ver dudas).
- Rechazo: genera carta de rechazo (RF-023) con fundamento no clínico y vías de
  re-solicitud.
- Decisión sobre caso anulado a mitad del trámite: imposible (RF-012, terminal).

## Criterios de aceptación
- [ ] CA-1: decisión de aprobación seed → resolución generada con las adecuaciones y
      condiciones correctas, en cola de firma; firmada → estudiante notificado con
      documento y etapa de Aplicación abierta (flujo completo sin intervención).
- [ ] CA-2: regeneración pre-firma versiona; intento post-firma → rechazado (el
      camino modificatorio queda registrado como duda hasta levantamiento).
- [ ] CA-3 (negativo): la resolución generada no contiene NINGÚN campo clínico (test
      de contenido sobre corpus seed); docente no accede al documento (403 + audit).
- [ ] CA-4 (accesibilidad): el PDF generado es estructurado (texto real, encabezados,
      no imagen) — legible por lector de pantalla; axe 0 en las vistas.

## Propiedades (fuzzing)
- P1: toda decisión registrada produce exactamente un documento de resolución activo
  (con historial de versiones pre-firma).

## Fuera de alcance
- Flujo de firma (RF-024), folio oficial (RF-028), cartas y otros documentos (RF-023).

## Dudas abiertas
- ¿Existe la "resolución modificatoria" como figura institucional (cambiar una
  resolución firmada)? Hoy: no diseñada; post-firma solo vía caso complementario o
  nueva resolución — confirmar en levantamiento.
