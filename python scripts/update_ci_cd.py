import os
import re

# Path to the CI/CD workflow file
WORKFLOW_FILE = ".github/workflows/ci-cd.yml"

# Template for new steps or updates
NEW_STEPS_TEMPLATE = """
      - name: Ensure Scripts Are Executable
        run: |
          find . -type f -name "*.sh" -exec chmod +x {} \\;
          echo "Executable permissions ensured."

      - name: Check for requirements.txt
        run: |
          if [ ! -f "requirements.txt" ]; then
            echo "requirements.txt not found. Exiting."
            exit 1
          fi
"""


def update_workflow():
    if not os.path.exists(WORKFLOW_FILE):
        print(f"Workflow file '{WORKFLOW_FILE}' not found.")
        return

    with open(WORKFLOW_FILE, "r") as file:
        content = file.read()

    # Example: Add new steps if not already present
    if "Ensure Scripts Are Executable" not in content:
        content = re.sub(
            r"(steps:\n)",
            r"\1" + NEW_STEPS_TEMPLATE,
            content,
            count=1
        )
        print("Added new steps to ensure scripts are executable.")

    # Example: Update Python versions in the matrix
    content = re.sub(
        r"python-version: \[.*?\]",
        "python-version: [3.8, 3.9]",
        content
    )
    print("Updated Python versions in the matrix.")

    # Example: Ensure Codecov token usage is consistent
    content = re.sub(
        r"token: \${{ secrets.CODECOV_TOKEN }}",
        "token: ${{ secrets.CODECOV_TOKEN }}",
        content
    )
    print("Ensured consistent Codecov token usage.")

    # Write the updated content back to the file
    with open(WORKFLOW_FILE, "w") as file:
        file.write(content)
    print(f"Workflow file '{WORKFLOW_FILE}' updated successfully.")


if __name__ == "__main__":
    update_workflow()
