# RF-018 — Registro de acciones del caso

**Módulo:** workflow
**Prioridad:** crítica
**Depende de:** RF-012, audit
**Inferencia:** del bloque Workflow (cap. 7: "registro de acciones") y compromiso nº2
del cliente (trazabilidad total). La maquinaria es specs/audit.md; este RF es la
trazabilidad VISIBLE del caso para los usuarios.

## Descripción
Cada caso muestra su línea de tiempo completa: qué pasó, quién lo hizo, cuándo — desde
la solicitud hasta el cierre, incluyendo transiciones, asignaciones, derivaciones,
avisos enviados, escalamientos, cargas de documentos y decisiones. Es la respuesta a
"¿en qué está mi caso?" y la evidencia ante auditoría (hoy: trazabilidad cortada, 45,8%
con fecha de resolución).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver la línea de tiempo de SU caso, filtrada (sin notas internas ni gestión interna) |
| Sede (DAE) | línea de tiempo completa operativa de casos de SU sede |
| Jefatura de Escuela | eventos de sus tareas y avisos en sus casos (sin contenido clínico) |
| Docente | eventos de sus atestaciones (sin contenido clínico) |
| Secretaría General | línea de tiempo de los procesos que resuelve |
| Equipo nacional GDI | línea de tiempo completa de cualquier caso |
| Rectoría/Vicerrectorías | nada individual |

## Datos que toca
- Entidades: LEE de audit (no tiene almacenamiento propio — una sola fuente de verdad);
  filtros de visibilidad por perfil definidos como allowlist de tipos de evento.
- ¿Datos clínicos? La línea de tiempo REFERENCIA eventos sobre documentos clínicos
  ("se cargó certificado médico") sin exponer contenido (audit.md: referencias opacas).

## Flujo principal
1. El usuario abre un caso → pestaña "Historia" con la línea de tiempo ordenada,
   cada evento con fecha (DD-MM-YYYY HH:mm), actor (o "Plataforma") y descripción en
   chileno claro ("La solicitud pasó a Evaluación", "Se pidió: certificado médico").
2. Los eventos visibles dependen del perfil (allowlist por tipo de evento + authz).
3. GDI puede exportar la historia de un caso (alimenta RF-062/auditoría; export auditado).

## Flujos alternos / casos borde
- Caso anulado o cerrado: la historia sigue visible completa (nada se borra).
- Evento de rectificación (audit.md): se muestra enlazado al original, nunca lo reemplaza.
- Caso con múltiples ciclos (devoluciones, renovación hija): la historia los muestra
  como capítulos; la hija enlaza a la madre.

## Criterios de aceptación
- [ ] CA-1: recorrer el proceso seed completo produce una línea de tiempo legible con
      TODOS los eventos esperados en orden (test de contenido).
- [ ] CA-2: el estudiante ve su historia sin notas internas ni eventos de gestión
      interna (allowlist verificada evento por evento).
- [ ] CA-3 (negativo): docente abre la historia de un caso de su estudiante → no
      aparece ningún evento con contenido clínico ni nombre de documento diagnóstico
      más allá de la categoría; el intento de pedir el detalle da 403 + audit.
- [ ] CA-3b (negativo): DAE no accede a historias de otra sede.
- [ ] CA-4 (accesibilidad): línea de tiempo semántica (lista ordenada), navegable por
      teclado, fechas en texto; axe 0.

## Propiedades (fuzzing)
- P1: la línea de tiempo de un caso es un subconjunto ordenado de audit; ningún evento
  mostrado carece de respaldo en audit (nada "decorativo").

## Fuera de alcance
- La bitácora inmutable misma (audit.md).
- Notas internas de gestión como feature de escritura (bloque comunicaciones/casos).

## Dudas abiertas
- ¿La historia visible para el estudiante debe incluir los avisos que se le enviaron
  (transparencia total) o solo hitos del caso? Hoy: hitos + sus propios pendientes.
