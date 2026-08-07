# RF-039 — Evaluación y resolución de cuidados

**Módulo:** cuidados
**Prioridad:** crítica
**Depende de:** RF-038, validacion-documental (dos niveles), RF-022/024 (resolución y firma)
**Inferencia:** del bloque Cuidados (cap. 7: "evaluación, resolución") con la misma
arquitectura de decisión del proceso principal: el sistema recomienda, GDI decide,
Secretaría firma (prohibido decidir automático sobre datos sensibles —
validacion-documental.md/ADR-003).

## Descripción
La evaluación del caso de cuidados sigue el patrón de dos niveles: admisibilidad
automática (RF-038) y decisión humana asistida — el sistema pre-evalúa contra
criterios configurables de la situación de cuidado y recomienda; GDI decide en 1
click; la resolución de cuidados se genera y firma con la misma maquinaria de
documentos (RF-022/024), asociando las MEDIDAS otorgadas (RF-040).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver estado; recibir su resolución (RF-026) |
| Sede (DAE) | ver estado del caso de su sede |
| Jefatura de Escuela | nada en la evaluación |
| Docente | nada |
| Secretaría General | firmar la resolución de cuidados |
| Equipo nacional GDI | evaluar (clinical_gate) y decidir |
| Rectoría/Vicerrectorías | agregados |

## Datos que toca
- Entidades: evaluación de cuidados {criterios aplicados, recomendación, decisión,
  motivo}, resolución de cuidados (RF-022 con plantilla propia).
- ¿Datos clínicos? El fundamento SÍ (queda en clinical); la resolución NO (RF-021:
  la resolución dice las medidas, jamás la situación de salud del tercero — circula
  a más ojos).

## Flujo principal
1. Checklist completo → el caso llega a evaluación con la pre-evaluación del sistema
   (criterios configurables del catálogo de cuidados).
2. GDI revisa antecedentes (gate con propósito), decide en 1 click (o contrario a la
   recomendación, con motivo).
3. Resolución generada desde plantilla propia → firma Secretaría (RF-024) → folio
   (RF-028) → notificación con documento → medidas materializadas (RF-040).
4. Rechazo → carta con fundamento NO sensible (no expone la situación del tercero)
   y vías de re-solicitud (RF-023).

## Flujos alternos / casos borde
- Antecedentes insuficientes → devolución automática (RF-014, misma maquinaria).
- SLA propios del proceso 2: configurables; seed calca los del principal (5dh
  evaluación) hasta el levantamiento.
- La decisión NUNCA es automática (mismo hard-stop del proceso principal —
  doblemente crítico con datos de terceros).

## Criterios de aceptación
- [ ] CA-1: flujo completo seed: checklist completo → recomendación → decisión 1
      click → resolución firmada con medidas asociadas → estudiante notificado.
- [ ] CA-2: la resolución y la carta de rechazo no contienen datos de salud del
      estudiante ni del tercero (test de corpus — plantillas RF-021 lo garantizan).
- [ ] CA-3 (negativo): no existe ruta de aprobación/rechazo automática para
      cuidados (barrido de endpoints); decidir sin cruzar el gate de antecedentes
      queda registrado como decisión sin revisión (visible en auditoría).
- [ ] CA-4 (accesibilidad): vista de evaluación y decisión operable por teclado;
      axe 0.

## Propiedades (fuzzing)
- P1: toda decisión de cuidados tiene actor humano GDI y (si aprueba) resolución
  firmada antes de materializar medidas (espejo de RF-029 P1 para el proceso 2).

## Fuera de alcance
- Medidas y su vigencia (RF-040), seguimiento (RF-041).
- Criterios de evaluación reales (configurables; doc extendido/levantamiento).

## Dudas abiertas
- Criterios institucionales de elegibilidad de cuidados (¿exige RSH? ¿tramos?) —
  levantamiento.
