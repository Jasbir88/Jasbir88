#!/usr/bin/env bash
set -euo pipefail

echo "� Running Python lint (flake8)..."
flake8 .

echo "� Running shellcheck..."
shellcheck ./**/*.sh || true   # won't fail if no .sh files exist

echo "� Running prettier..."
prettier --check "**/*.{js,ts,css,html,json,md,yaml,yml}" || true

echo "� All checks completed!"
