#!/bin/bash

release/v1.0.0

# Automated Git Workflow Script for All Branches

# Set Commit Message

main
# Automated Git Workflow Script

# Set Variables
BRANCH=$(git branch --show-current)
release/v1.0.0

hotfix/security-patch
main
COMMIT_MSG=${1:-"Automated commit"}

# Fetch Latest Changes
echo "Ñ Fetching latest changes from origin..."
git fetch --all

# Iterate through all branches
for BRANCH in $(git branch --format='%(refname:short)'); do
    echo "Ä Switching to branch: $BRANCH"
    git checkout "$BRANCH"


    # Pull Changes with Automatic Conflict Resolution
    echo "‚¨áÔ∏è Pulling latest changes from $BRANCH with automatic conflict resolution..."
    git pull --strategy-option=theirs origin "$BRANCH"

# Add Changes
echo "‚ûï Adding changes..."
git add .
release/v1.0.0

hotfix/security-patch
main

    # Add Changes
    echo "‚ûï Adding changes..."
    git add .

    # Commit Changes
    echo "‚ú Committing changes with message: '$COMMIT_MSG'"
    git commit -m "$COMMIT_MSG"

    # Push Changes
    echo "Ä Pushing changes to origin/$BRANCH..."
    git push origin "$BRANCH"
done

echo "â Automation Complete for All Branches!"
