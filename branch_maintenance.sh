#!/bin/bash
name: Validate Essential Scripts in Branches

permissions:
  contents: read
  pull-requests: write

on:
  push:
    branches:
      - '*'
  pull_request:
    branches:
      - '*'

jobs:
  script-check:
    runs-on: ubuntu-latest
    env:
      SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Validate Essential Scripts
        run: |
          echo "🔍 Validating presence of essential scripts..."
          REQUIRED_SCRIPTS=("branch_maintenance.sh" "branch_manager.sh" "git_auto.sh" "run_all.sh")
          MISSING_SCRIPTS=()
          for script in "${REQUIRED_SCRIPTS[@]}"; do
            if [[ ! -f "$script" ]]; then
              MISSING_SCRIPTS+=("$script")
            fi
          done
          if [ ${#MISSING_SCRIPTS[@]} -ne 0 ]; then
            echo "❌ Missing scripts: ${MISSING_SCRIPTS[*]}"
            exit 1
          else
            echo "✅ All essential scripts are present."
          fi

      - name: Verify SHA-256 Checksums
        run: |
          echo "🔐 Verifying script integrity..."
          for script in "${REQUIRED_SCRIPTS[@]}"; do
            if [[ ! -f "$script.sha256" ]]; then
              echo "❌ SHA-256 verification file missing for $script"
              exit 1
            fi
            if ! sha256sum -c "$script.sha256" --status; then
              echo "❌ SHA-256 verification failed for $script"
              exit 1
            fi
          done
          echo "✅ SHA-256 verification passed for all scripts."

      - name: Set Execute Permissions
        run: |
          echo "🔑 Setting execute permissions for required scripts..."
          for script in "${REQUIRED_SCRIPTS[@]}"; do
            chmod +x "$script"
          done
          echo "✅ Execute permissions set."

      - name: Run All Scripts
        run: |
          echo "🚀 Running all scripts..."
          ./run_all.sh || { echo "❌ Error occurred while running scripts."; exit 1; }
          echo "✅ All scripts executed successfully."

      - name: Success Message
        if: success()
        run: echo "✅ Validation completed successfully. All scripts are in place."

      - name: Failure Message
        if: failure()
        run: echo "❌ Validation failed. Some essential scripts are missing or failed integrity checks. Check the logs for details."

      - name: Slack Notification on Success
        if: success()
        uses: slackapi/slack-github-action@b8e5b5f7b3f3d4b5b8e5b5f7b3f3d4b5b8e5b5f7  # Replace with actual commit SHA
        with:
          payload: |
            {
              "text": "✅ CI/CD Workflow succeeded! 🎉"
            }
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}

      - name: Slack Notification on Failure
        if: failure()
        uses: slackapi/slack-github-action@b8e5b5f7b3f3d4b5b8e5b5f7b3f3d4b5b8e5b5f7  # Replace with actual commit SHA
        with:
          payload: |
            {
              "text": "❌ CI/CD Workflow failed! 🚨"
            }
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}