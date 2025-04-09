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

# Set execute permissions
echo "🔑 Setting execute permissions for required scripts..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ -f "$script" ]]; then
        chmod +x "$script"
        echo "✅ Permissions set for $script"
    else
        echo "⚠️ Warning: $script not found. Skipping permission change."
    fi
done
echo "✅ Execute permissions set."

# Run all scripts
echo "🚀 Running all scripts..."
if ! ./run_all.sh; then
    echo "❌ Error occurred while running run_all.sh"
    exit 1
fi
echo "✅ All scripts executed successfully."

# Perform branch maintenance tasks
echo "🔄 Performing branch maintenance tasks..."
if ! git fetch --prune; then
    echo "❌ Error: Failed to fetch and prune branches."
    exit 1
fi
echo "✅ Branch maintenance completed successfully."