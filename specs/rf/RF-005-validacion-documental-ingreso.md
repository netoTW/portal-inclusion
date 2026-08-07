# RF-005 — Validación documental automática en el ingreso

**Módulo:** solicitudes
**Prioridad:** crítica
**Depende de:** RF-001, RF-002, validacion-documental (motor y catálogo)
**Inferencia:** del bloque Solicitudes (cap. 7: "validación documental automática") y
módulo 1 ("carga y validación de documentos obligatorios… validación previa al envío",
etapa 1 del cap. 6). La maquinaria es specs/validacion-documental.md (nivel 1).

## Descripción
Al armar su solicitud, el estudiante ve el checklist exacto de documentos del tipo
elegido y la plataforma valida cada carga EN LÍNEA: formato, tamaño, vigencia por
fecha. Lo inadmisible se rechaza al tiro con motivo claro — la solicitud llega a
Evaluación completa o no llega. (La decisión de fondo sigue siendo humana: nivel 2.)

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver checklist con ayuda por documento, cargar, reemplazar antes de enviar |
| Sede (DAE) | ver el ESTADO del checklist de casos de su sede (completo/incompleto; no el contenido clínico [S-20]) |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | ver documentos al resolver (vía clinical_gate) |
| Equipo nacional GDI | ver todo; configurar checklists (validacion-documental) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: ítems de checklist por solicitud (estado, documento cargado, resultado de
  validación), documentos (almacenados vía StorageAdapter).
- ¿Datos clínicos? SÍ: certificados e informes médicos van DIRECTO al esquema clinical
  (metadatos + puntero de storage); jamás transitan por tablas public.

## Flujo principal
1. El estudiante ve el checklist del tipo: cada ítem con nombre, por qué se pide,
   formatos aceptados y vigencia (texto del catálogo).
2. Carga un archivo → validación inmediata: formato permitido, tamaño máximo,
   vigencia por fecha de emisión declarada/extraída.
3. Ítem inválido = rechazado en línea con motivo en chileno claro ("el certificado
   debe tener menos de 6 meses; este es de enero de 2025").
4. Con los obligatorios en verde se habilita el envío (RF-006).

## Flujos alternos / casos borde
- Ítems opcionales: visibles y marcados como tales; no bloquean envío.
- Fecha de emisión no extraíble del archivo: el estudiante la declara; GDI la
  verifica en evaluación (la declaración queda auditada).
- Archivo corrupto/ilegible: rechazo con sugerencia (re-escanear, PDF).
- Documento que vence entre el envío y la evaluación: NO se re-valida solo — el
  criterio de vigencia se evalúa a fecha de ENVÍO. Fundamento: es la regla justa para
  el estudiante — la demora de la evaluación no puede vencerle un documento que era
  válido al enviarlo. [Regla inferida — duda al levantamiento se mantiene.]
- Faltantes detectados DESPUÉS del envío (por GDI): RF-014 (solicitud de antecedentes).

## Criterios de aceptación
- [ ] CA-1: con el checklist seed de "Adecuación menor", cargar un PDF válido pasa,
      un .exe se rechaza, un certificado vencido se rechaza con motivo correcto.
- [ ] CA-2: el envío está bloqueado (UI y API) hasta completar los obligatorios;
      el intento por API directa con checklist incompleto → 422 con detalle.
- [ ] CA-3 (negativo): documento clínico cargado no es accesible para Docente/
      Jefatura/DAE por ninguna ruta (descarga directa por URL adivinada incluida:
      el storage no sirve nada sin pasar por authz) + audit del intento.
- [ ] CA-4 (accesibilidad): componente de carga operable por teclado, progreso y
      errores anunciados; axe 0.

## Propiedades (fuzzing)
- P1: ninguna solicitud ENVIADA tiene ítems obligatorios sin documento válido
  (a fecha de envío).
- P2: todo documento cargado tiene exactamente un registro de metadatos y vive en el
  esquema correspondiente a su sensibilidad.

## Fuera de alcance
- Catálogo de requisitos y su edición (validacion-documental.md).
- Evaluación de fondo/recomendación (nivel 2) y firma (RF-021+).
- Antivirus/escaneo de malware: se define con la infraestructura de despliegue
  (nota para arquitectura, no bloquea dev).

## Dudas abiertas
- ¿Vigencia se evalúa a fecha de envío o de evaluación? Hoy: envío.
- Tamaño máximo institucional por archivo y formatos aceptados reales (seed: pdf/jpg/png, 10 MB).
