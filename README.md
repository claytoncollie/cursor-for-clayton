# Claude Code Configuration Repository

A centralized repository for Claude Code global rules, settings, custom commands, agents, and skills. Supports multiple Claude Code profiles on the same machine via symlinks — edit once, apply everywhere.

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
- **commit-push-pr** - Commit, push, and open a PR/MR with CI watch and auto-fix
- **backlog** - Orchestrator for the autonomous backlog pipeline (see below)

### Backlog Pipeline

Autonomous pipeline for bulk backlog processing. Point it at Teamwork task lists and it triages, writes PRDs, executes code, and reviews PRs — designed to run overnight unattended.

```
/backlog "Museum Backlog" "Museum Up Next"
/backlog 1783911 1781987
```

#### Architecture

```
/backlog (command)
  |
  +-- backlog-fetch (skill, forked context)
  |     Resolves list names/IDs, fetches tickets from Teamwork
  |
  +-- backlog-triage (agent, sonnet, cyan)
  |     Classifies each ticket as code-solvable or skip
  |
  +-- backlog-prd (agent, sonnet, green)
  |     Writes engineering PRD, posts as Teamwork comment
  |
  +-- backlog-execute (agent, inherit model, yellow, worktree-isolated)
  |     Branches, implements, lints, tests, opens MR/PR
  |
  +-- backlog-review (agent, sonnet, magenta)
        Reviews MR diff against requirements, auto-fixes or flags
```

Each agent gets its own isolated context window so it can focus deeply on one ticket without polluting the orchestrator's context.

#### State Tag Lifecycle

```
[none] -> good-first-issue -> prd-written -> pr-open -> review-passed
```

Skip/fail tags: `needs-design`, `needs-investigation`, `infrastructure`, `third-party`, `needs-discussion`, `wont-fix`, `needs-human`

Re-running `/backlog` with the same lists resumes where it left off — completed stages are skipped.

#### File Structure

| Type | Path | Purpose |
|------|------|---------|
| Command | `commands/clayton/backlog.md` | Orchestrator entry point |
| Skill | `skills/backlog-fetch/SKILL.md` | Fetch tickets (forked context) |
| Agent | `agents/backlog-triage.md` | Triage classification |
| Agent | `agents/backlog-prd.md` | PRD writing |
| Agent | `agents/backlog-execute.md` | Code implementation |
| Agent | `agents/backlog-review.md` | MR/PR review |

Commands that Claude Code handles natively (planning, debugging, testing, code review, documentation) have been removed in favor of built-in capabilities.

### Setup Script

`setup.sh` — One-command installer that symlinks everything into all profiles.

## Profiles

Two Claude Code profiles are supported on the same machine:

| Profile | Directory | Purpose |
|---------|-----------|---------|
| Personal | `~/.claude/` | Personal projects |
| Work | `~/.claude-work/` | Work projects |

Both profiles receive identical rules, settings, commands, agents, and skills. Edit the files in this repo and both profiles update instantly.

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
~/.claude/CLAUDE.md                → rules/claude-global-rules.md
~/.claude/settings.json            → settings.json
~/.claude/commands/clayton/        → commands/clayton/
~/.claude/agents/*.md              → agents/*.md
~/.claude/skills/backlog-fetch/    → skills/backlog-fetch/
~/.claude-work/CLAUDE.md                → rules/claude-global-rules.md
~/.claude-work/settings.json            → settings.json
~/.claude-work/commands/clayton/        → commands/clayton/
~/.claude-work/agents/*.md              → agents/*.md
~/.claude-work/skills/backlog-fetch/    → skills/backlog-fetch/
~/.cursor/commands                      → commands/
```

The script is safe to run multiple times — it removes stale symlinks before creating new ones.

### Manual Setup (Alternative)

If you prefer to set up manually:

```bash
# Personal profile
ln -sf ~/www/cursor-for-clayton/rules/claude-global-rules.md ~/.claude/CLAUDE.md
ln -sf ~/www/cursor-for-clayton/settings.json ~/.claude/settings.json
mkdir -p ~/.claude/commands ~/.claude/agents ~/.claude/skills
ln -sf ~/www/cursor-for-clayton/commands/clayton ~/.claude/commands/clayton
ln -sf ~/www/cursor-for-clayton/agents/*.md ~/.claude/agents/
ln -sf ~/www/cursor-for-clayton/skills/backlog-fetch ~/.claude/skills/backlog-fetch

# Work profile
mkdir -p ~/.claude-work/commands ~/.claude-work/agents ~/.claude-work/skills
ln -sf ~/www/cursor-for-clayton/rules/claude-global-rules.md ~/.claude-work/CLAUDE.md
ln -sf ~/www/cursor-for-clayton/settings.json ~/.claude-work/settings.json
ln -sf ~/www/cursor-for-clayton/commands/clayton ~/.claude-work/commands/clayton
ln -sf ~/www/cursor-for-clayton/agents/*.md ~/.claude-work/agents/
ln -sf ~/www/cursor-for-clayton/skills/backlog-fetch ~/.claude-work/skills/backlog-fetch

# Cursor IDE (optional)
ln -sf ~/www/cursor-for-clayton/commands ~/.cursor/commands
```

## Workflows

### Manual (interactive)

```
1. /estimate-ticket  → Create engineering ticket for Teamwork
2. /execute-plan     → Work through tasks with progress tracking
3. /commit-push-pr   → Commit, push, and open PR/MR
4. /handoff-qa       → Generate QA documentation for Teamwork
```

### Autonomous (overnight)

```
/backlog "Museum Backlog" "Museum Up Next"
  → FETCH    — resolve list names/IDs, pull open tickets
  → TRIAGE   — classify tickets, tag code-solvable ones
  → PRD      — write engineering approach as Teamwork comment
  → EXECUTE  — branch, code, lint, test, open MR/PR (worktree-isolated)
  → REVIEW   — diff vs requirements, auto-fix or flag needs-human
```

State tags track progress: `good-first-issue` -> `prd-written` -> `pr-open` -> `review-passed`.
Re-running the same command resumes where it left off.

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
