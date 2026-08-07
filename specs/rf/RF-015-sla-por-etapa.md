# RF-015 — Plazos (SLA) por etapa

**Módulo:** workflow
**Prioridad:** crítica
**Depende de:** RF-012, sla-engine, contracts (función única de días hábiles)
**Inferencia:** del bloque Workflow (cap. 7: "plazos (SLA) por etapa") y la tabla de
etapas del cap. 6 (Evaluación 5dh, Resolución 5dh, Aplicación 3dh). El detalle de
maquinaria vive en specs/sla-engine.md; este RF es su contrato de aceptación.

## Descripción
Cada etapa de cada proceso tiene un plazo configurable que corre en días hábiles
chilenos desde que el caso entra a la etapa. El plazo es visible para el responsable y
para quien supervisa, se pausa cuando corresponde [S-16], y su cumplimiento queda
medible caso a caso (meta cliente: 100% de casos con tiempo de resolución medible;
hoy 45,8%).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver plazo comprometido de su caso en lenguaje simple ("respuesta antes del DD-MM-YYYY") |
| Sede (DAE) | ver plazos y semáforo de los casos de SU sede |
| Jefatura de Escuela | ver plazos de sus tareas |
| Docente | ver plazos de sus atestaciones |
| Secretaría General | ver plazos de su cola |
| Equipo nacional GDI | configurar SLA por etapa (panel), ver cumplimiento nacional |
| Rectoría/Vicerrectorías | solo agregados (vía reportes) |

## Datos que toca
- Entidades: configuración SLA por etapa (sla-engine), reloj por caso-etapa (inicio,
  pausas, vencimiento calculado), calendario de feriados (datos, seed).
- ¿Datos clínicos? NO.

## Flujo principal
1. El caso entra a una etapa → el motor calcula el vencimiento con la ÚNICA función de
   días hábiles de contracts (feriados chilenos incluidos).
2. El plazo y su estado (al día / por vencer / vencido, icono+texto) se muestran en
   bandeja, caso y ficha.
3. Pausas por en_espera [S-16] quedan registradas; el vencimiento se recalcula.
4. Al cerrar la etapa, el tiempo real consumido queda medido y disponible para reportes.

## Flujos alternos / casos borde
- Cambio de configuración SLA con casos en vuelo: los relojes corriendo conservan su
  plazo original (la config nueva aplica a entradas futuras) — coherente con el
  versionado de workflow.md.
- Feriado nuevo decretado (Chile los agrega): GDI edita el calendario (datos); relojes
  en curso se recalculan y el recálculo queda auditado.
- Etapas sin plazo (Solicitud) y automáticas (Recepción "inmediato", Cierre): sin reloj;
  "inmediato" se verifica como transición síncrona.
- Etapa Evidencia: su plazo es el período (sla-engine, RF-043+), no un reloj por caso.

## Criterios de aceptación
- [ ] CA-1: caso entra a Evaluación un viernes → vencimiento correcto saltando fin de
      semana y feriados del calendario seed (casos de borde: feriado en el límite, 18-19 sept).
- [ ] CA-2: pausa por en_espera detiene el reloj y la reanudación lo retoma donde quedó;
      el tiempo pausado no cuenta contra el responsable [S-16].
- [ ] CA-3: todo caso cerrado tiene tiempo por etapa medible y exportable (meta 100%).
- [ ] CA-3b (negativo): DAE ve plazos solo de su sede; Rectoría no accede a plazos de
      casos individuales.
- [ ] CA-4 (accesibilidad): el estado de plazo nunca es solo color (icono + texto);
      bandejas con plazos operables por teclado; axe 0.

## Propiedades (fuzzing)
- P1: para cualquier fecha de entrada y secuencia de pausas/reanudaciones, el
  vencimiento calculado es determinista y ≥ fecha de entrada.
- P2: vencimiento(d, n días hábiles) nunca cae en fin de semana ni feriado del calendario.

## Fuera de alcance
- Avisos y escalamientos al acercarse/vencer el plazo (RF-016, RF-017).
- Períodos de evidencia (bloque evidencias).

## Dudas abiertas
- Confirmar valores 5dh/5dh/3dh en levantamiento (son seed del RFP; sla-engine.md).
