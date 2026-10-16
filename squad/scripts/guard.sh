#!/bin/bash
# Guard hook to prevent direct pushes to the main branch or unwanted shell executions

echo "[AGILE-SQUAD GUARD] 🚨 POLICY VIOLATION DETECTED 🚨" >&2
echo "Command intercepted: $1" >&2
echo "Required Action: Direct pushes to the main branch are not allowed. Please create a feature branch and submit a Pull Request." >&2

# Return a non-zero exit code to notify Claude Code that the command must be blocked
exit 1