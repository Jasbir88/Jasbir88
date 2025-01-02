#!/bin/bash

# Enhanced Git Automation Script
set -e  # Exit immediately on any error

# Stash local changes before switching branch
echo "Stashing local changes..."
git stash push -m "Stashed changes before running scripts"

# Verify required scripts in the current branch
echo "Starting Enhanced Git Workflow..."

# Required scripts check
REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ ! -f "$script" ]]; then
        echo "Error: Missing $script"
        exit 1
    fi
done

echo "All required scripts are present."

# Set execute permissions for required scripts
echo "Setting execute permissions for required scripts..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    chmod +x "$script"
done

# Execute the required scripts
echo "Executing branch maintenance script..."
./branch_maintenance.sh

echo "Executing branch manager script..."
./branch_manager.sh --switch

echo "Executing git automation script..."
./git_auto.sh

echo "All scripts executed successfully."

# Apply stashed changes
echo "Applying stashed changes..."
git stash pop

echo "Enhanced Git Workflow completed successfully."
