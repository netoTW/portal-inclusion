# ADR-004 — Evidencia por eventos, no solo documental

**Fecha:** 07-08-2026
**Estado:** aceptada
**Decisores:** Pablo Herrera (dirección)

## Contexto

El diseño inicial del módulo Evidencias (Tanda 3) trataba la evidencia como un
documento subido a posteriori por la sede y validado estructuralmente (formato,
fecha, coherencia — S-21). Ese modelo hereda el flujo actual de AIEP (correos con
adjuntos) aunque lo automatice. Sus límites: la "fecha de aplicación efectiva" (meta
100%, hoy 0%) seguiría siendo DECLARADA, no capturada; la validación de fondo depende
de muestreo; y la evidencia llega semanas después del hecho que acredita.

El grueso del volumen (85,8% adecuaciones menores) es de apoyos EVALUATIVOS: el hecho
a acreditar es "el estudiante rindió su evaluación con el ajuste aplicado" — un
EVENTO con fecha, ramo, docente y estudiante conocidos por el sistema.

## Decisión

La evidencia pasa a ser primariamente EL REGISTRO ESTRUCTURADO DEL EVENTO DE
APLICACIÓN. Cada tipo de apoyo declara en su configuración su **modo de evidencia**:

- **Modo EVENTO** (apoyos evaluativos, el grueso): el docente registra la fecha de su
  evaluación; el sistema conoce sus estudiantes con apoyos aprobados en ese ramo; el
  día de la evaluación el docente confirma en 1 click (patrón de atestación del
  design system): evaluación tomada + por estudiante, rindió con el ajuste / no
  rindió (→ reprogramación con nueva fecha y pendiente vivo). El sistema cruza la
  confirmación contra las condiciones de la resolución y marca cumplido/incumplido
  AUTOMÁTICAMENTE, al 100%. La fecha de aplicación pasa de declarada a CAPTURADA.
- **Modo ATESTACIÓN** (apoyos sin evento evaluativo: material adaptado,
  accesibilidad, acompañamientos): confirmación estructurada simple del responsable.
- **Modo DOCUMENTAL** (residual): el diseño de carga + validación estructural
  (RF-047/048) se mantiene; el muestreo con ronda registrada queda acotado SOLO a
  este modo.

Circuito de eventos: `specs/evidencia-eventos.md` (entidad evaluación, vínculos,
confirmaciones, reprogramaciones, pendientes con reloj, panel docente).

## Consecuencias

- (+) La meta "100% fecha de aplicación registrada" se cumple POR DISEÑO en modo
  evento, no por disciplina administrativa.
- (+) Incumplimientos capturados en TIEMPO REAL (evaluación pasó sin confirmación)
  alimentan semáforo/arrastre/escalamiento sin esperar el cierre del período.
- (+) El muestreo humano (S-21) se reduce al modo documental residual.
- (−) Condición de adopción: exige a los docentes registrar fechas de evaluación y
  confirmar rendiciones — duda ALTA a AIEP (DUDAS.md).
- (−) Nueva dependencia deseable: fechas de evaluación desde Banner/calendario
  académico (si existen, la fricción docente baja casi a cero) — duda ALTA, impacto
  en BannerAdapter.
- Los tres modos conviven; el mapeo apoyo→modo es configuración (RF-061), no código.
- S-21 y S-22 siguen vigentes, S-21 acotado al modo documental.
