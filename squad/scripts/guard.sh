#!/usr/bin/env bash
set -uo pipefail

# ==============================================================================
# SQUAD GUARDRAIL SCRIPT (PreToolUse Hook)
# ==============================================================================
# FEATURE LIMITS (Enforced Rules):
# 1. Destructive Command Prevention: Blocks the use of 'rm -rf' in Bash to 
#    prevent accidental data loss.
# 2. Environment Protection: Blocks global npm installations ('npm install -g' 
#    or 'npm i -g') to keep the global system environment clean.
# 3. Sensitive Data Protection: Prevents the AI from writing or editing secret 
#    files (e.g., .env, credentials.json) using Write/Edit/MultiEdit tools.
# ==============================================================================

# Skip if jq is not installed (cannot parse JSON from stdin)
command -v jq >/dev/null 2>&1 || exit 0

# Read JSON payload from Claude Code via stdin
in="$(cat)"

# Utility function to extract JSON fields safely
field() { jq -r "$1 // empty" <<<"$in" 2>/dev/null; }

tool="$(field .tool_name)"
cmd="$(field .tool_input.command)"
file_path="$(field .tool_input.file_path)"

# Block function: Prints error to stderr and exits with status code 2 to block
block() { 
  echo "[PRACTICE GUARD] 🚨 $1" >&2
  exit 2
}

# ---------------------------------------------------------
# GUARDRAIL ENFORCEMENT LOGIC
# ---------------------------------------------------------

# FEATURES 1 & 2: Bash Command Restrictions
if [[ "$tool" == "Bash" ]]; then
  
  # Rule 1: Block dangerous deletion commands
  if [[ "$cmd" == *"rm -rf"* ]]; then
    block "Dangerous action detected: Using 'rm -rf' is strictly forbidden."
  fi

  # Rule 2: Block global package installations
  if [[ "$cmd" == *"npm install -g"* || "$cmd" == *"npm i -g"* ]]; then
    block "Environment violation: Only local npm package installations are allowed."
  fi

fi

# FEATURE 3: File Access Restrictions (Write/Edit)
if [[ "$tool" == "Write" || "$tool" == "Edit" || "$tool" == "MultiEdit" ]]; then
  
  # Rule 3: Block AI from touching sensitive configuration files
  if [[ "$file_path" == *".env"* || "$file_path" == *"credentials.json"* ]]; then
    block "Security violation: AI is not authorized to modify secret key files."
  fi

fi

# If all checks pass, allow the tool execution to proceed
exit 0