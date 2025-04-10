#!/bin/bash

feature/new-feature
# 🚀 Automated Git Workflow Script

set -e  # Exit on errors

# Help Menu
if [[ "$1" == "--help" ]]; then
    echo "Usage: ./git_auto.sh [commit_message]"
    echo "Example: ./git_auto.sh 'Add login functionality'"
    exit 0
fi

# Automated Git Workflow Script for All Branches

# Set Commit Message

# Automated Git Workflow Script
main

# Set Variables
BRANCH=$(git branch --show-current)
hotfix/security-patch
COMMIT_MSG=${1:-"Automated commit"}

# Validate Branch
if [[ -z "$BRANCH" ]]; then
    echo "❌ Error: Could not determine the current branch. Please check your repository status."
    exit 1
fi

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
