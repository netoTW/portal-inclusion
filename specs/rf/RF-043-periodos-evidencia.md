# RF-043 — Períodos de evidencia

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** sla-engine (entidad período), RF-019 (configuración)
**Inferencia:** del bloque Evidencias (cap. 7: "apertura y cierre automáticos") y
módulo 7 del cap. 4 ("apertura automática de períodos"). El período es la unidad de
tiempo del ciclo completo. Duración/fechas reales desconocidas [S-13].

## Descripción
El período de evidencias es una entidad propia: una ventana con inicio, cierre y
alcance (qué casos entran) dentro de la cual las sedes acreditan la implementación de
los apoyos. GDI lo programa; desde ahí TODO es automático: apertura, avisos,
recordatorios, escalamiento y cierre. Contexto: el ciclo 2026 (261 casos) aún no se
inicia — será el primer período que la plataforma corra sola.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada (el ciclo de evidencias es institucional, no del estudiante) |
| Sede (DAE) | ver los períodos que afectan a SU sede (fechas, alcance, estado) |
| Jefatura de Escuela | ver fechas del período vigente |
| Docente | nada |
| Secretaría General | ver períodos |
| Equipo nacional GDI | crear, programar, editar (antes de abrir), cerrar excepcionalmente |
| Rectoría/Vicerrectorías | nada directo (cumplimiento agregado vía reportes) |

## Datos que toca
- Entidades: período {nombre (ej. "Evidencias 2°S 2026"), fecha_apertura,
  fecha_cierre, alcance (procesos/semestre/sedes), estado programado→abierto→cerrado}.
- ¿Datos clínicos? NO.

## Flujo principal
1. GDI programa el período: fechas y alcance. Puede programar el año completo por
   adelantado.
2. Al llegar la fecha, el período se abre SOLO (RF-044); al llegar el cierre, cierra
   solo (RF-051).
3. Los casos del alcance quedan vinculados al período con su checklist (RF-045).

## Flujos alternos / casos borde
- Editar un período ABIERTO: solo extender la fecha de cierre (auditado, re-calcula
  recordatorios); nunca acortar ni cambiar alcance con casos en curso.
- Caso que se aprueba DESPUÉS de abierto el período pero dentro del alcance: entra al
  período en curso con su checklist (aviso a la sede) — regla inferida, ver dudas.
- Períodos solapados (distintos procesos): permitidos; un caso pertenece a lo más a un
  período por ciclo.
- Cierre excepcional anticipado por GDI: requiere confirmación explícita, motivo, y
  NO marca como incumplida la evidencia pendiente (queda "período interrumpido") — borde
  raro pero debe existir sin romper métricas.

## Criterios de aceptación
- [ ] CA-1: GDI programa un período con alcance "proceso seed 1, semestre actual" →
      en la fecha se abre solo y vincula exactamente los casos del alcance.
- [ ] CA-2: extender el cierre re-programa recordatorios D-X correctamente; acortar es
      imposible por API y UI.
- [ ] CA-3 (negativo): DAE ve solo períodos que afectan su sede; no puede crear ni
      editar (403 + audit).
- [ ] CA-4 (accesibilidad): la programación de períodos (formulario con fechas) es
      operable por teclado con formato DD-MM-YYYY; axe 0.

## Propiedades (fuzzing)
- P1: un caso pertenece a lo más a un período abierto a la vez.
- P2: las transiciones de estado del período son estrictamente
  programado→abierto→cerrado (sin saltos ni retrocesos).

## Fuera de alcance
- Los avisos de apertura (RF-044), checklist (RF-045) y cierre (RF-051).
- El calendario semestral académico real (levantamiento, [S-13]).

## Dudas abiertas
- ¿Un período nacional único o períodos por sede? Hoy: nacional con alcance
  configurable [S-13].
- Regla para casos aprobados con el período ya abierto (hoy: entran al período en curso).
