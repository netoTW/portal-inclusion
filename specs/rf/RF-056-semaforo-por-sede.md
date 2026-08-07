# RF-056 — Semáforo de cumplimiento por sede

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-049/051/054, design-system (semáforo icono+texto)
**Inferencia:** EXPLÍCITO: "semáforo por sede" (cap. 7). Umbrales anclados en la
métrica del cliente (cap. 11): "0 sedes bajo 70% de cumplimiento" — hoy 5 de 21, con
dispersión 100% ↔ 0% (Temuco).

## Descripción
Una vista comparativa del cumplimiento de evidencias por sede: verde / amarillo /
rojo según % de casos acreditados, en vivo durante el período y congelado al cierre.
Es el instrumento con el que GDI focaliza y con el que la meta "0 sedes bajo 70%" se
gestiona — no se descubre al final, se ve venir.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | ver SU semáforo y su posición relativa anónima ("estás bajo la mediana nacional") — no el detalle de otras sedes |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | consulta del panel nacional |
| Equipo nacional GDI | panel nacional completo (todas las sedes, con nombre, drill-down a casos) |
| Rectoría/Vicerrectorías | distribución agregada vía reportes (sin drill-down a casos; sedes como unidad SÍ son visibles — la sede no es dato personal) |

## Datos que toca
- Entidades: cómputo por sede-período {casos, acreditados, %, color, arrastrados},
  umbrales de color (config [RF-061]; seed: verde ≥90%, amarillo 70-89%, rojo <70% —
  el corte 70 viene del cap. 11, el 90 es propuesto).
- ¿Datos clínicos? NO.

## Flujo principal
1. Durante el período abierto: el semáforo se computa en vivo desde los estados
   (RF-049) — misma fuente que los tableros, nunca un cálculo paralelo. Con ADR-004
   los incumplimientos de EVENTO entran EN TIEMPO REAL: una sede con evaluaciones sin
   confirmar se degrada hoy, no al cierre. Las SECCIONES SILENCIOSAS
   (evidencia-eventos.md: aprobados vigentes sin ninguna evaluación registrada a la
   fecha configurable) penalizan como INCUMPLIMIENTO PRESUNTO — el silencio nunca
   mejora el semáforo.
2. Los ARRASTRADOS (RF-054) cuentan contra la sede en el período vigente; los que
   superan el umbral de instancia formal (RF-054) se destacan en el panel GDI con su
   alerta y estado de gestión.
3. Al cierre (RF-051): el semáforo del período se congela al histórico (RF-059).
4. GDI ve el panel nacional ordenable (por %, por arrastre, por tendencia vs período
   anterior); click en sede → su tablero (RF-046, modo GDI).

## Flujos alternos / casos borde
- Sede sin casos en el período: "sin casos" (gris), fuera del cómputo de la meta —
  el denominador de "0 sedes bajo 70%" son las sedes CON casos (por eso hoy es
  "5 de 21", no de 25).
- Sede con 1-2 casos: el % es volátil (1 caso = 0% o 100%); el panel muestra N junto
  al % SIEMPRE (nunca un porcentaje sin su base).
- Cambio de umbrales a mitad de período [RF-061]: recolorea en vivo, queda auditado;
  los históricos congelados NO se recolorean.

## Criterios de aceptación
- [ ] CA-1: con seed calibrado (12 sedes 100%, parciales, Temuco 0%), el panel
      reproduce la distribución esperada, con N visible y "5 de 21 bajo 70%" correcto.
- [ ] CA-2: los cómputos del semáforo cuadran exactamente con los tableros de sede
      (una sola fuente — test de consistencia).
- [ ] CA-3 (negativo): DAE ve solo su sede y su posición relativa anónima (nunca el
      panel con nombres); Rectoría llega solo a la distribución agregada de reportes.
- [ ] CA-4 (accesibilidad): colores con icono+texto+% (design system); panel navegable
      y ordenable por teclado; axe 0.

## Propiedades (fuzzing)
- P1: % de sede = derivación exacta de sus casos (consistencia agregado-detalle,
  hereda P1 de RF-046/RF-051).
- P2: congelado un período, su semáforo histórico es inmutable.

## Fuera de alcance
- Reportes exportables (RF-057) e histórico comparado multi-ciclo (RF-059).
- El dashboard ejecutivo agregado (specs/reportes-dashboards.md).

## Dudas abiertas
- Umbral verde (90% propuesto) y si la posición relativa anónima para DAE es deseada
  o prefieren transparencia total entre sedes — levantamiento (hoy: anónima,
  conservador).
