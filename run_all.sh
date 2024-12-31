#!/bin/bash

# 🚀 Unified Git Workflow Script
# Automates branch maintenance, branch management, and git operations

<<<<<<< Updated upstream
set -e  # Exit immediately if a command exits with a non-zero status

# 🛠️ Helper Functions
log() {
    echo -e "\e[34m[INFO] $1\e[0m"
}

warn() {
    echo -e "\e[33m[WARN] $1\e[0m"
}

error() {
    echo -e "\e[31m[ERROR] $1\e[0m"
    exit 1
}
=======
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
>>>>>>> Stashed changes

# 📝 Stash Local Changes Before Starting
if [[ $(git status --porcelain) ]]; then
    log "Local changes detected. Stashing temporarily..."
    git stash push -m "Temporary stash for branch switch"
    STASH_APPLIED=true
else
    STASH_APPLIED=false
fi

# 🔄 Update All Branches
log "Starting Branch Maintenance..."
./branch_maintenance.sh || error "Branch Maintenance failed"

# 📋 List and Validate Branches
log "Running Branch Manager..."
./branch_manager.sh -l || error "Branch Manager failed"

# 🚀 Automate Git Workflow
log "Executing Git Automation Script..."
./git_auto.sh "Automated commit after refinements" || error "Git Automation failed"

# 🔄 Apply Stashed Changes (if any)
if [[ "$STASH_APPLIED" == "true" ]]; then
<<<<<<< Updated upstream
    log "Applying stashed changes..."
    git stash pop || warn "Failed to apply stashed changes. Manual intervention needed."
    
    # Check if there are changes after stash pop
    if [[ $(git status --porcelain) ]]; then
        log "Committing stashed changes..."
        git add .
        git commit -m "fix: reapply stashed changes after automation"
        git push origin $(git branch --show-current)
    fi
=======
    echo "🔄 Applying stashed changes..."
    git stash pop
    git add .
    git commit -m "fix: reapply stashed changes after automation"
    git push origin "$(git branch --show-current)"
>>>>>>> Stashed changes
fi

# ✅ Final Confirmation
log "All scripts executed successfully. Branches are up-to-date!"


