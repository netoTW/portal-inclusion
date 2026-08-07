# ADR-001 — Arquitectura híbrida: núcleo a medida + ecosistema M365

**Fecha:** 07-08-2026
**Estado:** aceptada
**Decisores:** Pablo Herrera (arquitectura/negocio)

## Contexto

AIEP exige una plataforma que automatice el ciclo completo de apoyos e inclusión
(70 RF, 7 perfiles, datos clínicos sensibles, go-live enero 2027) e integraciones con
su ecosistema institucional: Microsoft 365 (SSO, correo), SharePoint (repositorios
documentales), Power BI (analítica) y firma electrónica (cap. 9 del RFP).

Se evaluaron dos extremos:

1. **Power Platform completo** (Power Apps + Power Automate + Dataverse): acelera
   formularios y flujos, pero (a) el licenciamiento por usuario/app encarece el
   despliegue a 25 sedes y miles de estudiantes, y (b) el diferenciador del proyecto —
   el motor de procesos parametrizable con SLA, evidencias y policy engine clínico —
   quedaría implementado sobre una plataforma de terceros, limitando su reutilización
   como producto propio y el control fino de las reglas de acceso "por diseño".
2. **Todo a medida, incluido identidad, documentos y BI:** reinventa piezas que la
   institución ya opera y paga, y aleja la plataforma del ecosistema donde viven los
   usuarios (correo, SSO institucional).

## Decisión

Arquitectura **híbrida**:

- **Núcleo a medida** (FastAPI + React + Postgres): motor de workflow por metadatos,
  SLA, evidencias, adecuaciones, policy engine ABAC con separación dura de datos
  clínicos, auditoría. Es el activo diferenciador y queda bajo control total.
- **Ecosistema M365 para lo que la institución ya tiene:**
  - **Entra ID** → SSO institucional (IdentityAdapter).
  - **SharePoint** → repositorio documental en producción (StorageAdapter; MinIO en dev).
  - **Power BI** → consumo de la analítica institucional (PowerBIAdapter expone el
    dataset agregado; ver [ADR-002](ADR-002-k-anonimato-dashboards.md)).
- **Descartado Power Platform completo** por costo de licenciamiento a esta escala y
  por proteger el núcleo diferenciador como IP propia.

Toda integración pasa por un adapter conmutable definido en `/packages/contracts`
(`specs/arquitectura.md`): el código de negocio no sabe contra qué implementación corre.

## Consecuencias

- (+) El motor de procesos/evidencias es reutilizable como producto para otras
  instituciones; el precio se defiende por valor, no por horas.
- (+) Dev 100% local (`docker compose up`), sin dependencia de tenant cloud para
  construir; el tenant M365 Developer se usa solo para SSO/SharePoint reales.
- (+) Las 4 reglas de acceso "por diseño" se implementan y se atacan (red team) en
  código propio, no contra las limitaciones de un RBAC de terceros.
- (−) Asumimos el costo de construir UI de administración de flujos y formularios que
  Power Apps habría regalado (mitigado: es exactamente el RF-020 y la prueba de
  parametrización que el RFP exige).
- (−) Dependencia de tres puntos de integración M365 cuya configuración real depende
  de AIEP (tenant, permisos de SharePoint, workspace de Power BI) → supuestos y
  dependencias explícitas en la propuesta (cap. 12 del RFP).
