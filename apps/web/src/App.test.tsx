import { cleanup, render, screen } from "@testing-library/react";
import { afterEach, describe, expect, it } from "vitest";
import App from "./App";

// Sin `globals` en vitest, el auto-cleanup de Testing Library no se engancha.
afterEach(cleanup);

describe("App (cascarón del scaffold)", () => {
  it("muestra el encabezado principal del portal", () => {
    render(<App />);
    const encabezado = screen.getByRole("heading", {
      level: 1,
      name: /portal de inclusión y cuidados/i,
    });
    expect(encabezado).toBeDefined();
  });

  it("usa jerarquía de encabezados y regiones semánticas", () => {
    render(<App />);
    expect(screen.getByRole("banner")).toBeDefined();
    expect(screen.getByRole("main")).toBeDefined();
    expect(screen.getByRole("heading", { level: 2 })).toBeDefined();
  });
});
