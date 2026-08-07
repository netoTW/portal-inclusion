# Design system — se define UNA vez, antes de cualquier pantalla

**Vive en:** `/apps/web` (tokens + componentes base) · **Lo consumen:** todas las vistas.
Regla de CLAUDE.md: accesibilidad NO es opcional y español chileno en toda la UI.
Ningún módulo dibuja una pantalla sin usar estos tokens y componentes; ningún agente
inventa un componente que ya existe aquí.

## Tokens

### Tipografía
- Familia: system font stack (sin webfonts en dev; decisión de marca al final, es un token).
- Escala: `text-sm` 14px (tablas densas) · `text-base` 16px (cuerpo, mínimo para formularios)
  · `text-lg` 18px · `text-xl`/`text-2xl` títulos. Line-height ≥1,5 en cuerpo.
- Nunca texto por debajo de 14px; zoom 200% sin pérdida de contenido (criterio WCAG).

### Colores (semánticos, con contraste AA VERIFICADO)
Los valores son punto de partida; la regla dura es el PAR token/fondo con test
automático de contraste en CI (≥4,5:1 texto normal, ≥3:1 texto grande e iconos).
| Token | Valor inicial | Uso |
|---|---|---|
| `primario` | #1D4ED8 | acciones principales, links (sobre blanco) |
| `exito` | #15803D | estados aprobados/al día |
| `alerta` | #92400E (texto) / #FDE68A (fondo) | próximos a vencer, parciales |
| `critico` | #B91C1C | vencidos, incumplimiento, errores |
| `neutro-900/700/500` | #111827 / #374151 / #6B7280 | texto, texto secundario, deshabilitado |
| `fondo` / `superficie` | #FFFFFF / #F9FAFB | página / tarjetas |
- **El color NUNCA es el único portador de significado**: todo semáforo/estado lleva
  icono + texto ("Al día", "Por vencer", "Vencido"). Daltonismo cubierto por diseño.

### Espaciado y layout
- Escala Tailwind estándar (4px base); densidad cómoda por defecto, densa en tablas.
- Grid responsivo: la plataforma es usable en notebook de sede (1366px) y en móvil
  (el estudiante solicita desde el teléfono). Breakpoints Tailwind estándar.

## Componentes base (catálogo único, `/apps/web/src/ui`)
| Componente | Notas de comportamiento |
|---|---|
| Campo de formulario | label SIEMPRE visible (nunca placeholder-como-label), error asociado por `aria-describedby`, requerido marcado en texto |
| Formulario dinámico | renderiza JSON Schema del motor (specs/workflow.md); agrupación por pasos con progreso |
| Tabla de datos | encabezados `th` reales, orden y filtros operables por teclado, paginación, estado vacío con texto útil |
| Bandeja de casos | tabla + filtros por etapa/estado/plazo, fila = caso, acción principal visible; base de TODAS las vistas de gestión |
| Semáforo / badge de estado | icono + texto + color (jamás solo color); tokens de arriba |
| Modal / diálogo | foco atrapado dentro, `Esc` cierra, foco vuelve al disparador, `aria-modal` |
| Notificación en app (toast/banner) | `role="status"`/`alert"` según severidad; no desaparece antes de poder leerse |
| Atestación 1-click | botón de confirmación con resumen de lo que se atesta + undo breve; pensada para docentes/sedes (S-04, contexto UX) |
| Carga de archivos | arrastrar o seleccionar, validación en línea (formato/tamaño desde catálogo), progreso, errores en texto claro |
| Wizard de proceso (admin) | constructor de etapas/formularios del panel GDI, operable por teclado |

## Patrones de accesibilidad (se resuelven UNA vez, aquí)
- **Foco:** visible siempre (outline no se elimina jamás); orden de tabulación = orden
  visual; tras navegar (SPA) el foco va al `h1` de la vista nueva; skip-link al contenido.
- **Teclado:** toda acción disponible por teclado; atajos documentados; nada de
  `div onClick` — elementos nativos (`button`, `a`, `input`) o ARIA completo.
- **Labels y semántica:** HTML semántico (landmarks, headings jerárquicos), todo control
  con nombre accesible, mensajes de error anunciados (`aria-live`).
- **Idioma y formatos:** `lang="es-CL"`; fechas DD-MM-YYYY; RUT con puntos y guión
  (12.345.678-9) validado con DV; números con coma decimal.
- Gate: axe-core 0 violaciones en TODA ruta (CI) + e2e de teclado por flujo crítico.

## Login de desarrollo ("actuar como")
- Con `AUTH_MODE=dev` (y SOLO en dev: el build de producción excluye el módulo),
  `/dev/login` muestra el selector **"Actuar como"** con los usuarios seed de los 7
  perfiles (incluye variantes: DAE de dos sedes distintas, docente con y sin
  estudiantes, jefaturas de dos escuelas).
- Sesión resultante = sesión real (mismo pipeline authz/audit; audit registra el modo dev).
- Banner permanente y visible: "Sesión de desarrollo — actuando como [perfil, nombre]"
  con botón para cambiar de perfil.
- Se reemplaza por SSO real vía IdentityAdapter (specs/sso-m365.md) sin tocar las
  vistas: el selector es una implementación más del adapter.

## Criterios de aceptación
- [ ] CA-1: test automático de contraste pasa para todos los pares token/fondo del catálogo.
- [ ] CA-2: cada componente base tiene story/página de demo y sus tests de teclado
      (foco, Esc, Enter/Space) en vitest.
- [ ] CA-3: axe 0 violaciones sobre la página de demo del catálogo completo.
- [ ] CA-4: `/dev/login` permite entrar como cada uno de los 7 perfiles seed y el
      banner "actuando como" es visible en toda vista; en build de producción la ruta
      no existe.
- [ ] CA-5: toda la UI del catálogo está en español chileno (revisión de textos:
      "Ingresar", "Sede", "Adecuación", DD-MM-YYYY, RUT con DV).

## Fuera de alcance
- Marca visual final (logo, paleta institucional AIEP): se conmuta por tokens cuando
  el cliente la entregue; el contraste AA se re-verifica ahí (test lo fuerza).
- Vistas de módulos (cada módulo las construye CON esto).
