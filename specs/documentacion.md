# Documentación de usuario — 7 manuales por perfil

**Vive en:** `/docs/manuales/` · Se genera al final de la construcción, DESDE las
specs y el sistema real (capturas del seed) — nunca manuales teóricos que divergen
del software. Insumo del cap. 12 del RFP (capacitación) y del guion Severa
(rf020-proceso-severa.md: el manual de administración ES parte del sistema bajo
prueba).

## Los manuales (uno por perfil + dos operativos)
| Manual | Audiencia | Contenido eje |
|---|---|---|
| Estudiante | estudiantes (y difusión DAE) | solicitar, borradores, responder antecedentes, mis documentos, renovar |
| Sede (DAE) | equipos DAE | bandeja, tablero de evidencias, cargas, hilos, su semáforo, renovaciones |
| Jefatura de Escuela | jefaturas | sus estudiantes, registrar avisos, tareas |
| Docente | docentes | panel, acusar avisos, confirmar evaluaciones, reprogramar — CORTO (2 páginas: su interacción son 3 clicks) |
| Secretaría General | secretaría | cola de firma, lote, devoluciones, registro de resoluciones |
| Equipo GDI — operación | GDI | evaluación, decisión, períodos, muestreo, gestión directa, reportes |
| **Equipo GDI — administración** | GDI admin | procesos, formularios, plantillas, matriz de avisos, catálogos, matriz de permisos — EL manual de la prueba RF-020 |
Más: guía de instalación/operación técnica (docker, .env, respaldos) para TI.

## Reglas
- En español chileno, con capturas reales del seed (regenerables por script cuando
  la UI cambie — las capturas rotas son deuda visible).
- Cada manual mapea sus secciones a los RF que documenta (trazabilidad manual↔spec:
  si cambia el RF, se sabe qué página revisar).
- Accesibles: los manuales mismos cumplen estándar de documento accesible
  (estructura, alt en capturas).
- El manual de administración GDI se ESCRIBE ANTES de la prueba Severa y se corrige
  con sus hallazgos (rf020-proceso-severa.md: "donde el manual no bastó, hallazgo").

## Criterios de aceptación
- [ ] CA-1: los 7 manuales + guía técnica existen, con capturas del seed vigente y
      mapa de RF por sección.
- [ ] CA-2: la prueba RF-020 se completó usando SOLO el manual de administración
      (sus hallazgos incorporados).
- [ ] CA-3: script de regeneración de capturas corre y detecta capturas obsoletas.

## Dudas
- Formato de entrega para capacitación AIEP (¿PDF, sitio, videos?) — cap. 12 pide
  "plan por perfil"; levantamiento.
