#!/bin/bash

# 🚀 Enhanced Git Automation Script
set -e  # Exit immediately on any error

# Define required scripts
REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")

# 🛠️ Function to stash local changes (if any)
stash_changes() {
    if [[ -n $(git status --porcelain) ]]; then
        echo "📦 Stashing local changes..."
        git stash push -m "Stashed changes before running scripts"
    else
        echo "✅ No local changes to stash."
    fi
}

# 🛠️ Function to check for required scripts
check_required_scripts() {
    echo "🔍 Verifying presence of essential scripts..."
    for script in "${REQUIRED_SCRIPTS[@]}"; do
        if [[ ! -f "$script" ]]; then
            echo "❌ Error: Missing $script"
            exit 1
        fi
    done
    echo "✅ All required scripts are present."
}

# 🛠️ Function to set execute permissions for scripts
set_execute_permissions() {
    echo "🔑 Setting execute permissions for required scripts..."
    for script in "${REQUIRED_SCRIPTS[@]}"; do
        chmod +x "$script"
    done
    echo "✅ Execute permissions set."
}

# 🛠️ Function to verify script integrity using SHA-256
verify_script_integrity() {
    echo "🔐 Verifying script integrity..."
    for script in "${REQUIRED_SCRIPTS[@]}"; do
        if ! sha256sum -c "${script}.sha256"; then
            echo "❌ SHA-256 verification failed for $script"
            exit 1
        fi
    done
    echo "✅ All scripts passed SHA-256 verification."
}

# 🛠️ Function to execute scripts
execute_scripts() {
    echo "🛠️ Executing branch maintenance script..."
    ./branch_maintenance.sh

    echo "📂 Executing branch manager script..."
    ./branch_manager.sh main  # Replace with actual options

    echo "🚀 Executing git automation script..."
    ./git_auto.sh "Automated commit after script execution"
}

# 🛠️ Function to apply stashed changes and handle conflicts
apply_stashed_changes() {
    if git stash list | grep -q "Stashed changes before running scripts"; then
        echo "🔄 Applying stashed changes..."
        if git stash pop; then
            echo "✅ Stashed changes applied successfully."
        else
            echo "❌ Merge conflict detected during stash pop. Please resolve conflicts manually."
            exit 1
        fi

        git add .
        git commit -m "fix: reapplied stashed changes after automation"
        git push origin "$(git branch --show-current)"
    else
        echo "✅ No stashed changes to apply."
    fi
}

# 🛠️ Main script execution flow
echo "🚀 Starting Enhanced Git Workflow..."
stash_changes
check_required_scripts
set_execute_permissions
verify_script_integrity
execute_scripts
apply_stashed_changes

echo "🎯 Enhanced Git Workflow completed successfully!"
