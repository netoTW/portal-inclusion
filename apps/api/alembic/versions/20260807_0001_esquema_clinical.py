"""Separación dura de datos clínicos: esquema `clinical` (specs/arquitectura.md).

Los datos clínicos viven SOLO en este esquema y se acceden SOLO vía
packages/authz (clinical_gate). Las tablas las crean las migraciones de los
módulos que las poseen; el scaffold garantiza que el esquema existe desde la
primera migración. Reversible.

Revision ID: 0001
Revises:
Create Date: 2026-08-07
"""

from collections.abc import Sequence

from alembic import op

revision: str = "0001"
down_revision: str | None = None
branch_labels: str | Sequence[str] | None = None
depends_on: str | Sequence[str] | None = None


def upgrade() -> None:
    op.execute("CREATE SCHEMA IF NOT EXISTS clinical")


def downgrade() -> None:
    # RESTRICT a propósito: si algún módulo ya creó tablas clínicas, este
    # downgrade no puede llevárselas por delante silenciosamente.
    op.execute("DROP SCHEMA clinical RESTRICT")
