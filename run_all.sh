#!/bin/bash

HEAD
# 🚀 Unified Git Workflow Script
# Automates branch maintenance, branch management, and git operations

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
    log "Applying stashed changes..."
    git stash pop || warn "Failed to apply stashed changes. Manual intervention needed."

    # Check if there are changes after stash pop
    if [[ $(git status --porcelain) ]]; then
        log "Committing stashed changes..."
        git add .
        git commit -m "fix: reapply stashed changes after automation"
        git push origin $(git branch --show-current)
    fi
fi

# ✅ Final Confirmation
log "All scripts executed successfully. Branches are up-to-date!"

# Enhanced Git Automation Script
set -e  # Exit immediately on any error

# Function to stash local changes
stash_changes() {
    echo "Stashing local changes..."
    git stash push -m "Stashed changes before running scripts"
}

# Function to check for required scripts
check_required_scripts() {
    echo "Starting Enhanced Git Workflow..."
    REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")
    for script in "${REQUIRED_SCRIPTS[@]}"; do
        if [[ ! -f "$script" ]]; then
            echo "Error: Missing $script"
            exit 1
        fi
    done
    echo "All required scripts are present."
}

# Function to set execute permissions for scripts
set_execute_permissions() {
    echo "Setting execute permissions for required scripts..."
    for script in "${REQUIRED_SCRIPTS[@]}"; do
        chmod +x "$script"
    done
}

# Function to verify script integrity using SHA-256
verify_script_integrity() {
    echo "Verifying script integrity..."
    for script in "${REQUIRED_SCRIPTS[@]}"; do
        sha256sum -c "${script}.sha256" || { echo "SHA-256 verification failed for $script"; exit 1; }
    done
    echo "All scripts passed SHA-256 verification."
}

# Function to execute scripts
execute_scripts() {
    echo "Executing branch maintenance script..."
    ./branch_maintenance.sh || { echo "Error executing branch_maintenance.sh"; exit 1; }

    echo "Executing branch manager script..."
    # The --switch flag is used to switch to the appropriate branch
    ./branch_manager.sh main || { echo "Error executing branch_manager.sh"; exit 1; }

    echo "Executing git automation script..."
    ./git_auto.sh || { echo "Error executing git_auto.sh"; exit 1; }

    echo "All scripts executed successfully."
}

# Function to apply stashed changes and handle conflicts
apply_stashed_changes() {
    echo "Applying stashed changes..."
    git stash pop || {
        echo "Merge conflict detected. Please resolve the conflict manually."
        exit 1
    }
    git add .
    git commit -m "fix: reapplied stashed changes after automation"
    git push origin "$(git branch --show-current)"
    echo "Enhanced Git Workflow completed successfully."
}

# Main script execution
stash_changes
check_required_scripts
set_execute_permissions
verify_script_integrity
execute_scripts
apply_stashed_changes
origin/main
