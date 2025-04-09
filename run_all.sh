#!/bin/bash

# 🚀 Enhanced Git Automation Script
set -e  # Exit immediately on any error

# Define required scripts
REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")

# 🛠️ Function to stash local changes (if any)
stash_changes() {
    echo "📦 Checking for local changes to stash..."
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
        if [[ -f "$script" ]]; then
            chmod +x "$script"
            echo "✅ Permissions set for $script"
        else
            echo "⚠️ Warning: $script not found. Skipping permission change."
        fi
    done
    echo "✅ Execute permissions set for all scripts."
}

# 🛠️ Function to execute scripts
execute_scripts() {
    echo "🛠️ Executing branch maintenance script..."
    if ! ./branch_maintenance.sh; then
        echo "❌ Error: Failed to execute branch_maintenance.sh"
        exit 1
    fi

    echo "📂 Executing branch manager script..."
    if ! ./branch_manager.sh main; then
        echo "❌ Error: Failed to execute branch_manager.sh"
        exit 1
    fi

    echo "🚀 Executing git automation script..."
    if ! ./git_auto.sh "Automated commit after script execution"; then
        echo "❌ Error: Failed to execute git_auto.sh"
        exit 1
    fi
}

# 🛠️ Function to handle branch-specific logic
handle_branch_specific_logic() {
    echo "🔄 Handling branch-specific logic..."
    for branch in $(git branch --list | sed 's/*//'); do
        git checkout "$branch" || { echo "❌ Error: Failed to checkout branch $branch"; exit 1; }
        echo "✅ Checked out branch: $branch"

        # Example: Verify and execute branch-specific scripts
        branch_script="branch_script_for_${branch}.sh"
        if [[ -f "$branch_script" ]]; then
            chmod +x "$branch_script"
            if ! ./"$branch_script"; then
                echo "❌ Error: Failed to execute $branch_script"
                exit 1
            fi
        else
            echo "⚠️ No branch-specific script found for $branch. Skipping."
        fi
    done
    echo "✅ Branch-specific logic completed."
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
# Skipping SHA-256 verification for now
execute_scripts
handle_branch_specific_logic
apply_stashed_changes

echo "🎯 Enhanced Git Workflow completed successfully!"