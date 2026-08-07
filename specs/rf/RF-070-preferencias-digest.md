# RF-070 — Agrupación y preferencias de avisos (anti-spam)

**Módulo:** comunicaciones
**Prioridad:** alta
**Depende de:** RF-063/065/067
**Inferencia:** del diagnóstico EXPLÍCITO del cap. 2: "la sobrecarga de correos es
la barrera número uno para responder a tiempo". Automatizar los avisos sin diseñar
su volumen reproduciría el problema que el proyecto viene a matar — con más
eficiencia. La duda de agrupación quedó abierta desde RF-016; aquí se resuelve.

## Descripción
El volumen de avisos se gobierna: los avisos AGRUPABLES (informativos, recordatorios
del mismo caso o del mismo evento masivo) se consolidan en resúmenes (digest) por
destinatario con frecuencia configurable; los CRÍTICOS (escalamientos, vencimientos
D-1, devoluciones al estudiante) salen siempre individuales e inmediatos. El usuario
ajusta preferencias dentro de límites que GDI define — nadie puede apagar lo crítico.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| (cada usuario) | preferencias propias dentro de los límites (frecuencia de digest, agrupar más/menos) |
| Equipo nacional GDI | definir qué es agrupable (RF-063), frecuencias default y límites; ver métricas de volumen |
| (resto) | — |

## Datos que toca
- Entidades: preferencia por usuario {frecuencia digest, opciones}, clasificación
  agrupable/crítico por regla (RF-063), digest emitido {avisos consolidados}.
- ¿Datos clínicos? NO (el digest consolida las variantes cortas — mismas garantías).

## Flujo principal
1. El motor (RF-065) difiere los agrupables según la preferencia del destinatario
   (seed: digest diario a las 08:00 para DAE, inmediato para estudiantes).
2. El digest consolida por caso y por tipo, con deep links individuales — un correo
   de la mañana con TODO lo pendiente, no 15 correos.
3. Los críticos NUNCA se difieren (clasificación de RF-063, no editable por usuario).
4. La campana (RF-067) recibe todo en tiempo real igual — el digest gobierna el
   CORREO, no la plataforma.

## Flujos alternos / casos borde
- Aviso agrupable que se vuelve crítico esperando (recordatorio cuyo plazo vence
  antes del próximo digest): se promueve a inmediato (nunca un digest entrega un
  aviso ya vencido).
- Registro (RF-066): cada aviso lógico del digest conserva su registro individual
  (la constancia no se diluye en el resumen).
- Usuario que lo quiere TODO inmediato: puede (límite inferior); apagar avisos: no.

## Criterios de aceptación
- [ ] CA-1: avalancha seed (apertura de período, 20 avisos a una DAE) → 1 digest con
      los 20 consolidados y deep links; los 2 críticos del lote salieron inmediatos.
- [ ] CA-2: agrupable con plazo que vence pre-digest se promueve a inmediato.
- [ ] CA-3 (negativo): ningún crítico es diferible por preferencia (validación);
      los registros individuales de RF-066 existen para cada aviso del digest.
- [ ] CA-4 (accesibilidad): digest en HTML accesible con estructura (por caso,
      encabezados); preferencias operables por teclado; axe 0.

## Propiedades (fuzzing)
- P1: todo aviso agrupable termina entregado (en digest o promovido) — la agrupación
  jamás pierde avisos; los críticos siempre inmediatos.

## Fuera de alcance
- La clasificación por regla (RF-063); la bandeja (RF-067).

## Dudas abiertas
- Frecuencias y ventanas preferidas por las sedes reales (seed: diario 08:00) —
  levantamiento con las propias DAE (son las que pidieron esto).
