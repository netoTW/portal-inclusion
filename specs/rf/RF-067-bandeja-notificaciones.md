# RF-067 — Bandeja de notificaciones en la plataforma

**Módulo:** comunicaciones
**Prioridad:** alta
**Depende de:** RF-065, design-system (campana/notificación)
**Inferencia:** del principio del módulo 8 ("el correo avisa; el trabajo ocurre en
la plataforma") — el lugar donde "ocurre" necesita su bandeja. Complementa las
bandejas de TAREAS de cada perfil (RF-011/046): esto es el flujo de avisos.

## Descripción
Cada usuario tiene su campana: avisos no leídos, historial, y acceso directo a la
acción de cada uno. Es el canal PRIMARIO (el correo es cortesía). Diseñada para no
estorbar: agrupada, marcable como leída, y sin duplicar las bandejas de tareas —
la notificación lleva A la tarea, no la reemplaza.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| (cada usuario) | ver SU bandeja: no leídos, historial, marcar leído, ir a la acción |
| Equipo nacional GDI | nada especial (su bandeja propia; el registro global es RF-066) |

## Datos que toca
- Entidades: estado de lectura por usuario-aviso (el aviso vive en RF-065/066).
- ¿Datos clínicos? NO (la campana muestra la variante corta de RF-064, sin
  contenido sensible).

## Flujo principal
1. Campana con contador de no leídos en el header de toda vista (design system).
2. Abrir: lista por recencia con agrupación (los del mismo caso/evento juntos),
   cada aviso con su acción directa.
3. Click → deep link a la acción; el aviso queda accionado (acuse RF-066).
4. Historial completo del usuario con búsqueda simple.

## Flujos alternos / casos borde
- Volumen alto (DAE en apertura de período): agrupación por caso/evento y "marcar
  todo como leído" — leer no es acusar acción (los pendientes REALES viven en la
  bandeja de tareas y no se apagan leyendo).
- Aviso cuya acción ya se resolvió (otro la tomó): se marca resuelto, no manda a
  una tarea muerta.
- Usuario con varios roles (GDI que también es docente — si existiera): una bandeja
  por sesión de rol (coherente con actuar-como del dev login).

## Criterios de aceptación
- [ ] CA-1: aviso entregado aparece en la campana al tiro; click aterriza en la
      acción y registra el acuse.
- [ ] CA-2: la agrupación funciona con volumen seed de apertura de período;
      "marcar leído" no apaga tareas pendientes.
- [ ] CA-3 (negativo): la bandeja de un usuario solo contiene SUS avisos (test con
      multi-usuario seed); la variante corta no contiene datos sensibles.
- [ ] CA-4 (accesibilidad): campana con contador anunciado (aria-live polite),
      lista navegable por teclado, avisos con nombre accesible completo; axe 0.

## Propiedades (fuzzing)
- P1: contador de no leídos = exactamente los avisos entregados no marcados del
  usuario (consistencia contador-lista).

## Fuera de alcance
- Bandejas de tareas por perfil (cada módulo las tiene); preferencias/digest (RF-070).

## Dudas abiertas
- Ninguna propia.
