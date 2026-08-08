"""Punto de entrada de carga de datos seed: `python -m app.seed`.

El contenedor de la API lo ejecuta al arrancar, después de las migraciones,
para que /docs quede arriba con datos cargados. Los datos y su generador son
responsabilidad de la tarea `seed` de la cola (/packages/seed, specs/seed.md):
cuando ese package exista, este entrypoint le delega la carga. Mientras no
exista, es un no-op explícito — no inventamos datos fuera de su spec.
"""

import sys
from pathlib import Path


def _raiz_packages() -> Path | None:
    """Ubica /packages tanto en el checkout del repo como en el contenedor."""
    for candidata in (
        Path(__file__).resolve().parents[3] / "packages",  # repo: apps/api/app -> raíz
        Path("/srv/packages"),  # contenedor (docker-compose monta ./packages ahí)
    ):
        if candidata.is_dir():
            return candidata
    return None


def main() -> int:
    packages = _raiz_packages()
    if packages is None or not (packages / "seed").is_dir():
        print("seed: /packages/seed no existe todavía (tarea 'seed') — sin datos que cargar.")
        return 0
    # La interfaz de carga la define la tarea seed; hasta entonces, avisar.
    print("seed: /packages/seed existe pero la integración de carga la instala la tarea 'seed'.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
