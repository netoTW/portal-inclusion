# CHANGELOG

Registro de cambios por fase/módulo. Cada tarea HECHA agrega su entrada aquí
(definición de HECHO, CLAUDE.md). Formato: fecha DD-MM-YYYY, módulo, qué cambió.

## Fase 0 — especificación

- **07-08-2026 · kit** — Auditoría cruzada del kit contra el PDF del cliente
  (24.07.2026): restituido el módulo Ficha única, creado el módulo Reportes/Dashboards,
  agregados adapters Power BI y Progresión, calibraciones de seed (tasas de aprobación,
  universo 21 sedes), diagramas del PDF volcados como texto, cronograma cap. 10.
- **07-08-2026 · docs** — Creados `SUPUESTOS.md` (S-01..S-17) y `DUDAS.md` (preguntas
  de levantamiento priorizadas). Estándar de documentación: README raíz, `/docs/`,
  ADRs 001 (arquitectura híbrida), 002 (k-anonimato), 003 (marco normativo ampliado).
- **07-08-2026 · specs (Tanda 0)** — Specs de infraestructura aprobadas: `authz.md`
  (ABAC, 4 invariantes duras, clinical_gate, DAE como celda editable [S-20], datos
  clínicos de terceros en Cuidados), `workflow.md` (procesos como datos, versionado,
  dos cierres + anulación [S-19], regla de oro sin bypass), `redteam.md` (definición
  operativa de exfiltración, 7 familias de vectores, canario), `audit.md` (append-only
  con cadena de hashes, registro transaccional), `seed.md` (seed limpio + generador
  de 881 sucios calibrados). Supuestos nuevos S-18..S-20.
- **07-08-2026 · specs (Tanda 1)** — Módulo Workflow especificado: RF-011 a RF-020 en
  `specs/rf/` + índice `specs/modulo-workflow.md` (orden interno de construcción y
  mapa de cobertura del bloque). Nombres de RF inferidos del bloque del cap. 7,
  marcados para reconciliación con el doc extendido. Decisiones de revisión:
  derivación = interconsulta con campo `tipo` extensible (duda ALTA), decisión única
  por caso (respaldo cap. 1), distinción de tres niveles en la guarda de evidencia
  (caso/definición/proceso seed). UI en paralelo: specs/design-system.md y tareas
  ui-shell/ui-admin en la cola.
- **07-08-2026 · specs (Tanda 2)** — Módulo Solicitudes especificado: RF-001 a RF-010
  + índice `specs/modulo-solicitudes.md`. Decisiones de revisión: RF-010 multi-caso
  con código propio (specs ancladas a capacidad, no a código); clasificación
  `sensible` obligatoria en el constructor de formularios con vector red-team
  post-seed; vigencia documental a fecha de envío (regla justa al estudiante);
  re-aceptación de consentimiento sin cortar casos en curso; retiro de consentimiento
  NO diseñado por decisión; reuso documental configurable entre casos; herramienta de
  fusión de catálogos compartida con migración. Duda nueva MEDIA: consentimiento de
  menores de 18.
- **07-08-2026 · specs (Tanda 3)** — Evidencias I especificado: RF-043 a RF-052
  (períodos, apertura automática, checklist derivado de lo aprobado, tablero de sede,
  carga, validación automática, estados y subsanación, archivo en expediente, cierre,
  regla de oro). Supuesto estructural S-21: "validada" = validación estructural
  automática + rondas de muestreo GDI documentadas con reversión (duda ALTA).
  Decisiones: no existe "validar a mano"; corte a fecha programada; anulados/cerrados
  disjuntos en métricas; regularización tardía con marca fuera de plazo. Duda
  transversal nueva (Tandas 4/6): ciclo de vida del caso no acreditado post-cierre
  vs. vigencia y renovación.
- **07-08-2026 · specs (ADR-004 + Tanda 3-bis)** — Cambio de diseño mayor: la
  evidencia pasa a ser el registro estructurado del EVENTO de aplicación
  (ADR-004). Tres modos por tipo de apoyo: evento (confirmación 1-click del docente,
  cruce automático, fecha CAPTURADA — circuito nuevo en specs/evidencia-eventos.md),
  atestación y documental (residual; muestreo acotado a este modo). Redraft de
  RF-045/046/047/048/049/050/051 sobre el modelo nuevo. Dudas ALTA: exigencia a
  docentes y fechas de evaluación en Banner.
- **07-08-2026 · specs (Tanda 4)** — Evidencias II: RF-053 a RF-062 + índice
  `specs/modulo-evidencias.md` (20/20 RF del bloque prioritario). Fiscalización
  alimentada por incumplimientos de evento en tiempo real: recordatorios D-X
  (documental/atestación), rojo y arrastre con umbral de instancia institucional
  formal (seed 2 períodos, registro de gestión — S-22 ampliado), escalamiento con
  peldaño final GDI fijo, semáforo en vivo, reportes por modo, gestión directa
  formalizada + "cierre excepcional documentado", histórico con línea base 2024-25,
  exportación con manifiesto de integridad, configuración del ciclo, contrato de
  indicadores (CA: el seed reproduce la línea base del PDF).
- **07-08-2026 · specs (Tanda 5)** — Módulo Documentos: RF-021 a RF-028 + índice.
  Decisiones: plantillas sin campos clínicos por construcción; firmados inmutables
  con efectos solo post-firma; modificatoria NO diseñada; firma por lote +
  subrogancia construida; folio oficial al firmar sin huecos (RF-028, el más
  inferido); expediente por caso vs ficha por estudiante con vectores red-team
  dedicados; descargas siempre vía portal autenticado. Duda MEDIA: canal de acceso
  del ex-estudiante a su expediente (21.719 × vigencia cuentas M365).
- **07-08-2026 · specs (Tanda 6)** — Módulo Adecuaciones: RF-029 a RF-036 + índice.
  Cruce [S-22] cerrado por el lado vigencias: invariante de independencia
  vigencia/evidencia (RF-030 P2) con tres tests espejo (RF-030 CA-2, RF-034 CA-3,
  RF-054 CA-3b) — patrón de verificación cruzada adoptado para todo invariante
  inter-módulo. Renovación con confirmación 1-click y flujo abreviado (dudas ALTA:
  quién confirma; resolución vs anexo). Panel docente = allowlist más restrictiva y
  blanco principal del red team. Aviso a docente como invariante de fuzzing. RF-036
  sin vía de creación fuera de resolución; sin medida provisoria por diseño.
  Migrados históricos marcados sin normalizar.
- **07-08-2026 · specs (Tanda 7)** — Módulo Cuidados: RF-037 a RF-042 + índice +
  guion `rf020-proceso-severa.md` (prueba de parametrización con verificación dura).
  Diseño S-23 de datos de salud de terceros: declaración responsable del cuidador +
  minimización activa (acreditación administrativa antes que informes médicos) +
  acceso solo GDI/Secretaría con propósito + derechos del tercero vía GDI.
  Minimización de contexto: el docente ve "medida de apoyo institucional", nunca
  "cuidados". Seguimiento no punitivo. Ajustes de revisión: alerta de SECCIÓN
  SILENCIOSA (incumplimiento presunto — el silencio nunca mejora el semáforo, P3),
  ventana de corrección de confirmaciones del docente (5dh, auditada), renovación
  abreviada de cuidados exige acreditación administrativa vigente (pide solo eso).
