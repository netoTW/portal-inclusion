# Motor de SLA y plazos

## Principio
Los SLA son CONFIGURACIÓN de cada etapa de cada proceso, nunca código.
Se construye la maquinaria; los valores los edita GDI desde el panel admin.

## Semántica del reloj
- El reloj de una etapa parte al ENTRAR a la etapa.
- Corre en días HÁBILES chilenos: única función en packages/contracts
  (feriados nacionales + configurables por institución). Nadie la reimplementa.
- PAUSA/REANUDACIÓN: cuando el caso pasa a "en espera de antecedentes del
  estudiante", el reloj del responsable se pausa (SUPUESTO por defecto,
  configurable por etapa: pausar sí/no). Bitácora registra cada pausa.

## Configuración por etapa (editable en panel GDI)
{
  plazo: {cantidad, unidad: dias_habiles|dias_corridos|horas},
  avisos: [ {umbral: 50%|80%|100%|D-15|D-7|D-1, destinatarios, plantilla} ],
  escalamiento: [ {tras_vencimiento: Xh|Xdh, a: rol, plantilla} ],   // cadena ordenada
  al_vencer: {marcar_atrasado, crear_tarea_a: rol, bloquear: no|accion}
  pausa_en_espera: bool
}

## Períodos (evidencias)
Entidad propia: GDI abre período {inicio, cierre, alcance}. El motor calcula
solo los recordatorios D-15/D-7/D-1, el escalamiento y el cierre automático,
con semáforo por sede y bloqueo de cierre de caso sin evidencia validada.

## Valores seed (proceso principal, del RFP — confirmar en levantamiento)
Recepción: inmediata · Evaluación: 5dh (GDI) · Resolución: 5dh (GDI+Secretaría)
· Aplicación: 3dh (sede/escuela/docentes) · Evidencia: período definido · Cierre: automático.

## SUPUESTOS.md (obligatorio mantener)
Todo valor por defecto no confirmado por AIEP se registra ahí con la pregunta
exacta para el levantamiento. Ese archivo alimenta la sección "supuestos" que
el cap. 12 del RFP exige en la propuesta.
