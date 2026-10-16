#!/bin/bash
# Guard hook to block direct pushes to the main branch

echo "[AGILE-SQUAD GUARD] 🚨 AGILE WORKFLOW VIOLATION DETECTED 🚨"
echo "Command intercepted: $1"
echo "Reason: Direct pushes to the main/master branch are strictly prohibited."
echo "Required Action: Please push to a feature branch (e.g., fix/bug-name) and create a Pull Request for the Reviewer."

# Return a non-zero exit code to notify Claude Code that the command failed and must be blocked.
exit 1