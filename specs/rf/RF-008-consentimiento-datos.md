# RF-008 — Consentimiento de datos

**Módulo:** solicitudes
**Prioridad:** crítica
**Depende de:** RF-002, audit; marco: ADR-003 [S-14]
**Inferencia:** del bloque Solicitudes (cap. 7: "consentimiento de datos"), diseño
según [S-10]: se otorga al crear la primera solicitud, queda versionado y auditado.
Tratamiento de datos de salud = categoría especialmente protegida (Ley 21.719,
vigente 01-12-2026, antes del go-live).

## Descripción
Antes de enviar su primera solicitud, el estudiante lee y acepta el consentimiento
informado: qué datos se tratan (incluidos datos de salud), para qué, quiénes los ven
según perfil, y sus derechos. Sin aceptación no hay envío. La aceptación queda
registrada con versión exacta del texto, fecha/hora y evidencia del acto.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | leer, aceptar; ver DESPUÉS qué aceptó y cuándo (su vista de privacidad) |
| Sede (DAE) | ver el ESTADO (consentimiento vigente sí/no) de casos de su sede |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | ver estado al resolver |
| Equipo nacional GDI | editar el TEXTO (nueva versión), ver estados; nunca aceptar por el estudiante |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: versión de consentimiento (texto completo, vigente desde), aceptación
  (estudiante, versión, timestamp, contexto del acto).
- ¿Datos clínicos? NO (el consentimiento habilita el tratamiento; no contiene salud).

## Flujo principal
1. Primera solicitud: antes del envío, pantalla de consentimiento — texto completo
   navegable, en chileno claro, con resumen por secciones ("qué guardamos", "quién ve
   qué", "tus derechos").
2. Aceptación explícita (checkbox + botón, nunca pre-marcado) → registro con versión
   y timestamp en audit.
3. Solicitudes siguientes: no se re-pide mientras la versión aceptada siga vigente.

## Flujos alternos / casos borde
- GDI publica versión nueva del texto: los estudiantes con casos activos deben
  re-aceptar en su próximo ingreso ANTES de nuevas solicitudes; los casos en curso
  siguen (la base legal del tratamiento en curso no se corta por re-versión — nota
  jurídica a validar, ADR-003).
- Rechazo del consentimiento: no puede enviar; pantalla explica alternativas
  presenciales (texto de GDI). El rechazo NO queda como estigma (solo ausencia de
  aceptación).
- Retiro del consentimiento post-envío: NO diseñado todavía — duda MEDIA en DUDAS.md
  (interacción con obligaciones legales de AIEP de conservar expedientes).
- Menores de edad: AIEP tiene matrícula de 16-17 años y la Ley 21.719 trata distinto
  el consentimiento de menores — SIN diseño todavía, duda propia en MEDIA (DUDAS.md).

## Criterios de aceptación
- [ ] CA-1: primera solicitud exige aceptación; queda registrada (versión, timestamp)
      y visible para el estudiante en su vista de privacidad.
- [ ] CA-2: segunda solicitud con versión vigente no re-pide; nueva versión publicada
      sí re-pide antes de una nueva solicitud.
- [ ] CA-3 (negativo): el envío por API sin aceptación registrada → 403 con motivo,
      aunque el cliente salte la pantalla.
- [ ] CA-4 (accesibilidad): el texto completo es navegable por teclado y lector de
      pantalla (no un PDF embebido inaccesible); la aceptación es un control nativo
      etiquetado; axe 0.

## Propiedades (fuzzing)
- P1: toda solicitud enviada tiene una aceptación de consentimiento anterior a su
  envío, de una versión que estaba vigente en ese momento.

## Fuera de alcance
- Texto legal real (lo redacta AIEP/jurídica; seed usa un texto placeholder marcado).
- Consentimiento del TERCERO cuidado (Portal de Cuidados — se diseña en la Tanda 7,
  duda ya registrada).

## Dudas abiertas
- Retiro de consentimiento con casos activos/cerrados: NO diseñado por decisión
  explícita — choca con la conservación de expedientes; pregunta jurídica para AIEP,
  no para inventar (MEDIA).
- ¿Cómo se maneja el consentimiento de estudiantes menores de 18 (consiente el
  estudiante, el apoderado, o ambos)? Marco ADR-003 (MEDIA).
