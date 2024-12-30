#!/bin/bash

# 🚀 Automated Branch Management Script

# Help Menu
if [[ "$1" == "--help" ]]; then
    echo "Usage: ./branch_manager.sh [option] [branch_name]"
    echo "Options:"
    echo "  -c, --create      Create a new branch"
    echo "  -s, --switch      Switch to an existing branch"
    echo "  -m, --merge       Merge current branch into main"
    echo "  -d, --delete      Delete a branch"
    echo "  -l, --list        List all branches"
    echo "  -h, --help        Show this help message"
    exit 0
fi

case $1 in
    -c|--create)
        if [ -z "$2" ]; then
            echo "❌ Please provide a branch name to create."
            exit 1
        fi
        git checkout -b "$2"
        git push -u origin "$2"
        echo "✅ Branch '$2' created and pushed."
        ;;
    -s|--switch)
        if [ -z "$2" ]; then
            echo "❌ Please provide a branch name to switch to."
            exit 1
        fi
        git checkout "$2"
        echo "✅ Switched to branch '$2'."
        ;;
    -m|--merge)
        git checkout main
        git pull origin main
        git merge "$2"
        git push origin main
        echo "✅ Merged branch into main."
        ;;
    -d|--delete)
        if [ -z "$2" ]; then
            echo "❌ Please provide a branch name to delete."
            exit 1
        fi
        git branch -d "$2"
        git push origin --delete "$2"
        echo "✅ Branch '$2' deleted."
        ;;
    -l|--list)
        echo "📋 Listing all branches:"
        git branch -a
        ;;
    -h|--help)
        echo "Usage: ./branch_manager.sh [option] [branch_name]"
        ;;
    *)
        echo "❌ Invalid option: $1"
        echo "Use ./branch_manager.sh --help for available commands."
        exit 1
        ;;
esac

