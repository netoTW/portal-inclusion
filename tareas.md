# Cola del runner — formato: módulo | spec | notas
# [ ] pendiente · [x] hecha · [!] BLOQUEO ACTIVO (LIMITE-ENCONTRADO.md + plan de destrabe en BITACORA.md)
# ORDEN = DEPENDENCIAS. No reordenar sin razón.

## Semana 1 — cimientos (mucho de esto conviene supervisado, no nocturno)
- [ ] scaffold      | specs/arquitectura.md         | monorepo+docker+CI con TODOS los gates. HECHO incluye: /docs de FastAPI (OpenAPI interactiva) arriba con datos seed cargados, para ejercitar cada endpoint a mano
- [ ] contracts     | specs/arquitectura.md         | tipos compartidos + adapters de integración
- [ ] authz         | specs/authz.md                | policy engine ABAC + esquema clinical + gate
- [ ] redteam       | specs/redteam.md              | agente adversarial docente→clinical, set de vectores
- [ ] audit         | specs/audit.md                | bitácora inmutable, mutaciones + denegaciones
- [ ] seed          | specs/seed.md                 | datos chilenos + generador 881 registros sucios calibrados
- [ ] sla-engine    | specs/sla-engine.md            | motor de plazos: reloj hábil CL, pausas, avisos, escalamiento, períodos
- [ ] workflow      | specs/workflow.md + specs/modulo-workflow.md | motor de metadatos + 7 etapas/SLA seed + días hábiles CL (corazón del sistema); su UI admin va en ui-admin
- [ ] ui-shell      | specs/design-system.md        | design system (tokens+componentes) + navegación + login dev "actuar como" (7 perfiles) + layout por perfil
- [ ] ui-admin      | specs/workflow.md + specs/design-system.md | PRIMERAS VISTAS REALES sobre el motor: panel admin GDI (procesos/formularios/SLA) + bandeja de casos

## Semana 2 — módulos funcionales (paralelizable en worktrees)
# Regla: cada módulo incluye SUS VISTAS operables (CLAUDE.md) — backend solo no es HECHO
- [ ] validacion-doc| specs/validacion-documental.md | catálogo requisitos + admisibilidad automática + decisión humana 1-click
- [ ] solicitudes   | specs/modulo-solicitudes.md   | RF-001–010 + multi-caso + borradores + consentimiento
- [ ] evidencias    | specs/modulo-evidencias.md    | RF-043–062: EL MÁS GRANDE (20 RF), prioritario. D-15/D-7/D-1, semáforo, bloqueo de cierre
- [ ] documentos    | specs/modulo-documentos.md    | RF-021–028: resoluciones/cartas + versionado + FirmaAdapter
- [ ] adecuaciones  | specs/modulo-adecuaciones.md  | RF-029–036: vigencia semestral, renovación, impedir no-aprobadas
- [ ] cuidados      | specs/modulo-cuidados.md      | RF-037–042: REUSAR motor 21.790 existente + diseñar datos clínicos de TERCEROS (persona cuidada): esquema clinical + consentimiento (authz.md, DUDAS.md)
- [ ] comunicaciones| specs/modulo-comunicaciones.md| RF-063–070: plantillas administrables + registro de envíos y acuses
- [ ] ficha         | specs/ficha-estudiante.md     | vista integradora (módulo 6 PDF, sin RF propio): compone solicitudes+documentos+adecuaciones+cuidados+evidencias+comunicaciones vía contracts — VA DESPUÉS de ellos
- [ ] reportes      | specs/reportes-dashboards.md  | dashboard ejecutivo Rectoría (agregados, k-anon ADR-002) + reportes cumplimiento + indicadores en línea (metas cap. 11) + dataset Power BI

## Semana 2-3 — integraciones simuladas + cierre
- [ ] mock-banner   | specs/mock-banner.md          | OpenAPI Ellucian + Prism + datos dummy
- [ ] mock-firma    | specs/mock-firma.md           | enviar/estado + panel fake
- [ ] mock-progresion| specs/mock-progresion.md     | API dummy progresión/retención/titulación + ProgresionAdapter
- [ ] powerbi-export| specs/powerbi-export.md       | PowerBIAdapter: dataset de indicadores consumible (dev: endpoint JSON/CSV; prod: Power BI)
- [ ] sso-m365      | specs/sso-m365.md             | tenant real M365 Developer (crear tenant es manual: 20 min Pablo)
- [ ] rf020-prueba  | specs/rf020-proceso-severa.md | agente-funcionario configura el proceso de Discapacidad Severa (153 casos) SOLO con UI+manual — la prueba de parametrización que exige el RFP
- [ ] fuzzing       | specs/fuzzing-workflow.md     | propiedades + fast-check contra el motor
- [ ] docs          | specs/documentacion.md        | 7 manuales por perfil desde specs+código
- [ ] migracion     | specs/migracion.md            | pipeline vs 881 sucios calibrados (32 variantes sede, 41 categorías libres, trazabilidad vacía) — medir % auto-resuelto
