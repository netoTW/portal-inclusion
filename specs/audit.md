# Auditoría — bitácora inmutable

**Package:** `/packages/audit` · **Depende de:** contracts · **Lo consumen:** todos.
Compromiso nº2 del cliente: "toda acción sobre un caso —quién, qué y cuándo— queda
registrada; ningún proceso crítico puede ocurrir fuera de la plataforma". La bitácora
es también la evidencia ante fiscalización (Leyes 20.422/21.091) y acreditación CNA.

## Qué se registra (sin excepciones)
1. **Toda mutación** de datos de negocio: quién (usuario_id, rol, sede), qué (acción,
   tipo y id de recurso, diff antes/después), cuándo (timestamp UTC + zona local),
   desde dónde (IP, user agent), y a qué caso pertenece si aplica.
2. **Toda denegación de authz** con el vector completo del intento (regla de
   specs/authz.md).
3. **Todo cruce del clinical_gate**, incluidos los PERMITIDOS, con propósito declarado.
4. **Eventos de máquina:** transiciones automáticas, vencimientos SLA, escalamientos,
   aperturas/cierres de período, envíos de notificaciones (actor = "plataforma").
5. **Cambios de configuración:** matriz de permisos, definiciones de proceso, catálogos,
   plantillas (el "quién cambió la regla" importa tanto como el "quién tocó el caso").

## Inmutabilidad
- Append-only a nivel de base: el rol de aplicación NO tiene UPDATE/DELETE sobre las
  tablas de audit (privilegios de Postgres, no convención).
- Cada evento lleva hash del evento anterior (cadena por partición): la manipulación
  a posteriori es detectable. Verificador de integridad ejecutable bajo demanda y en CI.
- Corrección de un registro erróneo = evento nuevo de rectificación que referencia al
  original. Jamás edición.

## Los datos clínicos NO viven en el log
El diff de una mutación sobre el esquema `clinical` guarda REFERENCIAS opacas
(campo cambiado sí, contenido no). La bitácora debe poder mostrarse a un auditor o a
una jefatura sin convertirse ella misma en el canal de fuga. La lectura de bitácora
pasa por authz como cualquier recurso (regla 1-4 aplican).

## Lectura y exportación
| Quién | Ve |
|---|---|
| Equipo GDI | bitácora completa, nacional |
| Sede (DAE) | eventos de casos de SU sede |
| Estudiante | línea de tiempo de SU caso, filtrada (sin notas internas ni eventos de gestión interna) |
| Secretaría General | eventos de los procesos que resuelve |
| Jefatura / Docente | eventos de sus tareas y avisos (nunca contenido clínico) |
| Rectoría | nada individual (consume agregados vía reportes) |
- Exportación para auditoría externa (alimenta RF-062): rango de fechas + alcance,
  formato CSV/PDF, y la exportación misma queda registrada (quién exportó qué).

## API interna (contracts)
- `audit.registrar(evento)` — llamada síncrona en la MISMA transacción de la mutación:
  si el registro de audit falla, la mutación NO se confirma (propiedad P1). Nada de
  colas asíncronas para el registro primario.
- `audit.consultar(filtros, actor)` — pasa por authz.

## Criterios de aceptación
- [ ] CA-1: toda mutación vía API produce exactamente su evento correlacionado
      (verificado por barrido: mutación sin evento = test rojo).
- [ ] CA-2: el rol de aplicación no puede UPDATE/DELETE en tablas audit (test contra
      la base real del compose).
- [ ] CA-3: alterar un evento por SQL directo (como superusuario de test) rompe el
      verificador de cadena.
- [ ] CA-4 (negativo): DAE de sede A no lee eventos de sede B; estudiante no ve notas
      internas en su línea de tiempo; docente no ve contenido clínico en ningún evento.
- [ ] CA-5: si audit.registrar falla, la mutación se revierte (transaccionalidad).
- [ ] CA-6: la exportación genera el archivo, respeta el alcance y queda registrada.

## Propiedades (fuzzing)
- P1: no existe mutación confirmada sin evento de audit correlacionado.
- P2: la cadena de hashes verifica de punta a punta tras cualquier secuencia de eventos.
- P3: ningún evento serializado para un actor contiene campos fuera de su allowlist.

## Fuera de alcance
- Política de retención y archivado a largo plazo (pregunta de levantamiento — DUDAS.md).
- Métricas/indicadores derivados de la bitácora (módulo reportes los calcula leyendo).
