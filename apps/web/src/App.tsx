/**
 * Cascarón mínimo del scaffold. La navegación por perfil, el design system
 * (specs/design-system.md) y el login dev "actuar como" llegan con la tarea
 * ui-shell; acá solo se garantiza una SPA operativa, semántica y accesible.
 */
export default function App() {
  return (
    <div className="min-h-screen bg-slate-50 text-slate-900">
      <header className="border-b border-slate-200 bg-white px-6 py-4">
        <h1 className="text-xl font-semibold">Portal de Inclusión y Cuidados</h1>
      </header>
      <main className="mx-auto max-w-3xl px-6 py-10">
        <h2 className="text-lg font-medium">Entorno de desarrollo operativo</h2>
        <p className="mt-3">
          El andamiaje del monorepo está funcionando. La documentación interactiva de la
          API (OpenAPI) queda disponible en la ruta <code>/docs</code> del servicio API
          al levantar el entorno con <code>docker compose up</code>.
        </p>
        <p className="mt-3">
          Las vistas por perfil se construyen módulo a módulo según la cola de{" "}
          <code>tareas.md</code>.
        </p>
      </main>
    </div>
  );
}
