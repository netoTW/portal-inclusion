"""Aplicación FastAPI del portal.

Expone /docs (OpenAPI interactiva) para ejercitar cada endpoint a mano.
Los routers de los módulos funcionales (/packages) se irán montando aquí.
"""

from typing import Literal

from fastapi import FastAPI
from pydantic import BaseModel
from redis import Redis
from sqlalchemy import text

from app import __version__
from app.config import get_settings
from app.db import get_engine

app = FastAPI(
    title="Portal de Inclusión y Cuidados",
    description=(
        "Gestión de casos de inclusión y cuidados para educación superior. "
        "API de orquestación: la lógica de negocio vive en /packages."
    ),
    version=__version__,
)


class Salud(BaseModel):
    estado: Literal["ok"]
    version: str
    entorno: str


class SaludDependencias(BaseModel):
    """Estado de cada servicio de infraestructura; 'degradado' si alguno falla."""

    estado: Literal["ok", "degradado"]
    postgres: str
    redis: str


@app.get("/health", response_model=Salud, tags=["salud"], summary="Liveness de la API")
def health() -> Salud:
    """Responde siempre que el proceso esté vivo; no toca servicios externos."""
    return Salud(estado="ok", version=__version__, entorno=get_settings().app_env)


def _chequear_postgres() -> str:
    try:
        with get_engine().connect() as conn:
            conn.execute(text("SELECT 1"))
        return "ok"
    except Exception as exc:
        return f"error: {type(exc).__name__}"


def _chequear_redis() -> str:
    try:
        cliente: Redis = Redis.from_url(
            get_settings().redis_url,
            socket_connect_timeout=2,
            socket_timeout=2,
        )
        try:
            cliente.ping()
        finally:
            cliente.close()
        return "ok"
    except Exception as exc:
        return f"error: {type(exc).__name__}"


@app.get(
    "/health/dependencias",
    response_model=SaludDependencias,
    tags=["salud"],
    summary="Readiness: conectividad a Postgres y Redis",
)
def health_dependencias() -> SaludDependencias:
    postgres = _chequear_postgres()
    redis = _chequear_redis()
    estado: Literal["ok", "degradado"] = (
        "ok" if postgres == "ok" and redis == "ok" else "degradado"
    )
    return SaludDependencias(estado=estado, postgres=postgres, redis=redis)
