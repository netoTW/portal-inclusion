# RF-046 — Tablero de evidencias de la sede

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-044, RF-045, design-system (bandeja, semáforo)
**Inferencia:** de la figura 3.2 (paso 2: "cada sede ve qué le falta y de qué caso";
"caso marcado en rojo en su tablero") y del pedido textual de las sedes (espacio de
trabajo dentro del sistema, no correos).

## Descripción
El lugar de trabajo de la sede durante el período: todos sus casos con evidencias
pendientes, qué falta de cada uno, cuánto plazo queda y qué está en rojo. Ordenado
por urgencia, con la carga a un click. La sede no reconstruye su pendiente desde
correos: lo VE.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | ver y operar el tablero de SU sede completo |
| Jefatura de Escuela | nada (su vista es por estudiante, no el tablero de sede) |
| Docente | nada |
| Secretaría General | nada |
| Equipo nacional GDI | ver el tablero de CUALQUIER sede (modo lectura + gestión directa RF-058, Tanda 4) |
| Rectoría/Vicerrectorías | nada (agregados vía reportes) |

## Datos que toca
- Entidades: LEE checklists, casos, plazos, estados (no tiene datos propios — es vista).
- ¿Datos clínicos? NO visibles: el tablero muestra folio, estudiante, apoyos aprobados
  y estado de evidencias [S-20].

## Flujo principal
1. DAE entra al tablero: resumen arriba (total, al día, por vencer, en rojo, validadas
   — iconos+texto) y la lista de casos ordenada por urgencia.
2. Filtros: estado del ítem, tipo de apoyo, escuela, búsqueda por folio/nombre.
3. Click en un caso → checklist (RF-045) con carga en línea (RF-047).
4. El tablero refleja los estados EN VIVO (lo que valida RF-048 sale de "pendiente").

## Flujos alternos / casos borde
- Sede al 100%: el tablero lo celebra explícitamente ("todo acreditado") — el estado
  vacío es información, no pantalla en blanco.
- Casos en rojo (RF-054, Tanda 4): anclados arriba, inconfundibles sin depender del color.
- Período cerrado: el tablero pasa a modo histórico (solo lectura, con su resultado).
- GDI mirando el tablero de una sede: banner "viendo como GDI — sede X" (nunca
  confusión de contexto).

## Criterios de aceptación
- [ ] CA-1: con datos seed (sede con casos en todos los estados), el tablero muestra
      resumen correcto y ordena por urgencia real (vencidos → por vencer → al día).
- [ ] CA-2: cargar y validar una evidencia actualiza el tablero sin recargar (o con
      recarga explícita accesible) y los contadores cuadran.
- [ ] CA-3 (negativo): DAE de sede A no accede al tablero de sede B por ninguna ruta
      (el scoping se inyecta en el repositorio, authz.md) + audit del intento.
- [ ] CA-3b (negativo): la respuesta del tablero no contiene campos clínicos (test de
      allowlist del serializer).
- [ ] CA-4 (accesibilidad): tablero completo operable por teclado (filtros, orden,
      navegación a casos), estados con icono+texto, resumen legible por lector de
      pantalla; axe 0. Textos en chileno de gestión ("Por vencer", "Vencido", "Validada").

## Propiedades (fuzzing)
- P1: los contadores del resumen siempre cuadran con la lista filtrada sin filtros
  (consistencia agregado-detalle).

## Fuera de alcance
- Semáforo comparativo entre sedes (RF-056, Tanda 4 — eso lo ve GDI/reportes).
- La gestión directa del equipo nacional (RF-058, Tanda 4).

## Dudas abiertas
- ¿La sede necesita exportar su propio tablero (Excel de trabajo interno)? Hoy no;
  candidato según levantamiento (la exportación formal es RF-060).
