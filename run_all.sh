#!/bin/bash

echo "🔧 Starting Branch Maintenance..."
./branch_maintenance.sh

echo "📋 Running Branch Manager..."
./branch_manager.sh -l

echo "🚀 Executing Git Automation Script..."
./git_auto.sh "Automated commit after refinements"

echo "✅ All scripts executed successfully!"









