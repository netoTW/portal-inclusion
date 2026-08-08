"""Smoke tests del scaffold: la API responde sin exigir servicios externos.

Los tests de conectividad real (Postgres/Redis arriba) corren en CI con
service containers; acá se verifica el contrato de los endpoints.
"""

from app import __version__
from app.main import app
from fastapi.testclient import TestClient

cliente = TestClient(app)


def test_health_responde_ok() -> None:
    r = cliente.get("/health")
    assert r.status_code == 200
    cuerpo = r.json()
    assert cuerpo["estado"] == "ok"
    assert cuerpo["version"] == __version__
    assert cuerpo["entorno"]


def test_health_dependencias_reporta_cada_servicio() -> None:
    """Sin servicios arriba el endpoint NO revienta: reporta 'degradado'."""
    r = cliente.get("/health/dependencias")
    assert r.status_code == 200
    cuerpo = r.json()
    assert cuerpo["estado"] in {"ok", "degradado"}
    for servicio in ("postgres", "redis"):
        assert cuerpo[servicio] == "ok" or cuerpo[servicio].startswith("error:")
    if cuerpo["postgres"] == "ok" and cuerpo["redis"] == "ok":
        assert cuerpo["estado"] == "ok"
    else:
        assert cuerpo["estado"] == "degradado"
