#!/bin/bash

# Automated Git Workflow Script for All Branches

# Set Commit Message

# Automated Git Workflow Script

# Set Variables
BRANCH=$(git branch --show-current)
hotfix/security-patch
COMMIT_MSG=${1:-"Automated commit"}

# Fetch Latest Changes
echo "🔄 Fetching latest changes from origin..."
git fetch --all

# Iterate through all branches
for BRANCH in $(git branch --format='%(refname:short)'); do
    echo "🔀 Switching to branch: $BRANCH"
    git checkout "$BRANCH"


    # Pull Changes with Automatic Conflict Resolution
    echo "⬇️ Pulling latest changes from $BRANCH with automatic conflict resolution..."
    git pull --strategy-option=theirs origin "$BRANCH"

# Add Changes
echo "➕ Adding changes..."
git add .
hotfix/security-patch

    # Add Changes
    echo "➕ Adding changes..."
    git add .

    # Commit Changes
    echo "✅ Committing changes with message: '$COMMIT_MSG'"
    git commit -m "$COMMIT_MSG"

    # Push Changes
    echo "🚀 Pushing changes to origin/$BRANCH..."
    git push origin "$BRANCH"
done

echo "🎉 Automation Complete for All Branches!"
