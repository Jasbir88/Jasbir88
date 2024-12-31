#!/bin/bash

echo " M-' Starting Branch Maintenance..."
./branch_maintenance.sh

echo " ~K Running Branch Manager..."
./branch_manager.sh

echo " ~@ Executing Git Automation Script..."
./git_auto.sh

echo "✅ All scripts executed successfully!"








