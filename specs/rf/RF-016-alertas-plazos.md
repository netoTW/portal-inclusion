# RF-016 — Alertas de plazos

**Módulo:** workflow
**Prioridad:** alta
**Depende de:** RF-015, comunicaciones (plantillas)
**Inferencia:** del bloque Workflow (cap. 7: "alertas") y la exigencia transversal de
que el sistema "avisa, recuerda" solo (síntesis cap. 12). Umbrales seed de sla-engine.md.

## Descripción
Antes de que un plazo venza, la plataforma avisa sola a quien corresponde, con
anticipaciones configurables por etapa (50%/80% del plazo, o D-15/D-7/D-1 en períodos).
El recordatorio manual del equipo nacional desaparece (meta cliente: 0 recordatorios
manuales; hoy todos).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | recibir avisos de SUS pendientes (ej. antecedentes faltantes por vencer) |
| Sede (DAE) | recibir avisos de sus casos; ver qué avisos se enviaron (registro) |
| Jefatura de Escuela | recibir avisos de sus tareas |
| Docente | recibir avisos de sus atestaciones pendientes |
| Secretaría General | recibir avisos de su cola |
| Equipo nacional GDI | configurar umbrales/destinatarios/plantillas por etapa; ver el registro completo |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: configuración de avisos por etapa ({umbral, destinatarios, plantilla} —
  sla-engine.md), registro de avisos emitidos (qué, a quién, cuándo, canal).
- ¿Datos clínicos? NO. Los avisos JAMÁS incluyen contenido clínico ni diagnóstico:
  refieren al caso por folio y tipo de pendiente.

## Flujo principal
1. El motor evalúa los relojes activos contra los umbrales configurados (job periódico
   idempotente).
2. Umbral cruzado → genera el aviso con la plantilla, lo envía por el canal (correo +
   campana en la plataforma; "el correo avisa, el trabajo ocurre en la plataforma") y
   lo registra.
3. El aviso enlaza DIRECTO a la acción pendiente (deep link a la tarea/caso).

## Flujos alternos / casos borde
- Reloj pausado: no se emiten avisos de esa etapa mientras dura la pausa.
- Doble emisión: un umbral cruzado se avisa UNA vez por caso-etapa (idempotencia,
  aunque el job corra dos veces o se reinicie).
- Tarea resuelta entre el cálculo y el envío: el aviso se descarta (no avisar de lo ya hecho).
- Destinatario sin correo válido: el aviso queda en la campana + alerta a GDI del canal caído.

## Criterios de aceptación
- [ ] CA-1: etapa con avisos 80%/100%: al cruzar cada umbral se emite exactamente un
      aviso al responsable, con registro y deep link funcional.
- [ ] CA-2: reloj pausado no genera avisos; al reanudar, los umbrales pendientes se
      recalculan contra el nuevo vencimiento.
- [ ] CA-3 (negativo): el cuerpo de ningún aviso contiene datos clínicos ni nombre de
      diagnóstico (test de contenido sobre corpus de avisos generados en seed).
- [ ] CA-3b (negativo): un usuario DAE no recibe ni ve avisos de casos de otra sede.
- [ ] CA-4 (accesibilidad): la campana de notificaciones es operable por teclado y
      anuncia novedades (aria-live polite); axe 0.

## Propiedades (fuzzing)
- P1: ∀ caso-etapa-umbral: cantidad de avisos emitidos ∈ {0,1}; 1 solo si el umbral
  fue cruzado con reloj activo y la tarea seguía pendiente.

## Fuera de alcance
- Qué pasa DESPUÉS del vencimiento (RF-017 escalamiento).
- Motor de plantillas y registro de acuses (bloque comunicaciones, RF-063+).
- Recordatorios D-15/D-7/D-1 del período de evidencias (RF-043+ los configura usando
  esta misma maquinaria).

## Dudas abiertas
- ¿Frecuencia máxima tolerable de avisos por usuario (anti-spam)? Las sedes se quejaron
  de sobrecarga de correos: definir agrupación de avisos (digest) en levantamiento.
