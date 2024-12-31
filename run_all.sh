#!/bin/bash

# 🚀 Enhanced Git Automation Script
set -e  # Exit immediately on any error

<<<<<<< Updated upstream
Updated upstream

Updated upstream
# Stash local changes before switching branch

Stashed changes
# Verify required scripts in the current branch
=======
echo "🔧 Starting Enhanced Git Workflow..."

# Required scripts check
>>>>>>> Stashed changes
REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ ! -f "$script" ]]; then
        echo "❌ Error: Missing $script"
        exit 1
    fi
done

echo "✅ All required scripts are present."

# Stash local changes before switching branches
if [[ -n $(git status --porcelain) ]]; then
    echo "📦 Stashing local changes..."
    git stash push -m "Temporary stash for branch switch"
fi

# Run Branch Maintenance
echo "🔄 Running Branch Maintenance..."
./branch_maintenance.sh

# Run Branch Manager
echo "📋 Running Branch Manager..."
./branch_manager.sh

# Run Git Automation Script
echo "🚀 Running Git Automation Script..."
./git_auto.sh "Automated commit after refinements"

# Apply stashed changes if they exist
if git stash list | grep -q "Temporary stash for branch switch"; then
    echo "🔄 Applying stashed changes..."
    git stash pop
<<<<<<< Updated upstream
Updated upstream
Updated upstream

    git add .
    git commit -m "fix: reapply stashed changes after automation"
    git push origin "$(git branch --show-current)"
Stashed changes

    git add .
    git commit -m "fix: reapply stashed changes after automation"
    git push origin "$(git branch --show-current)"
Stashed changes
=======
    echo "✅ Stashed changes reapplied successfully."
>>>>>>> Stashed changes
fi

echo "🎯 All tasks completed successfully!"

<<<<<<< Updated upstream
Updated upstream


Updated upstream

Stashed changes

Stashed changes
=======
>>>>>>> Stashed changes
