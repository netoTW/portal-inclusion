# Fuzzing — propiedades del motor y de los invariantes transversales

**Vive en:** `/e2e` + suites por package (fast-check) · Gate de CI nº6:
0 invariantes rotas (specs/arquitectura.md).

## Qué se fuzzea (las propiedades ya declaradas en las specs — esta spec las
consolida como suite ejecutable)
1. **Motor de workflow** (workflow.md P1-P5): una etapa activa; transiciones solo
   de la definición; terminales sin salida; replay de audit reconstruye estado;
   regla de oro inviolable ante secuencias arbitrarias de eventos.
2. **Definiciones generadas** (RF-019 P1/P2, RF-020 P1): generador de definiciones
   de proceso aleatorias válidas e inválidas — las inválidas nunca publican; las
   publicadas siempre son ejecutables.
3. **Authz** (authz.md P1-P3): generador de actores×recursos×acciones — DENY
   clínico para docente ante CUALQUIER combinación; scoping DAE; total y sin 500.
4. **SLA** (RF-015 P1/P2): fechas de entrada y secuencias de pausas arbitrarias —
   vencimientos deterministas, nunca en feriado/fin de semana.
5. **Evidencias** (RF-049 P1/P2, RF-051 P1/P2, evidencia-eventos P1-P3): estados
   por modo sin saltos fantasmas; acreditación derivada; congelados inmutables;
   secciones silenciosas nunca invisibles.
6. **Invariantes transversales espejo** (patrón de verificación cruzada):
   [S-22] independencia vigencia/evidencia (RF-030 P2 = RF-034 P2 = RF-042 P2,
   contra el mismo generador de secuencias); fidelidad del panel docente
   (RF-033 P1/RF-036 P2); exclusión del estudiante de notas internas (RF-069 P1);
   folios únicos (RF-006 P1, RF-028 P1); audit total (audit.md P1-P3).

## Reglas de la suite
- Generadores COMPARTIDOS en /e2e/fuzzing (población, secuencias de eventos,
  definiciones): cada propiedad se fuzzea contra los mismos generadores — un
  invariante espejo roto en un solo lado es señal de deriva entre módulos.
- Semillas de fallo se CONGELAN como casos de regresión (mismo patrón que los
  vectores del red team).
- Presupuesto por corrida de CI (nº de casos) configurable; corrida nocturna larga
  (runner) con presupuesto x100.

## Criterios de aceptación
- [ ] CA-1: la suite corre en CI con todas las propiedades listadas y presupuesto
      corto; nocturna con presupuesto largo.
- [ ] CA-2: un bug sembrado a propósito en una guarda del motor (mutación de
      prueba) es detectado por la suite (test del test — patrón canario del red team).
- [ ] CA-3: toda semilla de fallo histórica corre como regresión fija.

## Dudas
- Ninguna — consolidación técnica de propiedades ya aprobadas.
