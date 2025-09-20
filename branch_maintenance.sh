#!/bin/bash

release/v1.0.0

# Ä Branch Maintenance Script

# Define required scripts
REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")

# Validate essential scripts
echo "ç Validating presence of essential scripts..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ ! -f "$script" ]]; then
        echo "‚ùå Missing script: $script"
        exit 1
    fi
done
echo "‚ú All essential scripts are present."

# Set execute permissions
echo "ë Setting execute permissions for required scripts..."
for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [[ -f "$script" ]]; then
        chmod +x "$script"
        echo "‚ú Permissions set for $script"
    else
        echo "‚ö†Ô∏è Warning: $script not found. Skipping permission change."
    fi
done
echo "‚ú Execute permissions set."

# Run all scripts
echo "Ä Running all scripts..."
if ! ./run_all.sh; then
    echo "‚ùå Error occurred while running run_all.sh"
    exit 1
fi
echo "‚ú All scripts executed successfully."

# Perform branch maintenance tasks
echo "Ñ Performing branch maintenance tasks..."
if ! git fetch --prune; then
    echo "‚ùå Error: Failed to fetch and prune branches."
    exit 1
fi
echo "‚ú Branch maintenance completed successfully."

main
# Ä Automated Branch Management Script

# Fetch latest changes and prune stale remote branches
echo "Ñ Fetching and pruning remote branches..."
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
    echo "Ä Processing branch: $branch"

    # Check if the branch exists locally
    if git show-ref --verify --quiet refs/heads/"$branch"; then
        echo "‚ú Branch '$branch' exists locally. Switching to it..."
        git checkout "$branch"

        # Check if it exists remotely
        if git ls-remote --heads origin "$branch" | grep "$branch"; then
            echo "‚¨áÔ∏è Pulling updates for '$branch'..."
            git pull origin "$branch"
        else
            echo "‚ö†Ô∏è Branch '$branch' does not exist remotely. Pushing it now..."
            git push -u origin "$branch"
        fi
    else
        echo "‚ùå Branch '$branch' does not exist locally. Skipping..."
    fi
done

# Switch back to main
git checkout main
echo "â All branches are up-to-date!"

release/v1.0.0

hotfix/security-patch
main
