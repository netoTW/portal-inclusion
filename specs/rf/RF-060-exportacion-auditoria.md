# RF-060 — Exportación para auditoría

**Módulo:** evidencias
**Prioridad:** alta
**Depende de:** RF-050, RF-057, RF-059, audit
**Inferencia:** del bloque Evidencias (cap. 7: "exportación para auditoría"). El
contexto de riesgo del cap. 3: fiscalizaciones de la Superintendencia (Leyes 20.422 y
21.091) y acreditación CNA. Complementa el legajo POR CASO de RF-050 con la
exportación MASIVA por alcance.

## Descripción
GDI arma, para un requerimiento externo (fiscalización, CNA, auditoría interna), un
paquete completo y verificable: alcance elegido (período, sede, muestra de casos),
con evidencias, resultados de validación, rondas de muestreo, escalamientos,
regularizaciones y la trazabilidad de cada caso — más un índice y un manifiesto de
integridad. De "días de trabajo manual" a minutos.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | nada (las exportaciones formales las emite GDI; su operación diaria es RF-057) |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | solicitar a GDI / consultar exportaciones emitidas |
| Equipo nacional GDI | definir alcance, generar, descargar; ver el registro de exportaciones |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: exportación {alcance, solicitante/motivo, contenido (índice), manifiesto
  de integridad (hashes), fecha, generador}; registro permanente de exportaciones.
- ¿Datos clínicos? El paquete puede incluir documentos del expediente SEGÚN el
  requerimiento: el alcance define si van antecedentes clínicos (fiscalización con
  base legal) o solo evidencias de implementación (CNA). El nivel elegido queda
  REGISTRADO en el manifiesto y la exportación con clínicos exige doble confirmación
  + motivo (cruce del clinical_gate auditado, authz.md).

## Flujo principal
1. GDI define el alcance: período(s), sede(s) o lista de folios; nivel documental
   (con/sin clínicos); formato (ZIP estructurado con índice CSV/PDF).
2. La plataforma genera el paquete: por caso, su legajo (RF-050) + trazabilidad
   (RF-018/audit) + resultados y rondas; más los agregados del alcance (RF-057/059).
3. Manifiesto de integridad: hash por archivo y del paquete — el receptor puede
   verificar que nada se alteró después de generado.
4. La exportación queda registrada (quién, qué alcance, qué nivel, cuándo, para qué).

## Flujos alternos / casos borde
- Alcances grandes (período completo, 25 sedes): generación asíncrona con progreso y
  notificación al terminar; el corte temporal es el del INICIO de la generación
  (impreso en el manifiesto).
- Re-generación del mismo alcance/corte: produce contenido equivalente (determinismo
  de RF-057 P1 extendido) — dos auditores con el mismo pedido reciben lo mismo.
- Exportación interrumpida: se descarta completa (nunca un paquete a medias sin
  manifiesto).

## Criterios de aceptación
- [ ] CA-1: exportación de un período seed con 2 sedes → ZIP con índice completo,
      legajos por caso, agregados y manifiesto cuyos hashes verifican.
- [ ] CA-2: la exportación con nivel clínico exige doble confirmación + motivo y
      registra el cruce del gate; la sin-clínicos no contiene NINGÚN campo del
      esquema clinical (test de contenido del paquete).
- [ ] CA-3 (negativo): ningún rol distinto de GDI genera exportaciones (403 + audit);
      la descarga del paquete exige sesión GDI (no hay URL pública).
- [ ] CA-4 (accesibilidad): la pantalla de armado de alcance y el índice PDF son
      accesibles (formulario por teclado; PDF estructurado); axe 0.

## Propiedades (fuzzing)
- P1: todo archivo listado en el índice existe en el paquete y viceversa; el
  manifiesto verifica (integridad interna del paquete, cualquier alcance).

## Fuera de alcance
- El legajo por caso individual (RF-050 — aquí se reusa).
- Entrega al fiscalizador (canal externo a la plataforma).

## Dudas abiertas
- Formato/estructura que exige la Superintendencia y CNA para paquetes (se conecta
  con la duda de RF-050) — levantamiento.
- Política de retención de los paquetes generados (¿se guardan o solo su registro?).
  Hoy: se guarda el manifiesto + registro; el paquete se re-genera bajo demanda.
