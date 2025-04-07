#!/bin/bash

# 🚀 Branch Maintenance Script

# Define required scripts
REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")

# Validate essential scripts
echo "🔍 Validating presence of essential scripts..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ ! -f "$script" ]]; then
        echo "❌ Missing script: $script"
        exit 1
    fi
done
echo "✅ All essential scripts are present."

# Verify SHA-256 checksums
echo "🔐 Verifying script integrity..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ ! -f "$script.sha256" ]]; then
        echo "❌ SHA-256 verification file missing for $script"
        exit 1
    fi
    if ! sha256sum -c "$script.sha256" --status; then
        echo "❌ SHA-256 verification failed for $script"
        exit 1
    fi
done
echo "✅ SHA-256 verification passed for all scripts."

# Set execute permissions
echo "🔑 Setting execute permissions for required scripts..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    chmod +x "$script"
done
echo "✅ Execute permissions set."

# Run all scripts
echo "🚀 Running all scripts..."
./run_all.sh || { echo "❌ Error occurred while running scripts."; exit 1; }
echo "✅ All scripts executed successfully."