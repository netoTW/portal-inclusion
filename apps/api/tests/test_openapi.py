"""La OpenAPI interactiva (/docs) es criterio de HECHO del scaffold:
debe estar arriba para ejercitar cada endpoint a mano (tareas.md)."""

from app.main import app
from fastapi.testclient import TestClient

cliente = TestClient(app)


def test_docs_interactiva_disponible() -> None:
    r = cliente.get("/docs")
    assert r.status_code == 200
    assert "swagger" in r.text.lower()


def test_openapi_json_valido_y_en_espanol() -> None:
    r = cliente.get("/openapi.json")
    assert r.status_code == 200
    esquema = r.json()
    assert esquema["info"]["title"] == "Portal de Inclusión y Cuidados"
    # Todo endpoint expuesto queda documentado (ejercitable a mano vía /docs)
    assert "/health" in esquema["paths"]
    assert "/health/dependencias" in esquema["paths"]
