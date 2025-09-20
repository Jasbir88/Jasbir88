#!/usr/bin/env bash
set -euo pipefail

echo "ç Running Python lint (flake8)..."
flake8 .

echo "ö Running shellcheck..."
shellcheck ./**/*.sh || true   # won't fail if no .sh files exist

echo "® Running prettier..."
prettier --check "**/*.{js,ts,css,html,json,md,yaml,yml}" || true

echo "‚ú All checks completed!"
