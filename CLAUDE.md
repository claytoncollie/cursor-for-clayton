# CLAUDE.md

Claude Code configuration repository with slash commands, global rules, and settings for multiple profiles.

## Structure

- `commands/clayton/` - Namespaced slash commands
- `rules/claude-global-rules.md` - Global AI rules
- `settings.json` - Global settings (permissions, allow/deny lists)
- `setup.sh` - One-command symlink installer for all profiles

## Profiles

This repo supports two Claude Code profiles on the same machine:

| Profile | Directory | Purpose |
|---------|-----------|---------|
| Personal | `~/.claude/` | Personal projects |
| Work | `~/.claude-work/` | Work projects |

Both profiles share identical rules, settings, and commands via symlinks.

## Commands

1. estimate-ticket - Create Teamwork tickets
2. execute-plan - Work through tasks interactively
3. handoff-qa - QA documentation for Teamwork
4. init-wordpress - Initialize WordPress projects

## WordPress Focus

Commands are designed for WordPress theme development with PHPCS/WPCS standards.

## Setup

```bash
git clone git@github.com:claytoncollie/cursor-for-clayton.git ~/www/cursor-for-clayton
cd ~/www/cursor-for-clayton && bash setup.sh
```

See [README.md](README.md) for detailed setup, manual symlink instructions, and troubleshooting.
