#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_tactics_advise info
PYTHONPATH=src python -m gbt_tactics_advise check --payload '{}'
PYTHONPATH=src python -m gbt_tactics_advise run   --payload '{}'
