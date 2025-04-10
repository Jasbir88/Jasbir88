#!/bin/bash

feature/new-feature2

# 🚀 Branch Maintenance Script

# Define required scripts
REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")

# Validate essential scripts
echo "🔍 Validating presence of essential scripts..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ ! -f "$script" ]]; then
        echo "❌ Missing script: $script"
        exit 1
    fi
done
echo "✅ All essential scripts are present."

# Set execute permissions
echo "🔑 Setting execute permissions for required scripts..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ -f "$script" ]]; then
        chmod +x "$script"
        echo "✅ Permissions set for $script"
    else
        echo "⚠️ Warning: $script not found. Skipping permission change."
    fi
done
echo "✅ Execute permissions set."

# Run all scripts
echo "🚀 Running all scripts..."
if ! ./run_all.sh; then
    echo "❌ Error occurred while running run_all.sh"
    exit 1
fi
echo "✅ All scripts executed successfully."

# Perform branch maintenance tasks
echo "🔄 Performing branch maintenance tasks..."
if ! git fetch --prune; then
    echo "❌ Error: Failed to fetch and prune branches."
    exit 1
fi
echo "✅ Branch maintenance completed successfully."

main
# 🚀 Automated Branch Management Script

# Fetch latest changes and prune stale remote branches
echo "🔄 Fetching and pruning remote branches..."
git fetch --prune

# Define an array of branches
branches=(
  "bugfix/fix-authentication-error"
  "experiment/ai-integration"
  "feature/login-page"
  "feature/new-feature2"
  "hotfix/security-patch"
  "jasbir/learning-git"
  "release/v1.0.0"
  "main"
  "master"
)

# Loop through branches
for branch in "${branches[@]}"; do
    echo "🚀 Processing branch: $branch"

    # Check if the branch exists locally
    if git show-ref --verify --quiet refs/heads/"$branch"; then
        echo "✅ Branch '$branch' exists locally. Switching to it..."
        git checkout "$branch"
        
        # Check if it exists remotely
        if git ls-remote --heads origin "$branch" | grep "$branch"; then
            echo "⬇️ Pulling updates for '$branch'..."
            git pull origin "$branch"
        else
            echo "⚠️ Branch '$branch' does not exist remotely. Pushing it now..."
            git push -u origin "$branch"
        fi
    else
        echo "❌ Branch '$branch' does not exist locally. Skipping..."
    fi
done

# Switch back to main
git checkout main
echo "🎉 All branches are up-to-date!"

feature/new-feature2

hotfix/security-patch
main
