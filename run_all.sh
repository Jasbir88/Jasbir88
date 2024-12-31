#!/bin/bash

echo " M-' Starting Branch Maintenance..."
./branch_maintenance.sh

echo " ~K Running Branch Manager..."
./branch_manager.sh

echo " ~@ Executing Git Automation Script..."
./git_auto.sh "Automated commit after refinements"

echo "✅ All scripts executed successfully!"








