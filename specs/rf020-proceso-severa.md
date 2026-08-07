# Prueba RF-020 — Proceso de Exploración NEE / Discapacidad Severa vía UI

**Tarea de la cola:** `rf020-prueba` (Semana 2-3). **No es una spec de RF nueva**: es
el GUION de la prueba máxima de parametrización (RF-020 CA-1) usando el tercer
proceso real: Exploración e identificación de necesidades educativas para
estudiantes con discapacidad severa — 153 casos (2025-2026) hoy en planilla paralela.
"Debe poder configurarse en la plataforma como un tercer proceso, sin desarrollo
adicional: es la mejor prueba de la parametrización exigida" (cap. 4 del PDF).

## Regla de la prueba
Un **agente-funcionario** (sesión con rol GDI) recibe SOLO: (a) el manual de
administración, (b) esta descripción funcional. Sin acceso al código, sin acceso a
la base, sin ayuda del equipo constructor. Configura el proceso completo vía panel
(RF-019/061/021) y lo deja operativo. Verificación dura: `git diff` vacío + esquema
de BD sin cambios (RF-020 CA-1) + tiempo medido (RF-020 CA-2, dato comercial).

## Descripción funcional del proceso (etapas INFERIDAS [S-11] — el flujo real llega
con el doc extendido; recalibrar será EDITAR configuración, no código)
1. **Derivación/solicitud**: la sede o el estudiante (o su apoderado — ver dudas)
   inicia la exploración; formulario propio con derivante y motivo.
2. **Antecedentes**: checklist propio (derivación, antecedentes de exploración
   previos, credencial de discapacidad si existe) — documentos al esquema clinical.
3. **Exploración/evaluación**: registro de la exploración por el equipo GDI
   (instrumentos aplicados, sesiones — etapa con SLA propio).
4. **Informe NEE**: documento generable desde plantilla (RF-021) con los apoyos
   identificados.
5. **Plan de apoyos/resolución**: decisión GDI + firma (patrón RF-039) que
   materializa apoyos (→ registros de adecuaciones/medidas, RF-029/040).
6. **Seguimiento**: hitos periódicos (patrón RF-041).

## Qué debe configurar el agente-funcionario (todo vía UI)
- Tipo de solicitud nuevo (RF-001) asociado a proceso nuevo (RF-019).
- Formularios de cada etapa (constructor JSON Schema, campos sensibles marcados).
- Checklist documental (catálogo, RF-061/validacion-documental).
- SLA por etapa + avisos + escalamiento (sla-engine vía panel).
- Plantillas de informe y resolución (RF-021).
- Modo de evidencia de los apoyos resultantes (ADR-004).
- Permisos: la matriz por defecto del proceso respeta las 4 reglas SIN configuración
  extra (RF-020 CA-3: el red team corre contra el proceso creado).

## Criterios de éxito de la prueba (además de RF-020 CA-1..4)
- [ ] Un caso seed recorre las 6 etapas de punta a punta con los actores correctos.
- [ ] Los 153 casos históricos migrados (specs/migracion.md) entran a ESTE proceso
      configurado — la migración no exige tocarlo.
- [ ] Todo punto donde el manual no bastó queda documentado (hallazgos → mejorar
      manual o UI; insumo directo de BITACORA.md).
- [ ] El tiempo total del funcionario queda medido y reportado (propuesta: "un
      proceso institucional nuevo se configura en X horas sin proveedor").

## Dudas abiertas
- [S-11] Flujo real, responsables y plazos del proceso NEE/Severa (doc extendido —
  duda ALTA ya registrada).
- ¿Quién puede iniciar la exploración (¿apoderados como actores?— hoy: sede o
  estudiante) y qué rol juega la familia? Levantamiento.
