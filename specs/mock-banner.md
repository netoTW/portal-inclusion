# Mock Banner — sistema académico simulado

**Vive en:** `/mocks/banner` · **Sirve a:** BannerAdapter (contracts) [S-06].
Simula las APIs de Ellucian Banner (o el "equivalente" que revele el levantamiento)
con OpenAPI + Prism + datos del seed. El código de negocio NUNCA sabe si habla con
el mock o con el real (conmutabilidad, specs/arquitectura.md).

## Superficie mínima (la que consumen los módulos)
| Recurso | Consumidor |
|---|---|
| Identidad del estudiante (RUT, nombres, correo institucional y personal si existe) | RF-004, ficha, RF-065 (doble canal) |
| Matrícula vigente {sede, escuela, carrera, jornada} | RF-004 (identificación), RF-003 (catálogos espejo) |
| Secciones/ramos inscritos por semestre + docente titular por sección | RF-004 (asignaciones), RF-031/032/033, evidencia-eventos |
| Catálogos: sedes, escuelas, carreras (oficiales) | RF-003 [S-18] |
| Fechas de evaluación por sección — SI EXISTEN (duda ALTA de ADR-004) | evidencia-eventos (fricción docente ~0) |

## Reglas
- OpenAPI versionado en el repo = EL CONTRATO del BannerAdapter; el adapter real de
  producción implementa la misma interfaz de contracts contra las APIs verdaderas.
- Datos servidos = /packages/seed (mismas personas, mismas secciones) — el mock no
  inventa su propia población.
- Escenarios de falla simulables (flag): caído, lento, estudiante no encontrado,
  datos inconsistentes — los módulos DEBEN probarse contra ellos (RF-004 flujos
  alternos).
- El recurso "fechas de evaluación" existe en el mock tras un flag de configuración
  (on/off) para probar AMBOS mundos de la duda ALTA sin re-trabajo.

## Criterios de aceptación
- [ ] CA-1: `docker compose up` levanta el mock; RF-004 identifica un estudiante
      seed de punta a punta contra él.
- [ ] CA-2: los escenarios de falla se activan por flag y los e2e de RF-004/RF-031
      los ejercitan.
- [ ] CA-3: cambiar mock↔real es SOLO configuración (URL+credenciales del adapter);
      test de contrato verifica que ambos implementan la misma interfaz.

## Dudas
- [S-06] Sistema real y sus APIs; correo personal (duda ALTA RF-065); fechas de
  evaluación (duda ALTA ADR-004).
