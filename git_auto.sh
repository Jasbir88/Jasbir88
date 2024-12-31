#!/bin/bash

# 🚀 Automated Git Workflow Script

set -e  # Exit on errors

# Help Menu
if [[ "$1" == "--help" ]]; then
    echo "Usage: ./git_auto.sh [commit_message]"
    echo "Example: ./git_auto.sh 'Add login functionality'"
    exit 0
fi

# Set Variables
BRANCH=$(git branch --show-current)
COMMIT_MSG=${1:-"Automated commit"}

# Validate Branch
if [[ -z "$BRANCH" ]]; then
    echo "❌ Error: Could not determine the current branch. Please check your repository status."
    exit 1
fi

# Fetch Latest Changes
echo "🔄 Fetching latest changes from origin..."
git fetch origin

# Pull Changes
echo "⬇️ Pulling latest changes from $BRANCH..."
git pull origin "$BRANCH"

# Add Changes
echo "➕ Adding changes..."
git add .

# Commit Changes
echo "✅ Committing changes with message: '$COMMIT_MSG'"
git commit -m "$COMMIT_MSG"

# Push Changes
echo "🚀 Pushing changes to origin/$BRANCH..."
git push origin "$BRANCH"

echo "🎉 Automation Complete!"

