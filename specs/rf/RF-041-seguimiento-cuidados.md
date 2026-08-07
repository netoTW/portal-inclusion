# RF-041 — Seguimiento de medidas de cuidados

**Módulo:** cuidados
**Prioridad:** alta
**Depende de:** RF-040, RF-013 (derivaciones), evidencia-eventos (atestaciones)
**Inferencia:** del módulo 5 del cap. 4 ("seguimiento") — el bloque del cap. 7 no lo
lista explícito pero el módulo sí. La situación de cuidado CAMBIA en el tiempo más
que una condición de inclusión: el seguimiento es parte del diseño, no un extra.

## Descripción
Los casos de cuidados activos tienen seguimiento periódico configurable: la
plataforma abre hitos de seguimiento (¿la situación persiste? ¿las medidas
funcionan?), registra el contacto del responsable con el estudiante y sus acuerdos,
y alimenta la renovación (RF-042) con información real en vez de re-evaluar de cero.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | responder hitos de seguimiento ("¿sigue tu situación?"), pedir revisión de medidas |
| Sede (DAE) | ejecutar el seguimiento de sus casos (contacto, registro de acuerdos) — SIN antecedentes del tercero |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | consulta |
| Equipo nacional GDI | configurar periodicidad e hitos; ver seguimiento nacional |
| Rectoría/Vicerrectorías | agregados |

## Datos que toca
- Entidades: hito de seguimiento {caso, fecha programada, responsable, estado,
  registro del contacto, acuerdos}; solicitud de revisión del estudiante.
- ¿Datos clínicos? El REGISTRO del seguimiento puede contener contexto sensible →
  vive en clinical como nota del caso de cuidados (acceso GDI/Secretaría; el DAE
  que registra ve SU registro operativo, no el expediente — ver dudas si esto
  tensiona [S-20]).

## Flujo principal
1. Al materializarse medidas, el motor programa los hitos según la configuración del
   tipo (seed: 1 seguimiento a mitad de semestre).
2. El responsable (DAE seed) contacta al estudiante y registra: situación
   persiste / cambió / medidas requieren ajuste.
3. "Requiere ajuste" → deriva a GDI (RF-013) o abre complementaria (RF-010).
4. El registro alimenta la renovación (RF-042): un caso con seguimiento al día
   renueva más liviano.

## Flujos alternos / casos borde
- Estudiante inubicable en el hito: registro del intento + recordatorios; nunca
  caduca medidas por no responder seguimiento (las medidas viven por vigencia
  RF-030/040, no por seguimiento — el seguimiento informa, no castiga).
- Situación terminó (dejó de ser cuidador): el estudiante o el seguimiento lo
  registran → revocación ordenada con cese avisado (RF-040).
- Hitos vencidos del responsable: RF-016/017 (avisos y escalamiento estándar).

## Criterios de aceptación
- [ ] CA-1: medidas seed → hito programado; registro del contacto con acuerdos queda
      en el caso; "requiere ajuste" deriva correctamente.
- [ ] CA-2: no responder seguimiento NO altera vigencia de medidas (test explícito
      — el seguimiento informa, no castiga).
- [ ] CA-3 (negativo): el registro de seguimiento con contexto sensible no es
      accesible para jefatura/docente ni aparece en reportes; DAE ve su registro
      operativo, no antecedentes [S-20].
- [ ] CA-4 (accesibilidad): formulario de hito simple y accesible; recordatorios al
      estudiante en tono cuidadoso; axe 0.

## Propiedades (fuzzing)
- P1: hitos programados ⇔ medidas vigentes con seguimiento configurado; sin hitos
  huérfanos de casos cerrados/revocados.

## Fuera de alcance
- La renovación (RF-042) — la alimenta.
- Seguimiento clínico/psicosocial profesional (fuera del sistema; aquí se registra
  el hito institucional).

## Dudas abiertas
- ¿Quién hace el seguimiento realmente (DAE de sede o equipo nacional)? Seed: DAE.
- Periodicidad institucional de hitos — levantamiento.
- Si el registro operativo del DAE roza contexto sensible: ¿se re-abre [S-20] para
  cuidados o el registro se estructura para no necesitarlo? Hoy: registro
  estructurado sin campo libre sensible.
