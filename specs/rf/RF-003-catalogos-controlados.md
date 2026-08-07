# RF-003 — Catálogos controlados

**Módulo:** solicitudes
**Prioridad:** crítica
**Depende de:** contracts (BannerAdapter), RF-019 (edición de catálogos)
**Inferencia:** del bloque Solicitudes (cap. 7: "catálogos controlados") y del dolor
documentado del cap. 2: 32 variantes de nombre para 25 sedes, 16 para 7 escuelas,
41 categorías de causa principal en texto libre.

## Descripción
Toda dimensión clasificable se elige de un catálogo controlado — nunca texto libre:
sede, escuela, carrera (vienen del sistema académico), condición/causa principal,
tipo de apoyo, motivos de anulación. Es la condición para que los reportes agreguen
bien y para que la migración tenga destino normalizado. "Si sede y escuela vienen del
sistema académico, desaparecen las 32 variantes" (cap. 9 del PDF).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | seleccionar solo desde catálogos (no puede escribir texto libre en dimensiones) |
| Sede (DAE) | usar catálogos; nada de edición |
| Jefatura de Escuela | usar catálogos |
| Docente | usar catálogos |
| Secretaría General | usar catálogos |
| Equipo nacional GDI | editar catálogos PROPIOS (condiciones, tipos de apoyo, motivos); los académicos son solo lectura (vienen del adapter) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: catálogos propios versionados {condición/causa principal, tipos de apoyo
  [S-17], motivos}; catálogos espejo del sistema académico {sedes, escuelas, carreras}
  [S-18] sincronizados vía BannerAdapter (solo lectura local).
- ¿Datos clínicos? La CONDICIÓN del estudiante es dato sensible: el valor elegido vive
  en `clinical` (es diagnóstico declarado); el catálogo en sí (la lista de opciones) es
  público interno.

## Flujo principal
1. Los formularios y filtros consumen catálogos por clave estable (no por string).
2. Sedes/escuelas/carreras se sincronizan del adapter (job + manual); los cambios
   quedan auditados.
3. GDI mantiene los catálogos propios: agregar valor, deshabilitar (nunca borrar si
   está referenciado), fusionar valores (re-mapeo masivo auditado — herramienta clave
   para la migración de las 41 categorías libres). **DEPENDENCIA de specs/migracion.md:
   la migración USA esta herramienta de fusión, no la duplica** (se construye una vez,
   sirve para operar y para migrar).

## Flujos alternos / casos borde
- Valor deshabilitado referenciado por casos históricos: se sigue mostrando en ellos,
  no es elegible para nuevos.
- "Otra condición" como escape: existe pero con texto complementario + tarea de
  revisión GDI (candidato a nuevo valor de catálogo) — el escape no puede volver a ser
  la norma (alerta si supera un % configurable).
- Sede nueva de AIEP: aparece por sincronización, no por tipeo.

## Criterios de aceptación
- [ ] CA-1: ningún formulario del sistema tiene campo de texto libre para sede,
      escuela, carrera, condición o tipo de apoyo (test de inventario de schemas).
- [ ] CA-2: fusionar dos valores de condición re-mapea los casos afectados, deja
      bitácora del mapeo y los reportes agregan bajo el valor final.
- [ ] CA-3 (negativo): editar catálogos requiere GDI (403 al resto + audit); catálogos
      académicos rechazan edición local incluso a GDI.
- [ ] CA-3b (negativo): el valor de condición de un estudiante no aparece para
      Docente/Jefatura en ninguna vista ni export (es clinical).
- [ ] CA-4 (accesibilidad): selectores de catálogo con búsqueda operables por teclado
      (combobox ARIA correcto); axe 0.

## Propiedades (fuzzing)
- P1: toda referencia de dimensión en casos apunta a una clave existente de catálogo
  (no hay strings huérfanos).

## Fuera de alcance
- La sincronización con Banner real (mock-banner; aquí el contrato del adapter).
- La normalización de datos históricos (specs/migracion.md usa la herramienta de fusión).

## Dudas abiertas
- Catálogo real de condiciones: ¿existe una taxonomía institucional o la definimos
  desde las 41 categorías? (insumo del doc extendido / levantamiento).
