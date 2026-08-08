"""Acceso a base de datos (SQLAlchemy 2, engine sincrónico psycopg3).

El engine se crea perezosamente: importar este módulo no exige tener
Postgres arriba (los tests del scaffold corren sin servicios).
"""

from functools import lru_cache

from sqlalchemy import Engine, create_engine

from app.config import get_settings


@lru_cache
def get_engine() -> Engine:
    return create_engine(
        get_settings().database_url,
        pool_pre_ping=True,
        connect_args={"connect_timeout": 2},
    )
