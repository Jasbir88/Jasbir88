#!/bin/bash

echo "[INFO] Starting Branch Maintenance..."

# Stash local changes before switching branches
if [[ $(git status --porcelain) ]]; then
    echo "[INFO] Local changes detected. Stashing temporarily..."
    git stash push -m "Temporary stash for branch switch"
fi

./branch_maintenance.sh

echo "[INFO] Running Branch Manager..."
./branch_manager.sh -l

echo "[INFO] Executing Git Automation Script..."
./git_auto.sh "Automated commit after refinements"

# Apply stashed changes after script execution
if git stash list | grep -q "Temporary stash for branch switch"; then
    echo "[INFO] Applying stashed changes..."
    git stash pop
fi

echo "[INFO] All scripts executed successfully. Branches are up-to-date!"

