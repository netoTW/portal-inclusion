# RF-051 — Cierre automático del período

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-043, RF-049, RF-050
**Inferencia:** del bloque Evidencias (cap. 7: "apertura y cierre automáticos"),
figura 3.2 (paso 5) y etapa 7 ("cierra el período… y actualiza indicadores en línea").

## Descripción
En la fecha programada, el período cierra solo: congela el resultado de cada caso
(acreditado / parcial / sin evidencia), sella los archivos de ciclo (RF-050), dispara
los eventos de cierre de caso donde corresponde (RF-052) y produce el resultado por
sede que alimenta reportes y semáforo. Nadie "cierra el ciclo" a mano consolidando
planillas — eso era días de trabajo del equipo nacional.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | ver su resultado del período (qué quedó acreditado, qué no y por qué) |
| Jefatura de Escuela | ver resultado agregado de sus estudiantes |
| Docente | nada |
| Secretaría General | consulta |
| Equipo nacional GDI | ver el resultado nacional; ejecutar cierre excepcional (RF-043) |
| Rectoría/Vicerrectorías | resultado agregado vía reportes |

## Datos que toca
- Entidades: resultado del período por caso (congelado) y por sede (derivado),
  evento de cierre.
- ¿Datos clínicos? NO.

## Flujo principal
1. Fecha de cierre cumplida → job idempotente cierra el período.
2. Por caso: congela el estado final de su checklist; acreditados disparan la
   habilitación de cierre de caso (RF-052 la consume); no acreditados quedan con su
   detalle exacto (qué ítems faltaron y en qué estado).
3. Por sede: se computa el resultado (N casos, % acreditado) → histórico (RF-059) y
   semáforo/reportes (Tanda 4).
4. Avisos de cierre: cada sede recibe su resultado; GDI el nacional. Indicadores en
   línea se actualizan al tiro (etapa 7).

## Flujos alternos / casos borde
- Subsanaciones EN CURSO al momento del cierre (cargada, esperando validación): la
  validación pendiente se completa y cuenta si la CARGA fue dentro del plazo — el
  cierre no castiga la cola de procesamiento propia.
- Caso con ítems observados al cierre: queda NO acreditado con el detalle; la
  regularización tardía existe pero marca fuera de plazo (métricas honestas).
- Job caído: cierra al reanudar, con los cómputos a la fecha PROGRAMADA (las cargas
  posteriores a la fecha programada no cuentan aunque el job haya corrido tarde).
- Extensión del cierre (RF-043) anula el cierre programado anterior y reprograma todo.

## Criterios de aceptación
- [ ] CA-1: al cierre del período seed, cada caso queda con su resultado correcto
      según sus ítems, el resultado por sede cuadra con los casos, y los indicadores
      reflejan el cierre sin acción manual.
- [ ] CA-2: carga hecha a las 23:59 del último día cuenta; a las 00:01 del día
      siguiente no existe vía normal de carga (test de borde temporal, zona horaria
      de Chile).
- [ ] CA-3 (negativo): nadie puede editar el resultado congelado de un caso o sede
      (no existe la acción; regularizaciones van con marca aparte) — intento API →
      403 + audit.
- [ ] CA-4 (accesibilidad): la vista de resultado del período (sede y GDI) es tabla
      semántica con totales, navegable por teclado; axe 0.

## Propiedades (fuzzing)
- P1: resultado por sede = derivación exacta de los resultados por caso (nunca
  almacenado independiente que pueda divergir).
- P2: cerrado el período, el conjunto {resultados congelados} es inmutable ante
  cualquier secuencia posterior de eventos (las regularizaciones se registran aparte).

## Fuera de alcance
- Recordatorios previos al cierre (RF-053, Tanda 4) y semáforo (RF-056).
- Reapertura de período: NO existe (solo extensión previa al cierre, RF-043).

## Dudas abiertas
- ¿Las validaciones pendientes al cierre esperan horas o días? (define el momento del
  aviso de resultado — hoy: el aviso sale cuando la cola termina, con corte a fecha
  programada).
