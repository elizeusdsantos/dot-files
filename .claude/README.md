# Claude Code Configuration

This directory contains configuration files for [Claude Code](https://claude.com/claude-code), Anthropic's CLI tool for development.

## Files

### `settings.local.json`
User-specific Claude Code settings and permissions. This file is gitignored to allow personal customization without affecting others.

**Default permissions:**
- `Bash(tree:*)` - View directory structures
- `Bash(git log:*)` - View git history
- `Bash(git config:*)` - View git configuration
- `Bash(chmod:*)` - Modify file permissions

To customize, edit this file and add/remove permissions as needed.

### `project_context.md`
Project documentation for Claude to understand the codebase structure, design decisions, and development workflow. This helps Claude provide more accurate assistance.

## Setup

Claude Code automatically reads configuration from this directory. No manual setup required.

## Customization

You can customize Claude's behavior for this project by:

1. **Modifying permissions** in `settings.local.json`
2. **Adding custom slash commands** in `.claude/commands/`
3. **Adding project-specific context** in `project_context.md`

## Learn More

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [GitHub Repository](https://github.com/anthropics/claude-code)
