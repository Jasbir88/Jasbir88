#!/bin/bash

# Automated Git Workflow Script

# Set Variables
BRANCH=$(git branch --show-current)
COMMIT_MSG=${1:-"Automated commit"}

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

