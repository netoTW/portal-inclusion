# Arquitectura — Portal de Inclusión y Cuidados

## Principio rector
"El docente no puede ver datos clínicos" es una PROPIEDAD ARQUITECTÓNICA,
no una feature. Se garantiza por construcción y se demuestra por ataque automatizado.

## Vista de módulos (monorepo)
```
/apps
  /api            FastAPI. Solo orquesta: toda lógica vive en packages.
  /web            React SPA. 7 perfiles, un router con guards por rol.
/packages
  /authz          Policy engine ABAC. ÚNICA puerta a datos sensibles.
  /workflow       Motor de metadatos: procesos = datos (etapas, forms, SLA, escalamientos).
  /solicitudes    RF-001..  (ingreso, seguimiento, renovaciones)
  /evidencias     RF-...    (ciclo de evidencia, acreditación por sede, escalamiento)
  /documentos     RF-021..028 (generación resoluciones/cartas, versionado vía SharePoint en prod / MinIO en dev)
  /adecuaciones   RF-...
  /cuidados       RF-037..042 (reusar motor Ley 21.790 existente de Pablo — ver ADR-003)
  /comunicaciones RF-063..070 (notificaciones, bandejas, plantillas)
  /ficha          Vista integradora del estudiante (módulo 6 del PDF, sin rango RF propio).
                  Solo COMPONE datos de los demás módulos vía contracts; no posee tablas
                  de negocio propias. Cada perfil ve su recorte autorizado (authz decide).
  /reportes       Dashboards e indicadores en línea: dashboard ejecutivo Rectoría
                  (solo agregados, k-anonimato → ADR-002), reportes de cumplimiento,
                  exportación auditoría, dataset para Power BI (vía PowerBIAdapter).
  /audit          Bitácora inmutable de toda mutación y todo acceso denegado
  /contracts      Tipos/DTOs compartidos entre módulos (única forma de hablarse)
  /seed           Datos chilenos realistas + generador de datos sucios (881 registros)
/mocks
  /banner         Mock OpenAPI (Prism) de APIs Ellucian: estudiantes, matrícula, avance
  /firma          Mock 2 endpoints (enviar, estado) + panel fake de firma
  /progresion     Mock API de progresión/retención/titulación (integración cap. 9 del PDF)
  # SSO/SharePoint: NO se mockean → tenant real M365 Developer Program
  # Power BI: no se mockea → PowerBIAdapter expone dataset consumible (dev: endpoint JSON/CSV)
/e2e              Playwright: flujos completos por perfil
/redteam          Agente adversarial: intenta exfiltrar datos clínicos como docente
/specs            Fuente de verdad (este directorio)
```

## Modelo de datos — separación dura
- Esquema `public`: usuarios, solicitudes, procesos, evidencias, documentos, auditoría.
- Esquema `clinical`: diagnósticos, informes médicos, antecedentes de salud.
  - FK por id opaco. Sin joins directos desde public.
  - Acceso exclusivamente vía `authz.clinical_gate(actor, recurso, propósito)`.
  - Serializers de API con allowlist explícita de campos por rol (nunca blocklist).

## Policy engine (authz)
- ABAC: decide(actor{rol, sede, relación_con_estudiante}, acción, recurso, contexto).
- Implementa las 4 reglas "por diseño" del RFP: docente-clínico, jefatura-clínico,
  scoping territorial de sede, y agregación-only para Rectoría (el k-anonimato en
  dashboards es decisión de diseño nuestra, no exigencia del RFP → docs/decisiones/ADR-002).
- Toda denegación → evento en audit con vector de intento.
- Matriz de permisos VIVE EN DATOS (editable), con tests que la congelan por rol
  usando la tabla exacta de specs/contexto-aiep.md.

## Motor de workflow (metadatos)
- Proceso := {etapas[], transiciones[], formularios[] (JSON Schema), roles_por_etapa,
  SLA_por_etapa, escalamientos[], documentos_generables[]}.
- UI de administración permite crear proceso nuevo completo sin deploy (prueba RF-020:
  el "noveno proceso" lo crea un agente-funcionario usando solo la UI + manual).
- Renovaciones semestrales: procesos pueden declarar recurrencia; el motor abre
  instancias hijas y arrastra adecuaciones vigentes (~50% de la carga real son renovaciones).
- TRES procesos seed: (1) Solicitudes de apoyo con las 7 etapas y SLA reales
  (Recepción inmediata, Evaluación 5dh, Resolución 5dh, Aplicación 3dh, Evidencia
  por período, Cierre automático; devolución automática si faltan antecedentes),
  (2) Portal de Cuidados, (3) Exploración NEE/Discapacidad Severa — este último
  se crea VIA UI para probar RF-020.
- Evidencias: apertura/cierre automático de período, checklist por caso,
  recordatorios D-15/D-7/D-1, escalamiento, semáforo por sede, bloqueo de cierre
  sin evidencia validada (formato+fecha+coherencia con lo aprobado).
- Multi-caso por estudiante (22,7% de solicitudes son complementarias de casos abiertos).

## Gates de CI (se instalan ANTES del primer módulo)
1. pytest + coverage mínima por package
2. vitest + Playwright e2e por perfil
3. lint (ruff, eslint) + typecheck (mypy strict, tsc strict)
4. axe-core: 0 violaciones WCAG 2.1 AA en toda ruta
5. redteam: 0 exfiltraciones clínicas en el set de vectores
6. fuzzing de propiedades del workflow (fast-check): 0 invariantes rotas

## Conmutabilidad de integraciones
Cada integración es un adapter con interfaz en /contracts:
- BannerAdapter → mock (dev) | real (prod, cambia URL+credenciales)
- FirmaAdapter → mock | proveedor real
- IdentityAdapter → tenant M365 dev | tenant AIEP
- StorageAdapter → MinIO | SharePoint
- ProgresionAdapter → mock | sistema real de progresión/retención/titulación (cuál es: DUDAS.md)
- PowerBIAdapter → endpoint dataset JSON/CSV (dev) | dataset/push a Power BI institucional (prod)
El código de negocio NO sabe contra cuál corre.
