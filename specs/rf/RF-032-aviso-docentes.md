# RF-032 — Aviso automático a docentes y áreas

**Módulo:** adecuaciones
**Prioridad:** crítica
**Depende de:** RF-029/031, comunicaciones (plantillas), evidencia-eventos (panel docente)
**Inferencia:** del bloque Adecuaciones (cap. 7: "aviso automático a docentes") y
módulo 4 ("aviso automático a docentes y áreas"). Meta cap. 11: constancia de aviso
al docente 100% (hoy 6,7%). Qué "áreas" además de docentes: duda de Tanda 0 (O11).

## Descripción
Cada docente con un estudiante con adecuaciones vigentes en su sección recibe el
aviso automático: qué adecuaciones aplicar, recomendaciones de aplicación, desde
cuándo — con acuse de lectura en 1 click. El aviso deja CONSTANCIA (quién, cuándo,
qué versión de adecuaciones) y su acuse alimenta la meta del 100%. La jefatura ya no
"avisa por pasillo": registra y la plataforma ejecuta.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver que sus docentes fueron notificados (transparencia: "tus profesores ya conocen tus apoyos") |
| Sede (DAE) | ver constancias de aviso de sus casos |
| Jefatura de Escuela | registrar/disparar el aviso a sus docentes; ver acuses pendientes |
| Docente | recibir el aviso; acusar lectura 1-click; verlo siempre en su panel |
| Secretaría General | consulta |
| Equipo nacional GDI | plantilla del aviso; panorama nacional de acuses |
| Rectoría/Vicerrectorías | % agregado |

## Datos que toca
- Entidades: aviso {docente, estudiante, sección, adecuaciones incluidas (versión),
  emitido, acuse {timestamp}}.
- ¿Datos clínicos? PROHIBIDO: el aviso contiene adecuación + recomendaciones, jamás
  diagnóstico (regla 1; las recomendaciones se redactan sin causa — RF-029/authz).

## Flujo principal
1. Disparadores: cierre de tareas de RF-031, inscripción de ramos del estudiante,
   cambio de docente, renovación (RF-034) — el aviso sale SOLO y se re-emite cuando
   cambia lo vigente.
2. El docente recibe correo con deep link + el aviso vive en su panel
   (evidencia-eventos); acusa lectura en 1 click.
3. Sin acuse en plazo configurable: recordatorio (RF-016) y visibilidad para
   jefatura ("2 docentes sin acusar").
4. Constancia completa en audit → indicador (RF-062).

## Flujos alternos / casos borde
- Docente nuevo a mitad de semestre: aviso automático al asumir la sección
  (RF-031); el acuse del saliente queda histórico.
- Adecuación revocada/vencida: aviso de cese (el docente no sigue aplicando un
  ajuste extinto — también con constancia).
- "Áreas" además de docentes (biblioteca, registro curricular...): destinatarios
  configurables por tipo de adecuación (catálogo GDI); cuáles son: duda O11.

## Criterios de aceptación
- [ ] CA-1: resolución firmada → cada docente de las secciones del estudiante
      recibe su aviso con las adecuaciones correctas; acuse 1-click registrado; el
      indicador de constancia marca 100% en seed.
- [ ] CA-2: cambio de docente re-emite; revocación emite cese con constancia.
- [ ] CA-3 (negativo): corpus de avisos sin ningún término clínico ni causa (test de
      contenido + vector red team); un docente no ve avisos de estudiantes ajenos.
- [ ] CA-4 (accesibilidad): aviso y acuse operables por teclado desde el deep link;
      axe 0.

## Propiedades (fuzzing)
- P1: ∀ (docente, estudiante con adecuación vigente en su sección): existe aviso
  emitido de la versión vigente (cobertura total — es la meta 100% como invariante).

## Fuera de alcance
- El registro del acto por jefatura como tarea (RF-031); el motor de plantillas y
  acuses (comunicaciones RF-063+, que este RF usa).

## Dudas abiertas
- ¿Qué "áreas" además de docentes reciben avisos? (duda O11, Tanda 0 — sigue abierta).
- Plazo tolerable sin acuse antes de escalar a jefatura (seed: 3dh).
