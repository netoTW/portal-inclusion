# RF-017 — Escalamiento por vencimiento

**Módulo:** workflow
**Prioridad:** alta
**Depende de:** RF-015, RF-016
**Inferencia:** del bloque Workflow (cap. 7: "escalamiento") y figura 3.2 (cadena:
rojo en tablero → Dirección de Sede → alerta GDI + reporte). Cadena configurable por
etapa según sla-engine.md.

## Descripción
Cuando un plazo vence sin acción, la plataforma escala sola por una cadena ordenada y
configurable: marca el caso atrasado, avisa a instancias superiores (ej. Dirección de
Sede [S-08]) y alerta a GDI con reporte de incumplimiento. "El sistema actúa solo, sin
que el equipo nacional persiga a nadie" (figura 3.2).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada (no ve gestión interna de atrasos; su vista muestra el plazo comprometido) |
| Sede (DAE) | ver sus casos atrasados marcados en rojo en su tablero |
| Jefatura de Escuela | ver sus tareas atrasadas |
| Docente | ver sus atestaciones atrasadas |
| Secretaría General | ver su cola con atrasos |
| Equipo nacional GDI | configurar cadenas de escalamiento; ver el tablero nacional de atrasos |
| Rectoría/Vicerrectorías | solo agregados (% cumplimiento, vía reportes) |
| (Dirección de Sede) | destinatario de notificación de escalamiento, sin login [S-08] |

## Datos que toca
- Entidades: cadena de escalamiento por etapa ({tras_vencimiento, a: rol, plantilla} —
  sla-engine.md), marca "atrasado" del caso-etapa, eventos de escalamiento emitidos.
- ¿Datos clínicos? NO (los avisos de escalamiento refieren folio y etapa, jamás contenido).

## Flujo principal
1. Vence el plazo sin completarse la acción → el caso-etapa queda "atrasado": rojo
   (icono+texto) en la bandeja del responsable y visible para su supervisión.
2. Según la cadena configurada (ej. +2dh → Dirección de Sede; +5dh → GDI), se emiten
   los escalamientos con plantilla, cada uno registrado.
3. El caso aparece en el tablero de atrasos de GDI y suma al reporte de incumplimiento
   por sede (consumido por reportes/semáforo).
4. Al resolverse la acción, el atraso se cierra (el historial de escalamientos permanece).

## Flujos alternos / casos borde
- Acción resuelta entre dos peldaños de la cadena → los peldaños restantes se cancelan.
- Reloj pausado en el momento del cálculo → no hay vencimiento (RF-015).
- Escalamiento a rol sin destinatario resoluble (sede sin Dirección registrada) →
  salta al siguiente peldaño + alerta a GDI (nunca en silencio).
- `al_vencer.bloquear`: si la etapa lo configura, el vencimiento además dispara la
  acción definida (crear tarea, bloquear operación) — sla-engine.md.

## Criterios de aceptación
- [ ] CA-1: plazo vencido → caso atrasado (rojo con texto en bandeja) y cadena seed
      ejecutada en orden con sus registros (Dirección de Sede, luego GDI).
- [ ] CA-2: resolver la tarea detiene los peldaños pendientes; el historial queda.
- [ ] CA-3 (negativo): las notificaciones de escalamiento no contienen datos clínicos;
      Dirección de Sede recibe correo pero NO puede acceder a la plataforma con él
      (no hay cuenta [S-08]).
- [ ] CA-3b (negativo): el tablero de atrasos de DAE muestra solo su sede.
- [ ] CA-4 (accesibilidad): tablero de atrasos operable por teclado; el estado atrasado
      es perceptible sin color; axe 0.

## Propiedades (fuzzing)
- P1: los peldaños de una cadena se emiten en orden estricto y a lo más una vez cada uno.
- P2: cerrado el atraso, no se emite ningún peldaño posterior.

## Fuera de alcance
- Semáforo de cumplimiento por sede (evidencias/reportes lo agregan; aquí se emiten
  los eventos).
- El escalamiento específico del período de evidencias (RF-043+ configura SU cadena
  con esta maquinaria).

## Dudas abiertas
- Cadenas seed para etapas 3-5 (el PDF solo detalla la de evidencias): proponemos
  +2dh supervisor directo / +5dh GDI — confirmar en levantamiento.
