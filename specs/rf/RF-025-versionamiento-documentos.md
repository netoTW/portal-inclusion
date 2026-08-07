# RF-025 — Versionamiento de documentos

**Módulo:** documentos
**Prioridad:** alta
**Depende de:** RF-022/023, StorageAdapter, audit
**Inferencia:** EXPLÍCITO: "versionamiento" (cap. 7 y módulo 3 del cap. 4).

## Descripción
Todo documento del expediente —generado o cargado— mantiene su historial de versiones
completo: qué cambió, quién, cuándo y por qué. Los firmados son inmutables (RF-024);
los demás versionan sin perder nada. Nunca más "¿cuál era la versión que se envió?".

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver la versión VIGENTE de sus documentos (el historial interno no le aporta; la resolución que descarga es la firmada) |
| Sede (DAE) | ver historial de documentos operativos de sus casos |
| Jefatura de Escuela | versión vigente de lo suyo |
| Docente | nada |
| Secretaría General | historial de lo que firma (qué cambió entre devolución y re-envío — diff visible) |
| Equipo nacional GDI | historial completo de todo |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: versión de documento {documento, número, autor, motivo, archivo
  (StorageAdapter), hash, timestamp}; puntero a versión vigente.
- ¿Datos clínicos? Los documentos clínicos (certificados del estudiante) TAMBIÉN
  versionan (reemplazos de RF-005/014); su historial vive bajo el mismo régimen de
  acceso que el documento (clinical_gate).

## Flujo principal
1. Toda escritura de documento crea versión (nunca sobre-escribe): generación,
   regeneración, reemplazo de carga, corrección.
2. Cada versión con hash — la integridad es verificable (mismo patrón que audit.md).
3. Las vistas muestran la vigente; el historial está a un click para quien tiene
   permiso, con diff cuando aplica (documentos generados: diff de contenido).

## Flujos alternos / casos borde
- Documento firmado: el versionado se CIERRA en la versión firmada (RF-024 P1);
  cualquier cosa posterior es un documento NUEVO que la referencia.
- Eliminación: no existe. Un documento subido por error se marca "erróneo" (visible
  con motivo, excluido de vistas corrientes) — el expediente no pierde historia
  (coherente con audit.md).
- Storage prod = SharePoint: el versionado es DE LA PLATAFORMA (SharePoint es
  backend); las versiones nativas de SharePoint no son la fuente de verdad.

## Criterios de aceptación
- [ ] CA-1: regenerar una resolución pre-firma crea v2 con diff visible para
      Secretaría; v1 íntegra en historial.
- [ ] CA-2: reemplazo de un certificado (RF-014) versiona; la vista del evaluador
      indica que hubo reemplazo.
- [ ] CA-3 (negativo): el historial respeta el régimen del documento (historial
      clínico solo tras clinical_gate); marcar "erróneo" exige motivo y queda
      auditado; no existe ruta de borrado (API 405/403).
- [ ] CA-4 (accesibilidad): vista de historial como lista/tabla semántica con fechas
      DD-MM-YYYY; axe 0.

## Propiedades (fuzzing)
- P1: para todo documento, las versiones son una secuencia estrictamente creciente
  sin huecos y cada una verifica su hash.
- P2: la versión vigente siempre existe y pertenece a la secuencia.

## Fuera de alcance
- Inmutabilidad del firmado (RF-024) y organización del expediente (RF-027).

## Dudas abiertas
- ¿Límite de retención de versiones antiguas de documentos pesados? (se une a la
  duda de retención general de audit.md — levantamiento).
