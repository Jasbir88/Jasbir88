#!/bin/bash

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

