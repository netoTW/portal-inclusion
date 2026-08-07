# RF-042 — Renovación de cuidados

**Módulo:** cuidados
**Prioridad:** alta
**Depende de:** RF-040/041, RF-034 (patrón de renovación), workflow (recurrencia)
**Inferencia:** del bloque Cuidados (cap. 7: "renovaciones") y módulo 5
("renovaciones"). Mismo patrón que RF-034 con un matiz: la renovación de cuidados
puede apoyarse en el SEGUIMIENTO (RF-041) en vez de re-pedir acreditación.

## Descripción
Al abrir el semestre, el motor crea las instancias de renovación de medidas de
cuidados vigentes renovables (misma recurrencia [S-05]). La confirmación del
estudiante-cuidador declara que la situación persiste; si el seguimiento del
semestre está al día y sin cambios, el flujo es abreviado (sin re-acreditar
documentalmente); si hubo cambios o no hubo seguimiento, la renovación pide
actualización proporcional (nunca el expediente completo de nuevo).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | confirmar renovación declarando persistencia; actualizar lo que cambió |
| Sede (DAE) | ver/recordar renovaciones pendientes de su sede |
| Jefatura de Escuela | ver medidas renovadas de sus estudiantes |
| Docente | recibir aviso actualizado (neutro, RF-040) |
| Secretaría General | firmar resolución/anexo de renovación (misma duda ALTA que RF-034) |
| Equipo nacional GDI | reglas de renovación por tipo; panorama del ciclo |
| Rectoría/Vicerrectorías | agregados |

## Datos que toca
- Entidades: instancia de renovación de cuidados (hija, workflow), declaración de
  persistencia {timestamp, cambios declarados}.
- ¿Datos clínicos? La declaración de persistencia es sensible (situación de cuidado)
  → clinical; la renovación NO re-expone antecedentes del tercero salvo
  actualización necesaria [S-23, minimización].

## Flujo principal
1. Apertura del ciclo → instancias hijas de medidas vigentes renovables + aviso al
   estudiante.
2. Confirmación con declaración de persistencia:
   - seguimiento al día y sin cambios → flujo abreviado (extiende vigencias, re-avisa
     involucrados). La abreviada EXIGE acreditación administrativa VIGENTE: si el
     documento base venció (RSH, credencial), se pide ÚNICAMENTE ese documento antes
     de confirmar — no gatilla evaluación completa ni re-pide lo demás;
   - con cambios / sin seguimiento → actualización proporcional (solo lo que cambió,
     documentos vencidos si aplica) → evaluación ligera de GDI.
3. Sin confirmación en plazo: recordatorios → no_renovada → medidas vencen por
   vigencia con registro (patrón RF-034).

## Flujos alternos / casos borde
- Situación terminada declarada en la renovación: cierre ordenado con cese avisado
  (RF-040/041).
- Renovación de cuidados y de inclusión el mismo semestre (estudiante con ambos):
  ciclos independientes, avisos agrupados (anti-spam RF-016) — no dos bombardeos.
- Cruce [S-22]: aplica igual — la renovación de medidas no se bloquea por deudas de
  evidencia de la sede (espejo del invariante).

## Criterios de aceptación
- [ ] CA-1: ciclo seed → instancia hija; confirmación con seguimiento al día →
      flujo abreviado sin re-acreditación; con cambios → actualización proporcional.
- [ ] CA-1b (acreditación vigente): abreviada con RSH/credencial vencida → pide SOLO
      ese documento antes de confirmar; con él al día, la abreviada procede sin
      evaluación completa.
- [ ] CA-2: sin confirmación → no_renovada con registro; docentes reciben cese
      neutro de las medidas vencidas.
- [ ] CA-3 (negativo/cruce): renovación procede con caso de evidencias incumplido
      ([S-22] espejo); la renovación no re-expone antecedentes del tercero a nadie
      nuevo (mismo círculo GDI/Secretaría).
- [ ] CA-4 (accesibilidad): confirmación en una pantalla, teclado/móvil; axe 0.

## Propiedades (fuzzing)
- P1: instancia de renovación ⇔ medida madre vigente y renovable (espejo RF-034 P1).
- P2: independencia renovación ↔ evidencia ([S-22] — tercera spec del patrón de
  verificación cruzada para el proceso 2).

## Fuera de alcance
- La mecánica de recurrencia (workflow.md) y el patrón base (RF-034).

## Dudas abiertas
- Las mismas ALTA de RF-034 (quién confirma; resolución vs anexo) aplican a
  cuidados — una sola respuesta institucional para ambos procesos, o distinta:
  levantamiento.
