# RF-058 — Gestión directa de GDI y regularización tardía

**Módulo:** evidencias
**Prioridad:** alta
**Depende de:** RF-047/049/051/054
**Inferencia:** del dato del cap. 3.1: 6,4% de los casos 2024-25 fueron "gestión
directa del equipo nacional" — la excepción existe en la operación real y hay que
FORMALIZARLA para que no sea un agujero de trazabilidad. La regularización tardía se
definió en Tanda 3 (RF-047/051) y aquí se especifica completa.

## Descripción
Dos capacidades excepcionales, siempre visibles y contadas aparte:
(a) **Gestión directa**: GDI opera el ciclo de evidencias de un caso en lugar de la
sede (cargar, subsanar) cuando la situación lo exige, dejando claro QUE fue gestión
directa y por qué. (b) **Regularización tardía**: habilitar la carga de un caso
incumplido después del cierre, con marca "fuera de plazo" indeleble. Ninguna de las
dos maquilla métricas: la excepción documenta, no disfraza.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | cargar en una regularización habilitada de SUS casos; ver que un caso suyo está en gestión directa |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | consulta |
| Equipo nacional GDI | activar gestión directa (con motivo tipificado); habilitar regularizaciones (con plazo); cargar en gestión directa |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: activación de gestión directa {caso, motivo tipificado + texto, activador,
  vigencia}, habilitación de regularización {caso(s), plazo, motivo}, marca "fuera de
  plazo" en evidencias regularizadas.
- ¿Datos clínicos? NO.

## Flujo principal (gestión directa)
1. GDI activa gestión directa sobre un caso (motivo: sede sin personal, contingencia,
   caso crítico) → la sede es notificada; el caso queda marcado visiblemente.
2. GDI carga/subsana como si fuera la sede (RF-047/049); cada acción registra que el
   actor fue GDI en gestión directa.
3. Al desactivar, la operación vuelve a la sede. La métrica de "gestión directa"
   (hoy 6,4% — la meta implícita es que tienda a cero) se computa por período.

## Flujo principal (regularización tardía)
1. Caso incumplido post-cierre (RF-054) → GDI habilita regularización con plazo.
2. La sede (o GDI en gestión directa) carga; la validación corre igual (RF-048);
   todo queda "fuera de plazo".
3. Regularizado → el caso puede acreditar y cerrar (RF-052); sale del arrastre; el
   período de ORIGEN mantiene su resultado congelado (RF-051) — la regularización
   mejora el presente, no reescribe la historia.

## Flujos alternos / casos borde
- Regularización que también vence: vuelve al arrastre normal (RF-054); habilitar de
  nuevo requiere nueva decisión.
- Gestión directa permanente de facto (activada sin desactivar por meses): visible en
  el reporte del período (antigüedad de activación) — la excepción crónica es un
  hallazgo, no una rutina silenciosa.
- Casos con estudiante egresado (borde de RF-054): la regularización documental
  procede igual; si es imposible, GDI documenta el cierre excepcional (motivo
  tipificado, contado aparte de acreditados Y de anulados — tercera categoría
  visible "cierre excepcional documentado", ver dudas).

## Criterios de aceptación
- [ ] CA-1: gestión directa activada → sede notificada, cargas de GDI marcadas como
      tales, métrica del período la cuenta; desactivación devuelve la operación.
- [ ] CA-2: regularización completa un caso arrastrado → acredita, cierra, sale del
      arrastre; el resultado congelado del período de origen NO cambia; la marca
      fuera de plazo es visible en el expediente y los reportes.
- [ ] CA-3 (negativo): sin habilitación vigente no existe vía de carga post-cierre
      (403/422 + audit); DAE no puede activar gestión directa ni habilitar
      regularizaciones.
- [ ] CA-4 (accesibilidad): las marcas (gestión directa, fuera de plazo) son texto +
      icono en todas las vistas; axe 0.

## Propiedades (fuzzing)
- P1: toda evidencia cargada post-cierre tiene una habilitación de regularización
  vigente que la cubre y la marca fuera de plazo.
- P2: resultados congelados de períodos son invariantes ante cualquier secuencia de
  regularizaciones (refuerza P2 de RF-051).

## Fuera de alcance
- El arrastre y su visibilidad (RF-054); los reportes que exponen estas métricas (RF-057).

## Dudas abiertas
- ¿Existe el "cierre excepcional documentado" como categoría institucional (caso
  imposible de acreditar: estudiante egresado, sede cerrada)? Hoy lo diseñamos como
  tercera categoría contada aparte; confirmar con AIEP — se cruza con la excepción a
  la regla de oro (duda de Tanda 0).
