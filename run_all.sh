#!/bin/bash

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
