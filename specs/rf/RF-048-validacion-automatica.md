# RF-048 — Validación automática de evidencias (modo DOCUMENTAL)

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-045, RF-047; define el significado de "validada" [S-21]
**Alcance por ADR-004:** esta validación y el MUESTREO con rondas aplican SOLO al
modo DOCUMENTAL. El modo EVENTO se AUTOVALIDA por cruce (confirmación del docente ×
condiciones de la resolución — sin validación posterior ni muestreo); el modo
ATESTACIÓN queda cumplido con la confirmación estructurada del responsable.
**Inferencia:** de la etapa 6 del PDF (la PLATAFORMA "valida formato, fecha y
coherencia"), figura 3.2 (paso 4: "el sistema valida formato y coherencia") y el
diagnóstico del cap. 3: hoy "recibida" significa que la sede declaró enviar algo,
"no hay validación de formato, fecha ni coherencia con el mecanismo aprobado".

## Descripción
Cada evidencia cargada se valida automáticamente contra su ítem de checklist en tres
dimensiones: FORMATO (tipo de archivo y tamaño admisibles), FECHA (el registro cae
dentro de la ventana exigida — la evidencia es del semestre del apoyo, no un documento
viejo) y COHERENCIA (el tipo de evidencia corresponde al apoyo aprobado según el
catálogo). Lo que pasa queda "validada" [S-21]; lo que no, se devuelve con motivo
exacto (RF-049). Es la diferencia entre el 78,3% declarado de hoy y el ≥95% validado
de la meta.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | ver el resultado de validación de sus cargas, con motivos |
| Jefatura de Escuela | ver estado agregado (validada/pendiente) de sus estudiantes |
| Docente | nada |
| Secretaría General | consulta |
| Equipo nacional GDI | ver todo; revisar por muestreo y REVERTIR una validación (a subsanación, con motivo) [S-21] |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: resultado de validación por evidencia {dimensión, pasó/falló, motivo},
  reglas de validación (del catálogo apoyo→evidencia de RF-045 — configuración, no código).
- **Ronda de muestreo** (el muestreo de GDI es un PROCESO, no una facultad ad-hoc):
  {período, tamaño de muestra, criterio de selección (aleatorio + dirigido a
  evidencias con fecha declarada), ítems revisados, resultado por ítem, tasa de
  reversión}. Toda reversión pertenece a una ronda o a un hallazgo puntual, siempre
  con registro. Fundamento: ante CNA/Superintendencia, "≥95% validado" se defiende
  con un programa de muestreo documentado. La tasa de reversión queda disponible como
  indicador para reportes (RF-062, Tanda 4).
- ¿Datos clínicos? NO.

## Flujo principal
1. Evidencia cargada (RF-047) → validación inmediata y síncrona donde se pueda
   (formato/tamaño en línea), asíncrona corta para el resto (fecha/coherencia).
2. Las TRES dimensiones pasan → ítem "validada" [S-21]; alguna falla → "observada" con
   el motivo exacto por dimensión ("la fecha del registro (03-2025) es anterior al
   semestre del apoyo (2°S 2026)") → subsanación (RF-049).
3. GDI audita por RONDAS de muestreo: abre una ronda sobre el período (tamaño y
   criterio quedan registrados), el sistema selecciona la muestra (aleatoria +
   dirigida a fechas declaradas), GDI revisa ítem por ítem y registra resultado;
   las reversiones notifican a la sede y reabren subsanación. La ronda cierra con su
   tasa de reversión. Los hallazgos fuera de ronda también existen (hallazgo puntual),
   siempre con registro.

## Flujos alternos / casos borde
- Fecha no extraíble del archivo: manda la declarada por la sede (RF-047), marcada
  como "declarada" — visible en el muestreo de GDI (el eslabón débil queda señalizado,
  no escondido).
- Regla de coherencia sin datos para evaluar (ítem genérico de RF-045): valida formato
  y fecha, coherencia queda "no evaluable" y el ítem requiere visto de GDI (excepción
  visible).
- Cambio de reglas del catálogo a mitad de período: evidencias ya validadas NO se
  re-validan (estabilidad); las nuevas cargas usan las reglas nuevas.

## Criterios de aceptación
- [ ] CA-1: matriz de casos seed — {formato malo, fecha fuera de ventana, tipo
      incoherente, todo correcto} → cada una termina en el estado y con el motivo
      exactos.
- [ ] CA-2: una ronda de muestreo completa (abrir → muestra generada según criterio →
      revisar → revertir una → cerrar) deja registro íntegro: composición de la
      muestra, resultados por ítem y tasa de reversión; la reversión reabre
      subsanación y notifica a la sede. No existe reversión sin ronda ni hallazgo
      registrado.
- [ ] CA-3 (negativo): la sede no puede marcar "validada" a mano — no existe esa
      acción para ningún rol; solo el motor valida y solo GDI revierte (el intento por
      API → 403 + audit).
- [ ] CA-4 (accesibilidad): los motivos de rechazo son texto claro asociado al ítem
      (aria-describedby), no solo iconografía; axe 0.

## Propiedades (fuzzing)
- P1: "validada" ⇔ las tres dimensiones pasaron (o coherencia no-evaluable CON visto
  GDI registrado). No existe cuarta vía.
- P2: el resultado de validación es determinista para (evidencia, reglas vigentes al
  momento de la carga).

## Fuera de alcance
- Máquina de estados completa del ítem (RF-049).
- Análisis de CONTENIDO del documento (OCR/IA): fuera del alcance comprometido; el
  muestreo humano de GDI cubre el fondo [S-21]. Candidato a "valor agregado" (cap. 12).

## Dudas abiertas
- [S-21] en ALTA: ¿AIEP acepta validación estructural automática como "validada" o
  exige revisión humana? Define la meta ≥95% y el esfuerzo de GDI.
