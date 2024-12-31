#!/bin/bash

echo "🔧 Starting Branch Maintenance..."

# Stash local changes before switching branches
if [[ $(git status --porcelain) ]]; then
    echo "🛑 Local changes detected. Stashing changes temporarily..."
    git stash push -m "Temporary stash for branch switch"
fi

./branch_maintenance.sh

echo "📋 Running Branch Manager..."
./branch_manager.sh -l

echo "🚀 Executing Git Automation Script..."
./git_auto.sh "Automated commit after refinements"

# Apply stashed changes after script execution
if git stash list | grep -q "Temporary stash for branch switch"; then
    echo "🔄 Applying stashed changes..."
    git stash pop
    git add run_all.sh
    git commit -m "fix: reapply stashed changes for run_all.sh"
    git push origin main
fi

echo "✅ All scripts executed successfully!"

