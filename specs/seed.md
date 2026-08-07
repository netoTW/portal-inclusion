# Seed — datos chilenos realistas + generador de datos sucios

**Package:** `/packages/seed` · **Depende de:** contracts.
Dos productos distintos que comparten catálogos. Nada de esto entra jamás a producción:
son datos SINTÉTICOS. Prohibido usar datos reales de personas (los datos reales llegan
recién en la migración, bajo NDA).

## Producto A — seed limpio (dev, demo, e2e)
Base coherente y navegable para desarrollo y demo ante cliente:
- **Catálogos:** 25 sedes y 7 escuelas con nombres oficiales de AIEP construidos desde
  información pública [S-18]; carreras y asignaturas verosímiles; catálogo de
  condiciones normalizado (derivado de las 41 categorías libres, ver Producto B);
  tipos de apoyo (adecuaciones, acompañante, accesibilidad [S-17]); tipos de solicitud
  con checklists documentales [S-15].
- **Personas:** nombres chilenos realistas, RUT válidos con DV correcto (generador
  propio en contracts), correos institucionales ficticios (@aiepvirtual.test).
- **Usuarios demo:** mínimo 1 por perfil, con DAE de ≥2 sedes distintas, docente con y
  sin estudiantes asignados, jefaturas de ≥2 escuelas (lo exige specs/redteam.md).
- **Casos vivos:** casos en cada etapa del proceso seed 1 (uno al menos por etapa,
  incluidos en_espera, escalado, y cerrado con evidencia validada), casos de Cuidados,
  renovaciones madre→hija, y un estudiante con multi-caso.
- **Calendario hábil:** feriados chilenos 2026-2027 (fuente de la función única de
  días hábiles de contracts; los feriados son DATOS cargados por seed, editables).
- **Determinismo:** semilla fija → mismo output; los e2e y el redteam dependen de eso.

## Producto B — generador de datos sucios (banco de pruebas de la migración)
Reproduce la base real de 881 registros [S-12] CON SUS DEFECTOS, calibrado con
specs/contexto-aiep.md. El pipeline de migración se mide contra esto (% auto-resuelto).

Calibración obligatoria (tolerancia ±1 punto porcentual sobre cada proporción):
| Dimensión | Valores a reproducir |
|---|---|
| Volúmenes por año | 2024: 59 (17 sedes) · 2025: 221 (25) · 2026: 261 (25) |
| Tasa de aprobación por año | 49,2% · 74,2% · 75,9% (total 72,3%) |
| Composición | 85,8% adecuaciones menores · 22,7% complementarias · 263 renovaciones |
| Paralelos | 153 severa (2025-2026) · 187 seguimientos de evidencia |
| Evidencias 2024-25 | 73,3% recibida · 20,3% pendiente (31/38 de 2025) · 6,4% gestión directa; universo 21 sedes: 12 al 100%, Viña 7,7%, Valparaíso 42,9%, Online 64%, Temuco 0%, resto parciales |
| Trazabilidad | 45,8% con fecha resolución · 9,6% recepción sede · 6,7% aviso docente · 0% fecha aplicación |
| Suciedad de catálogos | 32 variantes de nombre para 25 sedes · 16 para 7 escuelas · 41 categorías de causa en texto libre |

- Las variantes sucias se generan con patrones reales de planilla: mayúsculas/minúsculas,
  tildes perdidas, abreviaturas ("Stgo Centro", "VDM"), espacios dobles, sede con región
  pegada. Las 41 categorías libres mapean N:1 al catálogo normalizado con casos borde
  (texto ambiguo que exige decisión humana) en proporción configurable.
- Campos de trazabilidad vacíos DONDE la realidad los tiene vacíos (no aleatorio
  uniforme: correlacionado por año y sede como en las cifras).
- Salida en el formato de origen esperable (CSV/XLSX estilo planilla), no en el esquema
  de la plataforma: migrar ES el ejercicio.

## Criterios de aceptación
- [ ] CA-1: dos corridas con la misma semilla producen bytes idénticos.
- [ ] CA-2: test estadístico verifica cada proporción de la tabla dentro de ±1pp.
- [ ] CA-3: 100% de los RUT generados validan DV con la función de contracts.
- [ ] CA-4: el seed limpio levanta con `docker compose up` + comando único, y deja el
      stack demo-able (login por cada perfil demo funciona).
- [ ] CA-5: el generador sucio produce exactamente 881 registros base [S-12] con las
      32/16/41 variantes contadas.
- [ ] CA-6: ningún dato generado colisiona con RUT de personas reales conocidas
      (rango de RUT sintético reservado).

## Fuera de alcance
- El pipeline de migración mismo (specs/migracion.md, Tanda 9) — aquí solo su banco
  de pruebas.
- Datos del tenant M365 (usuarios reales del tenant dev se crean en sso-m365).
