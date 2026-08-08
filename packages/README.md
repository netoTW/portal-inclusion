# /packages — un package por módulo funcional

Layout definido en `specs/arquitectura.md`. Cada tarea de la cola (`tareas.md`)
crea SU propio package cuando le toca; el scaffold no crea esqueletos vacíos
a propósito: un package existente dispara sus gates (pytest + mypy) en runner
y CI, y un esqueleto vacío los haría fallar sin aportar nada.

Reglas (CLAUDE.md):
- Interfaces entre módulos SOLO vía `/packages/contracts`.
- Datos clínicos SOLO en el esquema `clinical`, accedidos SOLO vía `packages/authz`.
- Toda mutación pasa por `packages/audit`.
