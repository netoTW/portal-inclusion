# RF-061 — Configuración del ciclo de evidencias

**Módulo:** evidencias
**Prioridad:** alta
**Depende de:** RF-019 (patrón de panel), y parametriza RF-043..058
**Inferencia:** consecuencia directa del principio del sistema (procesos/parámetros =
DATOS, cap. 7 RF-020) aplicado al ciclo de evidencias: todos los valores que las
specs de este bloque marcan "config" viven aquí. El PDF no lo lista como ítem — es el
RF que hace configurables a los demás. Reconciliar código con doc extendido.

## Descripción
El panel donde GDI parametriza el ciclo completo sin código: umbrales de
recordatorios (D-15/D-7/D-1 y ajustables), cadena de escalamiento del período,
umbrales del semáforo, catálogo apoyo→tipo-de-evidencia (RF-045/048), criterios de
rondas de muestreo, y contactos de Dirección por sede. Cambiar la operación del ciclo
es trabajo funcional de GDI, no un ticket.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | nada (opera con la config vigente; la VE donde aplica — ej. fechas, umbrales) |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | consulta de la config vigente |
| Equipo nacional GDI | todo el panel (editar, versionar, publicar) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: configuración del ciclo, VERSIONADA (mismo patrón que RF-019: borrador →
  validar → publicar, con diff auditado). Secciones: umbrales D-X · cadena de
  escalamiento (peldaño final GDI no editable, RF-055) · umbrales semáforo · catálogo
  apoyo→**MODO de evidencia** + parámetros por modo (evento: confirmaciones exigidas,
  reloj de gracia post-evaluación; atestación: responsable y campos; documental: tipo
  esperado, ventana de fechas, formatos — ADR-004) · **umbral de arrastre para
  instancia institucional** (seed: 2 períodos, RF-054) · parámetros de muestreo
  {tamaño mínimo por período, % dirigido a fechas declaradas — solo modo documental} ·
  contactos Dirección de Sede [S-08].
- ¿Datos clínicos? NO.

## Flujo principal
1. GDI edita en borrador; la validación exige coherencia (umbrales ordenados, cadena
   con peldaño final GDI, catálogo sin apoyos huérfanos si hay tipos activos).
2. Publica: versión nueva con diff auditado.
3. Reglas de aplicación temporal (las mismas de Tanda 3, aquí consolidadas):
   - Períodos ya ABIERTOS conservan sus D-X emitidos; los futuros se recalculan.
   - Evidencias ya validadas NO se re-validan con reglas nuevas (RF-048).
   - Semáforo en vivo se recolorea; congelados jamás (RF-056).

## Flujos alternos / casos borde
- Config inválida (cadena sin GDI, ventana de fechas imposible): no publicable, error
  señalando el campo.
- Catálogo apoyo→evidencia incompleto (tipo de apoyo sin mapeo): publicable CON
  advertencia explícita (los huecos generan ítem genérico + alerta, RF-045) — se
  permite porque el catálogo real llega por levantamiento, pero queda visible.
- Contacto de Dirección inválido/rebotado: RF-055 alerta; el panel lo marca hasta
  corregirse.

## Criterios de aceptación
- [ ] CA-1: cambiar umbrales de semáforo recolorea el panel en vivo, deja los
      históricos intactos y el diff auditado.
- [ ] CA-2: editar el catálogo apoyo→evidencia cambia los checklists de períodos
      FUTUROS; los del período abierto no mutan.
- [ ] CA-3 (negativo): cadena sin peldaño final GDI no publica; ningún rol no-GDI
      accede al panel (403 + audit).
- [ ] CA-4 (accesibilidad): panel completo operable por teclado (mismo estándar que
      RF-019); axe 0.

## Propiedades (fuzzing)
- P1: toda config publicada pasa la validación de coherencia (no existe estado
  vigente inválido — hereda P1 de RF-019).
- P2: los congelados históricos son invariantes ante cualquier secuencia de cambios
  de configuración.

## Fuera de alcance
- La configuración de PROCESOS (RF-019) — esto parametriza el ciclo de evidencias.
- Plantillas de textos de avisos (comunicaciones, RF-063+).

## Dudas abiertas
- Valores institucionales reales de todos estos parámetros (el seed usa los del PDF +
  propuestos) — levantamiento; cada valor ya tiene su duda específica en las specs
  correspondientes.
