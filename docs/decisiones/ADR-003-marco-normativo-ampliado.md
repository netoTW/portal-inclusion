# ADR-003 — Marco normativo ampliado por el proveedor

**Fecha:** 07-08-2026
**Estado:** aceptada (supuesto [S-14](../../SUPUESTOS.md) — validar contra el documento extendido)
**Decisores:** Pablo Herrera

## Contexto

El PDF del cliente cita como riesgo normativo las **Leyes 20.422** (igualdad de
oportunidades e inclusión de personas con discapacidad) y **21.091** (educación
superior), en el contexto de fiscalizaciones de la Superintendencia de Educación
Superior y acreditación CNA. El "marco normativo" completo viene en el documento
extendido (37 págs., bajo NDA), que aún no tenemos.

Sin embargo, el alcance funcional del RFP toca dos cuerpos legales que el PDF breve
no menciona y que condicionan el diseño desde el día uno.

## Decisión

Ampliamos deliberadamente el marco normativo de diseño con dos leyes:

1. **Ley 21.790 (cuidados):** el "Portal de Cuidados" (módulo 5, RF-037–042) corresponde
   al marco de reconocimiento de personas cuidadoras. Reutilizamos el motor de gestión
   Ley 21.790 ya construido por Pablo, lo que además acelera el módulo.
2. **Ley 21.719 (protección de datos personales):** entra en vigencia el **01-12-2026 —
   antes del go-live de enero 2027** — y la plataforma trata datos de salud (categoría
   especialmente protegida). Consecuencias de diseño ya incorporadas:
   - separación dura del esquema `clinical` con acceso solo vía policy engine;
   - prohibición de decisión 100% automatizada sobre datos de salud
     (`specs/validacion-documental.md`: el sistema recomienda, GDI decide);
   - consentimiento informado versionado ([S-10](../../SUPUESTOS.md));
   - auditoría de todo acceso y denegación;
   - agregación con k-anonimato ([ADR-002](ADR-002-k-anonimato-dashboards.md)).

Estas leyes son **aporte del proveedor, no exigencia del PDF breve**: se presentan al
cliente como parte del valor de la propuesta, no como requisito que él haya escrito.

## Consecuencias

- (+) La plataforma nace conforme a la 21.719 en lugar de adaptarse después con el
  sistema en producción y datos de salud cargados.
- (+) Coherencia del Portal de Cuidados con su marco legal real y reutilización de un
  activo existente.
- (−) Riesgo de desalineación si el documento extendido define un marco distinto o
  interpreta la 21.719 de otra forma → re-auditar este ADR al recibirlo (mismo
  protocolo que las specs, README-ARRANQUE día 0).
- Los requisitos concretos derivados de cada ley se marcan en las specs de Fase 0 con
  referencia a este ADR, para poder distinguirlos de los requisitos del cliente en la
  matriz RF de la propuesta.
