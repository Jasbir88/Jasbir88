#!/bin/bash

# 🚀 Automated Git Workflow Script

set -e  # Exit on errors

# Help Menu
if [[ "$1" == "--help" ]]; then
    echo "Usage: ./git_auto.sh [branch_name] [commit_message]"
    echo "Example: ./git_auto.sh feature/login 'Add login functionality'"
    exit 0
fi

# Set Variables
BRANCH=${1:-$(git branch --show-current)}
COMMIT_MSG=${2:-"Automated commit"}

# Fetch Latest Changes
echo "🔄 Fetching latest changes from origin..."
git fetch origin

# Pull Changes
echo "⬇️ Pulling latest changes from $BRANCH..."
git pull origin "$BRANCH"

# Add Changes
echo "➕ Adding changes..."
git add -u

# Commit Changes
echo "✅ Committing changes with message: '$COMMIT_MSG'"
git commit -m "$COMMIT_MSG"

# Push Changes
echo "🚀 Pushing changes to origin/$BRANCH..."
git push origin "$BRANCH"

echo "🎉 Automation Complete!"

