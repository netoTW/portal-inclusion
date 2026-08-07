# RF-027 — Expediente digital del caso

**Módulo:** documentos
**Prioridad:** crítica
**Depende de:** RF-025, RF-050 (evidencias archivadas), audit
**Inferencia:** del bloque Documentos (cap. 7: "expediente digital") y figura 1
("un solo lugar para los datos: expediente digital del estudiante, documentos
versionados"). El dolor de origen: información de un mismo estudiante repartida
entre portal, correos, planillas, SharePoint y carpetas locales (cap. 2).

## Descripción
Cada caso tiene su expediente digital completo y ordenado: la solicitud como fue
enviada, documentos del estudiante, resoluciones y cartas, evidencias (los tres
modos, ADR-004), comunicaciones formales y su bitácora — organizado por secciones y
cronología. El expediente ES el caso; nada del caso vive fuera de él.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver el expediente de SU caso en su recorte (sin notas internas) |
| Sede (DAE) | expediente operativo de sus casos [S-20] |
| Jefatura de Escuela | recorte: resoluciones y adecuaciones de sus estudiantes |
| Docente | nada (su vista es el panel de adecuaciones/eventos) |
| Secretaría General | expediente para resolver (clínico vía gate) |
| Equipo nacional GDI | expediente completo |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: estructura del expediente (secciones tipadas: solicitud · documentos
  del estudiante · resoluciones y cartas · evidencias · comunicaciones · bitácora),
  índice por caso. Los CONTENIDOS viven en sus módulos; el expediente los ORGANIZA
  (como la ficha, compone vía contracts — la ficha agrega por ESTUDIANTE, el
  expediente por CASO).
- ¿Datos clínicos? El expediente incluye la sección clínica PARA quien cruza el gate;
  para los demás la sección no existe (ni vacía ni bloqueada: no se serializa).

## Flujo principal
1. Desde cualquier vista del caso, "Expediente" abre el índice por secciones +
   cronología integrada.
2. Cada sección lista sus documentos con versión vigente (historial según RF-025).
3. El recorte por perfil es el de authz — misma consulta, distinto resultado (patrón
   ficha-estudiante.md).

## Flujos alternos / casos borde
- Caso multi-ciclo (renovaciones): el expediente enlaza madre↔hijas; cada caso su
  expediente, la cadena navegable.
- Migración: los 881 registros históricos construyen expedientes retroactivos con lo
  que exista (huecos visibles como "sin registro histórico", no inventados).
- El legajo de auditoría (RF-050/060) se ARMA desde el expediente — misma fuente.

## Criterios de aceptación
- [ ] CA-1: caso seed completo → expediente con todas las secciones pobladas y
      cronología correcta; el mismo expediente visto como estudiante, DAE, jefatura
      y GDI muestra exactamente los recortes de la tabla de permisos.
- [ ] CA-2: caso renovado → cadena madre↔hija navegable.
- [ ] CA-3 (negativo): la respuesta del expediente para docente no existe (403);
      para jefatura no serializa sección clínica ni documentos del estudiante
      (allowlist verificada campo a campo — es EL punto de riesgo de agregación
      junto a la ficha; vectores dedicados del red team).
- [ ] CA-4 (accesibilidad): índice de secciones como navegación semántica; cronología
      como lista ordenada; todo por teclado; axe 0.

## Propiedades (fuzzing)
- P1: todo documento/evidencia/comunicación de un caso aparece en exactamente una
  sección de su expediente (completitud sin duplicación).

## Fuera de alcance
- La ficha del ESTUDIANTE (specs/ficha-estudiante.md — vista por persona; este RF es
  por caso).
- El archivo de evidencias en sí (RF-050 — aquí se integra).

## Dudas abiertas
- ¿Estructura formal de expediente exigida por normativa interna AIEP (secciones
  obligatorias)? — levantamiento.
