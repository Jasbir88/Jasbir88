#!/bin/bash

# Switch to develop
git checkout develop
git pull origin develop

# Merge all branches into develop
for branch in $(git branch -r | grep -E 'origin/feature/|origin/bugfix/|origin/hotfix/|origin/experiment/|origin/release/'); do
    local_branch=$(echo $branch | sed 's|origin/||')
    echo "🔄 Merging $local_branch into develop..."
    git checkout develop
    git merge --no-ff $local_branch -m "Merge $local_branch into develop"
done

# Push final develop branch
git checkout develop
git push origin develop

