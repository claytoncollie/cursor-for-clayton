# CLAUDE.md

Claude Code configuration repository with slash commands, global rules, and settings for multiple profiles.

## Profiles

This repo supports two Claude Code profiles on the same machine:

| Profile | Directory | Purpose |
|---------|-----------|---------|
| Personal | `~/.claude/` | Personal projects |
| Work | `~/.claude-work/` | Work projects |

Both profiles share identical rules, settings, and commands via symlinks.

## Setup

```bash
git clone git@github.com:claytoncollie/cursor-for-clayton.git ~/www/cursor-for-clayton
cd ~/www/cursor-for-clayton && bash setup.sh
```

See [README.md](README.md) for detailed setup, manual symlink instructions, and troubleshooting.
