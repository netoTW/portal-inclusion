# PORTAL INCLUSIÓN Y CUIDADOS — Convenciones maestras

Eres parte de un equipo de agentes construyendo una plataforma de gestión de casos
para educación superior (70 RF, 7 perfiles, datos clínicos sensibles).
La fuente de verdad son las specs en /specs. ANTES de tu primera tarea lee
specs/contexto-aiep.md (datos reales, 7 perfiles, SLA, métricas del cliente).
Si una spec es ambigua, NO inventes: registra la duda en /DUDAS.md y sigue con lo no-ambiguo.

## Stack (no negociable)
- Backend: Python 3.12 + FastAPI + SQLAlchemy 2 + Alembic. Postgres 16. Redis.
- Frontend: React + Vite + TypeScript estricto. Tailwind. Sin librerías UI pesadas.
- Docs/archivos: MinIO (S3-compatible) en dev.
- Tests: pytest + httpx (backend), Vitest + Playwright (frontend/e2e), fast-check (properties).
- Todo corre con `docker compose up`. Nada requiere cloud en dev.

## Arquitectura (leer /specs/arquitectura.md antes de tocar código)
- Monorepo: /apps/api, /apps/web, /packages/* (un package por módulo funcional).
- DATOS CLÍNICOS: viven SOLO en el esquema `clinical` y se acceden SOLO vía
  policy engine (packages/authz). Ningún endpoint serializa campos clínicos
  directamente. Violación de esto = PR rechazado por el gate red-team.
- CUATRO reglas de acceso "por diseño" (el red team ataca las cuatro):
  (1) Docente jamás ve información clínica. (2) Jefatura de Escuela jamás ve
  antecedentes clínicos. (3) Sede (DAE) jamás ve casos de otra sede — scoping
  territorial en TODA query. (4) Rectoría jamás llega a datos identificables —
  dashboards solo con agregación.
- Los 7 perfiles son EXACTAMENTE: Estudiante, Sede (DAE), Jefatura de Escuela,
  Docente, Secretaría General, Equipo nacional GDI, Rectoría/Vicerrectorías.
  No inventar otros ni renombrarlos.
- Procesos/workflows son DATOS (motor de metadatos), nunca código hardcodeado.
  Agregar un proceso nuevo NO puede requerir tocar código (RF-020).
- Auditoría: toda mutación pasa por packages/audit (quién, qué, cuándo, desde dónde).

## Reglas de trabajo
1. Lee tu spec completa antes de escribir código. Implementa TODOS los criterios
   de aceptación como tests primero o junto al código.
2. No toques archivos fuera de tu módulo asignado. Interfaces entre módulos:
   solo vía contratos en /packages/contracts (tipos compartidos).
3. Commit solo cuando: tests del módulo verdes + lint + typecheck verdes.
4. Accesibilidad NO es opcional: HTML semántico, labels, foco gestionado,
   navegable 100% por teclado. axe-core en CI debe dar 0 violaciones.
5. Español chileno en toda UI y mensajes. Fechas DD-MM-YYYY. RUT con validación DV.
6. Datos seed: usa /packages/seed (nombres, RUTs y casos chilenos realistas,
   calibrado con las proporciones reales de specs/contexto-aiep.md).
6b. Plazos en días HÁBILES chilenos (feriados incluidos) — packages/contracts
   expone la única función de cálculo de plazos; nadie la reimplementa.
7. Si te trabas 3 veces con lo mismo: escribe LIMITE-ENCONTRADO.md en tu módulo
   (qué intentaste, por qué falló, qué necesitas) y pasa a la siguiente tarea.
   OJO: eso es un BLOQUEO ACTIVO, no un resultado — queda registrado en BITACORA.md
   y exige plan de destrabe (re-especificar, cambiar enfoque, o decisión de Pablo).

## Prohibiciones
- No mocks dentro del código de producción (los mocks viven en /mocks).
- No `any` en TypeScript. No `# type: ignore` sin justificación en comentario.
- No deshabilitar tests ni gates para "avanzar".
- No secretos hardcodeados; todo por .env (con .env.example actualizado).
- No inventar campos/estados que no estén en la spec del módulo.

## Definición de HECHO para cualquier tarea
- Criterios de aceptación de la spec → tests que pasan
- Módulo funcional ⇒ incluye sus VISTAS de usuario operables (con specs/design-system.md).
  Un módulo sin UI operable NO está hecho; los CA de accesibilidad aplican sobre esas vistas
- Gates verdes: pytest, vitest, playwright del módulo, lint, typecheck, axe
- Si toca datos: migración Alembic incluida y reversible
- Documentación mínima: docstring de módulo + entrada en /docs/CHANGELOG.md
