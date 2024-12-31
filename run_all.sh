#!/bin/bash

echo "🔧 Starting Branch Maintenance..."

# Verify the script exists in the branch
if [[ ! -f "./run_all.sh" ]]; then
    echo "🛑 Error: run_all.sh is missing in this branch. Exiting..."
    exit 1
fi

# Stash local changes
if [[ $(git status --porcelain) ]]; then
    echo "🛑 Local changes detected. Stashing temporarily..."
    git stash push -m "Temporary stash for branch switch"
    STASH_APPLIED=true
else
    STASH_APPLIED=false
fi

./branch_maintenance.sh
./branch_manager.sh -l
./git_auto.sh "Automated commit after refinements"

# Apply stashed changes
if [[ "$STASH_APPLIED" == "true" ]]; then
    echo "🔄 Applying stashed changes..."
    git stash pop
    git add run_all.sh
    git commit -m "fix: reapply stashed changes after automation"
    git push origin $(git branch --show-current)
fi

echo "✅ All scripts executed successfully!"


