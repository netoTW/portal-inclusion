# Motor de workflow — procesos como datos

**Package:** `/packages/workflow` · **Depende de:** contracts, authz, audit, sla-engine.
El corazón del sistema (figura 1 del PDF: "exactamente lo que hoy hace el equipo
nacional a mano"). Regla absoluta (RF-020, CLAUDE.md): agregar o modificar un proceso
NO requiere tocar código. Los procesos, sus formularios y sus reglas son DATOS.

## Definición de proceso (metadatos, editable en panel GDI)
```
Proceso := {
  clave, nombre, version,
  etapas[]        : {clave, nombre, roles_responsables[], sla_ref, formularios[],
                     acciones_entrada[], acciones_salida[], pausa_en_espera},
  transiciones[]  : {desde, hacia, evento, guardas[], acciones[]},
  formularios[]   : JSON Schema + UI hints (los renderiza el front dinámicamente),
  documentos_generables[] : ref a plantillas del módulo documentos,
  recurrencia     : null | {periodo: semestral, que_arrastra: [tipos de apoyo]},
  requiere_evidencia_para_cierre : bool
}
```
- **Versionado:** las definiciones son inmutables una vez publicadas; editar crea
  versión nueva. Un caso EN VUELO sigue la versión con la que partió; los casos nuevos
  toman la última. Migrar casos en vuelo a otra versión = acción explícita de GDI,
  auditada.
- **Validación de definiciones:** el motor rechaza definiciones malformadas al
  publicar: etapa inalcanzable, transición a etapa inexistente, sin etapa inicial o
  final, guarda que referencia campo inexistente del formulario.

## Instancias (casos)
- Número único de caso, generado en Recepción (formato: DUDAS.md; supuesto provisional
  `PIC-AAAA-NNNNN`).
- **Multi-caso por estudiante** (22,7% complementarias): un estudiante puede tener N
  casos abiertos, de procesos iguales o distintos, cada uno con su ciclo completo.
- Estado: exactamente UNA etapa activa por caso, más sub-estado `en_espera` (de
  antecedentes) que pausa el reloj según configuración [S-16].
- Historia completa de transiciones con actor, timestamp y datos del evento → audit.

## Transiciones
- **Guardas:** permiso del actor (vía authz.decide), condiciones sobre datos del caso
  (ej. "checklist documental completo"), estado de dependencias (ej. "resolución firmada").
- **Acciones** (catálogo del motor, componibles por configuración): generar documento
  desde plantilla, notificar (vía comunicaciones, con plantilla), abrir tareas fechadas,
  solicitar antecedentes al estudiante (devolución automática + en_espera), asignar
  responsable, iniciar/detener reloj SLA, registrar atestación de 1 click [S-04].
- **Los dos cierres** [S-09]: `cierre_administrativo` (transición ejecutada por
  Secretaría General) y `cierre_de_caso` (transición automática de la plataforma).
  Guarda dura del cierre de caso: si `requiere_evidencia_para_cierre`, NO existe ruta
  de transición a cerrado sin evidencia VALIDADA (regla de oro). Ni siquiera GDI puede
  saltarla; la excepción institucional (si existiera) es pregunta de levantamiento.

## Anulación de casos (tercer estado terminal)
`anulado` es terminal y DISTINTO de los dos cierres: el caso no completó su ciclo.
- **Motivos tipificados** (catálogo editable, motivo SIEMPRE obligatorio + texto libre):
  desistimiento del estudiante · retiro o congelamiento del estudiante a mitad de
  proceso · caso creado por error / duplicado.
- **Permisos** [S-19]: el ESTUDIANTE puede desistir de su propio caso mientras no
  exista resolución firmada; desde la resolución en adelante, solo ANULACIÓN
  ADMINISTRATIVA por Equipo GDI (los efectos sobre adecuaciones ya otorgadas los
  define el módulo adecuaciones: revocación con vigencia acotada, no borrado).
  Ningún otro perfil anula.
- **Efectos al anular:** se cancelan todas las tareas pendientes del caso, se detienen
  todos los relojes SLA y avisos programados, se notifica a los involucrados activos
  (responsable de etapa, sede si tenía tareas), y NO se exige evidencia. El expediente
  y su bitácora se conservan completos (nada se borra).
- **Sin reapertura:** un caso anulado no admite más transiciones. Si corresponde
  retomar, se crea un caso nuevo que referencia al anulado (visible en la ficha).
- Toda anulación queda en audit con motivo, actor y estado en que se encontraba el caso.

## Renovaciones (recurrencia) [S-05]
- Al abrir el semestre, el motor crea instancias hijas para todo caso con apoyos
  vigentes de tipos renovables (adecuaciones, acompañante, accesibilidad [S-17]),
  arrastrando lo aprobado. Una persona confirma (quién: DUDAS.md).
- La instancia hija referencia a la madre (historial completo en la ficha).

## Asignación de responsables
- Por etapa: rol responsable + regla de asignación (por sede del estudiante, por carga,
  o manual GDI). La asignación queda en audit y dispara notificación.

## UI de administración (la prueba RF-020)
- GDI crea/edita procesos, etapas, formularios (constructor JSON Schema), SLA,
  escalamientos y plantillas SIN deploy.
- Test de aceptación del sistema completo: un agente-funcionario configura el proceso
  de Exploración NEE/Discapacidad Severa usando SOLO la UI + manual [S-11], y el
  proceso queda operativo (crear caso, transitar, cerrar) sin intervención de código.

## Los TRES procesos seed
1. **Solicitudes de apoyo:** las 7 etapas de contexto-aiep.md con SLA reales
   (Recepción inmediata, Evaluación 5dh, Resolución 5dh, Aplicación 3dh, Evidencia por
   período, Cierre automático), devolución automática por antecedentes, recurrencia
   semestral, requiere_evidencia_para_cierre = true.
2. **Portal de Cuidados:** flujo propio (spec en Tanda 7), mismas garantías.
3. **Exploración NEE/Discapacidad Severa:** NO viene seed — se crea vía UI (test RF-020).

## Criterios de aceptación
- [ ] CA-1: publicar el proceso seed 1 y recorrer un caso completo de Solicitud a
      Cierre con los actores correctos produce la historia esperada y los eventos SLA.
- [ ] CA-2: una definición con etapa inalcanzable o transición inválida es rechazada
      al publicar, con error legible.
- [ ] CA-3: caso en vuelo conserva su versión cuando GDI publica una nueva.
- [ ] CA-4 (regla de oro): con requiere_evidencia_para_cierre, todo intento de cerrar
      caso sin evidencia validada falla — por API, por transición directa y por
      manipulación de eventos; el intento queda en audit.
- [ ] CA-5: la devolución por antecedentes deja el caso en_espera, notifica al
      estudiante y (según config) pausa el reloj [S-16]; al responder, reanuda.
- [ ] CA-6: apertura de semestre crea instancias hijas SOLO de apoyos vigentes
      renovables, con arrastre correcto.
- [ ] CA-7 (negativo): transicionar sin permiso del rol → 403 + audit; guardas no
      satisfechas → rechazo con motivo.
- [ ] CA-8 (accesibilidad): el panel admin y el constructor de formularios son
      operables 100% por teclado, axe 0 violaciones.
- [ ] CA-9 (anulación): estudiante desiste antes de resolución firmada → caso anulado,
      tareas canceladas, relojes detenidos, audit con motivo; el mismo intento CON
      resolución firmada → 403 (solo GDI); un caso anulado rechaza toda transición
      posterior; anular sin motivo → rechazo de validación.

## Propiedades (fuzzing, base de specs/fuzzing-workflow.md)
- P1: un caso tiene exactamente una etapa activa en todo momento.
- P2: toda transición ejecutada existe en la definición del proceso (versión del caso).
- P3: secuencias arbitrarias de eventos jamás llevan a "cerrado" sin evidencia validada
  (cuando el proceso la exige).
- P4: replay de la historia de audit reconstruye el estado actual del caso.
- P5: un caso en estado terminal (cerrado o anulado) no admite ninguna transición
  posterior, ante cualquier secuencia de eventos; anulado nunca tiene relojes SLA
  activos ni tareas pendientes.

## Fuera de alcance
- Cálculo de plazos y escalamientos (specs/sla-engine.md; este motor los invoca).
- Contenido de formularios y checklists reales (catálogos: validacion-documental.md).
- Render de notificaciones (módulo comunicaciones).
