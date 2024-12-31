#!/bin/bash

echo "🔧 Starting Branch Maintenance..."

<<<<<<< Updated upstream
Updated upstream
# Stash local changes before switching branches

=======
>>>>>>> Stashed changes
# Verify required scripts in the current branch
REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")

for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ ! -f "$script" ]]; then
        echo "🛑 Error: Missing $script. Restoring from main branch..."
        git checkout main -- "$script"
        git add "$script"
        git commit -m "chore: restore missing $script"
        git push origin "$(git branch --show-current)"
    fi
done

# Stash local changes
Stashed changes
if [[ $(git status --porcelain) ]]; then
    echo "🛑 Local changes detected. Stashing changes temporarily..."
    git stash push -m "Temporary stash for branch switch"
fi

./branch_maintenance.sh

echo "📋 Running Branch Manager..."
./branch_manager.sh

echo "🚀 Executing Git Automation Script..."
./git_auto.sh "Automated commit after refinements"

# Apply stashed changes after script execution
if git stash list | grep -q "Temporary stash for branch switch"; then
    echo "🔄 Applying stashed changes..."
    git stash pop
<<<<<<< Updated upstream
Updated upstream

    git add .
    git commit -m "fix: reapply stashed changes after automation"
    git push origin "$(git branch --show-current)"
Stashed changes
=======
    git add .
    git commit -m "fix: reapply stashed changes after automation"
    git push origin "$(git branch --show-current)"
>>>>>>> Stashed changes
fi

echo "✅ All scripts executed successfully!"

Updated upstream


<<<<<<< Updated upstream

Stashed changes
=======
>>>>>>> Stashed changes
