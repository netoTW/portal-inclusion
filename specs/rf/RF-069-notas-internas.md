# RF-069 — Notas internas de gestión

**Módulo:** comunicaciones
**Prioridad:** alta
**Depende de:** RF-068, authz, audit
**Inferencia:** del cap. 8, perfil Estudiante — "No puede ver: notas internas de
gestión". Si el PDF las excluye del estudiante, EXISTEN: hay que especificarlas
para que no nazcan como campo libre sin régimen.

## Descripción
Los gestores registran notas internas sobre el caso (impresiones de la evaluación,
contexto operativo, acuerdos internos) distintas del hilo de comunicación (RF-068):
la nota es unidireccional, del gestor al expediente. Invisible para el estudiante
por diseño — y con régimen claro de sensibilidad para que "nota interna" no se
convierta en el rincón sin reglas del sistema.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | JAMÁS las ve (regla del cap. 8; tampoco en su historial RF-018 ni en exportaciones que le lleguen) |
| Sede (DAE) | crear/ver notas OPERATIVAS de sus casos |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | notas de los procesos que resuelve |
| Equipo nacional GDI | todas; crear notas de evaluación (régimen clínico) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: nota {caso, autor, tipo: operativa | de_evaluación, texto, timestamp}.
- ¿Datos clínicos? Las notas DE EVALUACIÓN (impresiones sobre antecedentes,
  fundamento fino de la recomendación) viven en `clinical` — solo GDI/Secretaría
  (gate). Las OPERATIVAS ("estudiante avisó que viaja", "coordinar con jefatura")
  viven en public sin contenido sensible — la UI del tipo operativa advierte y el
  régimen es el mismo de los hilos DAE (RF-068).

## Flujo principal
1. En el caso, "Notas internas": crear con tipo explícito (operativa/evaluación —
   el tipo define el régimen, elegido al crear, no editable después).
2. La nota queda inmutable, en el expediente (sección interna) y en audit.
3. Rectificación como nota nueva enlazada (patrón estándar).

## Flujos alternos / casos borde
- Ejercicio de derechos del estudiante (acceso 21.719/ADR-003): las notas internas
  son el punto de tensión clásico — qué se entrega ante una solicitud de acceso es
  DECISIÓN JURÍDICA de AIEP, no del sistema: la plataforma sabe distinguirlas y
  exportarlas o excluirlas según instrucción (duda registrada).
- Exportaciones de auditoría (RF-060): las notas van según el nivel del alcance
  (las de evaluación solo en nivel clínico).
- Nota en caso de cuidados: siempre régimen clínico (coherente con [S-23]).

## Criterios de aceptación
- [ ] CA-1: nota operativa y de evaluación creadas en caso seed → cada una en su
      régimen; la línea del estudiante (RF-018) y sus exportaciones no las
      contienen (test de contenido).
- [ ] CA-2: inmutables; rectificación enlazada.
- [ ] CA-3 (negativo): nota de evaluación inaccesible para DAE [S-20] (403 + audit);
      ninguna vía del estudiante llega a ninguna nota (batería red team — es SU
      exclusión explícita del cap. 8).
- [ ] CA-4 (accesibilidad): creación y lectura por teclado; axe 0.

## Propiedades (fuzzing)
- P1: ninguna respuesta para actor Estudiante contiene una nota interna, ante
  cualquier combinación de datos (la exclusión del cap. 8 como invariante).

## Fuera de alcance
- Conversación bidireccional (RF-068); recomendación de evaluación estructurada
  (validacion-documental — la nota es el complemento libre).

## Dudas abiertas
- Política de AIEP ante solicitudes de acceso del estudiante a sus notas internas
  (21.719) — jurídica, se une a las dudas ADR-003.
