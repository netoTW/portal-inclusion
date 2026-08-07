# Circuito de evidencia por eventos — motor del modo EVENTO

**Origen:** [ADR-004](../docs/decisiones/ADR-004-evidencia-por-eventos.md). Lo
consumen RF-045/048/049 (checklist, validación, estados) y la fiscalización
(RF-053–056). **Vive en:** /packages/evidencias.

## Entidades
- **Evaluación** {ramo/sección, fecha, docente, estado: programada → confirmada |
  reprogramada}. Origen de la fecha: registrada por el docente, o traída de
  Banner/calendario académico si la integración existe (duda ALTA — baja la fricción
  a casi cero).
- **Vínculo automático**: al existir una evaluación, el sistema asocia los
  estudiantes de esa sección CON apoyos evaluativos aprobados vigentes (cruce
  asignaciones RF-004 × adecuaciones vigentes).
- **Confirmación** {evaluación, estudiante, resultado: rindió_con_ajuste | no_rindió,
  timestamp, confirmador}. La fecha de aplicación efectiva queda CAPTURADA aquí.
- **Reprogramación** {confirmación no_rindió → nueva fecha, pendiente vivo con reloj}.
- **Pendiente de evento** {evaluación pasada sin confirmar, reloj de gracia, estado}.

## Flujo
1. El docente registra su evaluación (o llega por integración): fecha + sección.
2. El sistema muestra en su panel: sus evaluaciones, sus estudiantes con apoyo por
   ramo (SOLO adecuación aprobada y recomendaciones — jamás diagnóstico, regla 1).
3. El día de la evaluación: confirmación 1-click vía enlace directo (patrón de
   atestación del design system): "evaluación tomada" + por estudiante,
   rindió-con-ajuste / no-rindió.
4. `no_rindió` → reprogramación: nueva fecha, pendiente vivo hasta confirmarse.
5. El sistema CRUZA la confirmación contra las condiciones de la resolución del
   estudiante y marca el ítem de evidencia cumplido/incumplido AUTOMÁTICAMENTE (100%,
   sin validación posterior ni muestreo).
6. Evaluación pasada SIN confirmación → pendiente de evento (reloj de gracia
   configurable) → incumplimiento EN TIEMPO REAL hacia RF-054/055/056.

## Panel del docente
Sus evaluaciones (próximas y pasadas), sus estudiantes con apoyo por ramo, sus
pendientes y reprogramaciones. Todo confirmable en segundos; operable por teclado;
axe 0. El panel es también la vista RF-018 de sus atestaciones.

## Modo ATESTACIÓN (el segundo modo, misma maquinaria simplificada)
Para apoyos sin evento evaluativo: el responsable (según el tipo: sede, jefatura)
confirma la implementación con una atestación estructurada {qué se implementó, desde
cuándo, observación} — sin evaluación ni cruce; el ítem queda cumplido al confirmar,
con captura de fecha y autor. Pendientes y recordatorios usan el ciclo del período.

## Reglas duras
- La confirmación es del RESPONSABLE (docente en evento; según tipo en atestación) —
  la sede NO confirma por el docente; puede recordarle (visibilidad de pendientes en
  su tablero RF-046).
- Nada en este circuito expone información clínica al docente (regla 1 intocable):
  el docente ve la adecuación aprobada, nunca la causa.
- Toda confirmación/reprogramación/pendiente → audit.
- Los tres modos conviven en un mismo caso (checklist mixto, RF-045).

## Criterios de aceptación (se detallan en RF-045/048/049 actualizados)
- [ ] CA-1: evaluación registrada → vínculo automático correcto de estudiantes con
      apoyo de esa sección; confirmación 1-click marca cumplido con fecha capturada.
- [ ] CA-2: no_rindió genera reprogramación con pendiente vivo; la nueva confirmación
      lo cierra.
- [ ] CA-3: evaluación pasada sin confirmar dispara pendiente → incumplimiento en
      tiempo real visible en tablero/semáforo (RF-054/056).
- [ ] CA-4 (negativo): el panel docente no contiene ningún campo clínico (vector
      permanente del red team); un docente no confirma evaluaciones de secciones ajenas.
- [ ] CA-5 (accesibilidad): confirmación completa operable por teclado desde el
      enlace directo; axe 0.

## Propiedades (fuzzing)
- P1: todo ítem modo-evento cumplido tiene exactamente una confirmación válida del
  responsable correcto con fecha capturada.
- P2: pendientes de evento nunca se pierden: toda evaluación pasada termina en
  confirmada, reprogramada o incumplimiento visible.

## Dudas (ALTA, en DUDAS.md)
- ¿AIEP está dispuesto a exigir a docentes el registro de fechas y confirmación de
  rendiciones? (condición de adopción del modo evento).
- ¿Las fechas de evaluación existen en Banner/calendario académico para integrarlas?
