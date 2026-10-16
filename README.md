**File: `my-mini-squad/README.md**`

```markdown
# my-mini-squad 🚀

A minimal, human-centric Agile Squad plugin for Claude Code. This plugin introduces a streamlined multi-agent workflow for rapid bug fixing, complete with human approval gates and safety guardrails.

## ✨ Features

- **Multi-Agent Workflow**: Separates the reasoning of the Product Manager (PM) from the execution of the Developer (`squad:developer`).
- **Rapid Bug Fixing**: Use a single slash command (`/squad:fix`) to delegate tasks, investigate code, and prepare fixes.
- **Human-in-the-Loop (Gate 2)**: The AI orchestrator will never automatically merge code without explicitly prompting for your approval first.
- **Guard Hooks**: Built-in bash scripts intercept and block restricted actions, such as pushing directly to the `main` or `master` branches, enforcing a strict PR-based workflow.

## 📦 Installation

This plugin can be installed directly from GitHub into your Claude Code environment.

1. **Add the repository to your Marketplace:**
   ```text
   /plugin marketplace add <your-github-username>/my-mini-squad

```

2. **Install the plugin:**
```text
/plugin install squad@my-mini-squad

```



## 🚀 Usage

Once installed, you can trigger the automated fix workflow from the Claude Code prompt.

**Basic Usage:**

```text
/squad:fix "Describe the bug you want to fix here"

```

**Example:**

```text
/squad:fix "Create a test.js file with a broken sum(a,b) function, then fix it."

```

**Testing the Guard Hook:**
To test the built-in security guardrails, ask Claude Code to push code directly to the main branch:

> *"Please commit these changes and git push origin main."*

The system will intercept the command, execute the `guard.sh` script, block the action, and return a warning instructing the agent to create a feature branch instead.

## 📂 Project Structure

```text
my-mini-squad/
├── .claude-plugin/
│   └── marketplace.json        # Marketplace registration
├── README.md                   # This file
└── squad/
    ├── .claude-plugin/
    │   └── plugin.json         # Plugin manifest (skills, agents, hooks)
    ├── skills/
    │   └── fix.md              # Orchestration logic for /squad:fix
    ├── agents/
    │   └── developer.md        # Prompts and roles for the Developer Subagent
    ├── hooks/
    │   └── hooks.json          # Event declarations for guardrails
    └── scripts/
        └── guard.sh            # Bash script to block direct pushes to main

```

## 🛠️ Local Development

If you want to clone this repository and modify the plugin locally without publishing, run Claude Code with the following flag:

```bash
claude --plugin-dir /absolute/path/to/my-mini-squad/squad

```
