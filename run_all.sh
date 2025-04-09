#!/bin/bash

# 🚀 Enhanced Git Automation Script with SHA-256 Verification
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

# 🛠️ Function to verify SHA-256 checksum for a script
verify_checksum() {
    local script_name=$1
    local checksum_file="./${script_name}.sha256"

    echo "🔍 Current working directory: $(pwd)"  # Debug statement
    echo "🔍 Looking for checksum file: $checksum_file"  # Debug statement

    if [[ -f "$checksum_file" ]]; then
        sha256sum -c "$checksum_file" --status
        if [[ $? -ne 0 ]]; then
            echo "❌ SHA-256 verification failed for $script_name"
            exit 1
        else
            echo "✅ $script_name: OK"
        fi
    else
        echo "❌ Checksum file $checksum_file not found for $script_name"
        exit 1
    fi
}

# 🛠️ Function to verify all scripts
verify_all_scripts() {
    echo "🔐 Verifying integrity of all required scripts..."
    for script in "${REQUIRED_SCRIPTS[@]}"; do
        verify_checksum "$script"
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

# 🛠️ Function to handle branch-specific logic
handle_branch_specific_logic() {
    echo "🔄 Handling branch-specific logic..."
    for branch in $(git branch --list | sed 's/*//'); do
        git checkout "$branch"
        echo "✅ Checked out branch: $branch"

        # Example: Verify and execute branch-specific scripts
        branch_script="branch_script_for_${branch}.sh"
        if [[ -f "$branch_script" ]]; then
            verify_checksum "$branch_script"
            chmod +x "$branch_script"
            ./"$branch_script"
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
verify_all_scripts
execute_scripts
handle_branch_specific_logic
apply_stashed_changes

echo "🎯 Enhanced Git Workflow completed successfully!"
