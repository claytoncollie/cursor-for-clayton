# Claude Code Configuration Repository

A centralized repository for Claude Code global rules, settings, and custom commands. Supports multiple Claude Code profiles on the same machine via symlinks — edit once, apply everywhere.

## What's Included

### Global Rules

`rules/claude-global-rules.md` — Expert software engineering partner persona and development guidelines. Symlinked as `CLAUDE.md` into each profile so it applies to all projects.

### Global Settings

`settings.json` — Claude Code permissions (allow/deny lists for tools, file access, and bash commands). Symlinked into each profile.

### Commands

Commands are namespaced under `commands/clayton/` and cover Teamwork-specific workflows that Claude Code doesn't handle natively:

- **estimate-ticket** - Create engineering tickets for Teamwork (analyzes codebase first)
- **execute-plan** - Work through PRD tasks interactively with progress tracking
- **handoff-qa** - Generate QA documentation for Teamwork
- **init-wordpress** - Initialize WordPress project with docs, rules, and CLAUDE.md

Commands that Claude Code handles natively (planning, debugging, testing, code review, documentation) have been removed in favor of built-in capabilities.

### Setup Script

`setup.sh` — One-command installer that symlinks everything into all profiles.

## Profiles

Two Claude Code profiles are supported on the same machine:

| Profile | Directory | Purpose |
|---------|-----------|---------|
| Personal | `~/.claude/` | Personal projects |
| Work | `~/.claude-work/` | Work projects |

Both profiles receive identical rules, settings, and commands. Edit the files in this repo and both profiles update instantly.

## Setup

### 1. Clone the Repository

```bash
git clone git@github.com:claytoncollie/cursor-for-clayton.git ~/www/cursor-for-clayton
```

### 2. Run the Setup Script

```bash
cd ~/www/cursor-for-clayton && bash setup.sh
```

This creates symlinks in one shot:

```
~/.claude/CLAUDE.md          → rules/claude-global-rules.md
~/.claude/settings.json      → settings.json
~/.claude/commands/clayton/  → commands/clayton/
~/.claude-work/CLAUDE.md          → rules/claude-global-rules.md
~/.claude-work/settings.json      → settings.json
~/.claude-work/commands/clayton/  → commands/clayton/
~/.cursor/commands                → commands/
```

The script is safe to run multiple times — it removes stale symlinks before creating new ones.

### Manual Setup (Alternative)

If you prefer to set up manually:

```bash
# Personal profile
ln -sf ~/www/cursor-for-clayton/rules/claude-global-rules.md ~/.claude/CLAUDE.md
ln -sf ~/www/cursor-for-clayton/settings.json ~/.claude/settings.json
mkdir -p ~/.claude/commands
ln -sf ~/www/cursor-for-clayton/commands/clayton ~/.claude/commands/clayton

# Work profile
mkdir -p ~/.claude-work/commands
ln -sf ~/www/cursor-for-clayton/rules/claude-global-rules.md ~/.claude-work/CLAUDE.md
ln -sf ~/www/cursor-for-clayton/settings.json ~/.claude-work/settings.json
ln -sf ~/www/cursor-for-clayton/commands/clayton ~/.claude-work/commands/clayton

# Cursor IDE (optional)
ln -sf ~/www/cursor-for-clayton/commands ~/.cursor/commands
```

## Workflow

```
1. /estimate-ticket  → Create engineering ticket for Teamwork
2. /execute-plan     → Work through tasks with progress tracking
3. /handoff-qa       → Generate QA documentation for Teamwork
```

`/init-wordpress` is a one-time setup command for new WordPress projects.

## WordPress Focus

All commands are designed with WordPress theme development awareness:
- PHPCS/WPCS coding standards
- Theme structure (blocks, patterns, templates, partials)
- Custom post types, taxonomies, custom fields
- PHPUnit and wp-browser testing

## Updating

Changes are immediately available via symlinks. Pull updates and both profiles get them automatically.

```bash
cd ~/www/cursor-for-clayton && git pull origin trunk
```

To add the symlinks on a new machine, just clone and run `setup.sh` again.

## Troubleshooting

If symlinks are broken or stale, re-run the setup script:

```bash
cd ~/www/cursor-for-clayton && bash setup.sh
```

This is safe to run repeatedly — it cleans up old symlinks before creating new ones.
