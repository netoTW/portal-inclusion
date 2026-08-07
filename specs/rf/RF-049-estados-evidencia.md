# RF-049 — Estados de la evidencia y subsanación

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-045, RF-047, RF-048
**Inferencia:** del bloque Evidencias (cap. 7: "estados") y de la mecánica combinada
de carga + validación. La subsanación es el bucle que convierte el rechazo en
cumplimiento (sin ella, un rechazo automático sería un callejón sin salida).

## Descripción
Cada ítem del checklist vive una máquina de estados POR MODO (ADR-004):
- **DOCUMENTAL:** `pendiente → cargada → validada`, con desvío `observada →
  (subsanación) → cargada…` y terminales `cancelada` / `no evaluable con visto GDI` [S-21].
- **EVENTO:** `pendiente → cumplido | incumplido` derivado EN TIEMPO REAL del
  circuito de evidencia-eventos.md (confirmaciones, reprogramaciones con pendiente
  vivo, evaluación pasada sin confirmar → incumplido visible).
- **ATESTACIÓN:** `pendiente → cumplido` al confirmar el responsable (con captura de
  fecha y autor).
El estado del CASO en el período se deriva de sus ítems: acreditado cuando todos los
obligatorios están satisfechos según su modo.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | ver estados de sus ítems y subsanar los observados |
| Jefatura de Escuela | ver estado agregado por estudiante |
| Docente | nada |
| Secretaría General | consulta |
| Equipo nacional GDI | ver todo; revertir validadas (RF-048); cancelar ítems con motivo |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: estado del ítem (con historia completa de transiciones), estado derivado
  del caso en el período {pendiente, parcial, observado, acreditado}.
- ¿Datos clínicos? NO.

## Flujo principal
1. Ítem nace `pendiente` (RF-044/045).
2. Carga (RF-047) → `cargada`; validación (RF-048) → `validada` o `observada` con motivos.
3. `observada`: la sede ve exactamente qué corregir, reemplaza el archivo o corrige la
   fecha → vuelve a `cargada` → re-validación. Ciclos ilimitados dentro del período,
   todos en la historia.
4. Todos los obligatorios `validada` → caso ACREDITADO en el período (evento que
   consume el bloqueo de cierre RF-052 y las métricas).

## Flujos alternos / casos borde
- Subsanación tras el cierre del período: solo vía regularización tardía (RF-047/
  Tanda 4), marcada fuera de plazo.
- Reversión GDI de una validada (RF-048): vuelve a `observada`; si el caso ya estaba
  acreditado, PIERDE la acreditación (y si ya se cerró por RF-052 — no puede: el
  cierre exige acreditación estable; ver dudas).
- Ítem cancelado (apoyo revocado): no cuenta para acreditar; visible tachado con motivo.
- El estado nunca retrocede a `pendiente`: la historia de cargas se conserva siempre.

## Criterios de aceptación
- [ ] CA-1: recorrido completo pendiente→cargada→observada→subsanada→validada deja la
      historia íntegra y el caso acredita cuando corresponde.
- [ ] CA-2: la vista de subsanación de la sede muestra el motivo exacto por dimensión
      y permite corregir SOLO lo observado (no re-hacer todo).
- [ ] CA-3 (negativo): ninguna acción de DAE lleva un ítem a `validada` directamente
      (solo el motor); las transiciones administrativas (cancelar, revertir) son
      exclusivas de GDI (403 al resto + audit).
- [ ] CA-4 (accesibilidad): los estados usan icono+texto del design system; el cambio
      de estado tras subsanar se anuncia (aria-live); axe 0.

## Propiedades (fuzzing)
- P1: las transiciones observadas pertenecen al grafo definido (no hay estados ni
  saltos fantasmas), ante cualquier secuencia de cargas/validaciones/reversiones.
- P2: acreditado(caso) ⇔ ∀ ítem obligatorio satisfecho según su modo (documental:
  validada · evento: cumplido · atestación: cumplido) o cancelado — consistencia
  derivada, nunca almacenada a mano.

## Fuera de alcance
- Los motivos de validación (RF-048), la carga (RF-047).
- Semáforo por sede y métricas (Tanda 4).

## Dudas abiertas
- Interacción reversión-GDI ↔ caso ya cerrado (RF-052): ¿la reversión post-cierre
  reabre el caso o genera hallazgo de auditoría sin reabrir? Hoy: hallazgo sin
  reabrir (el cierre es estable); confirmar con AIEP.
