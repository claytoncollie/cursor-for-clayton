# AGENTS.md

Cursor AI configuration repository with slash commands and global rules.

## Structure

- `commands/clayton/` - Namespaced slash commands
- `rules/cursor-global-rules.md` - Global AI rules

## Commands (Workflow Order)

1. estimate-ticket - Create Teamwork tickets
2. plan-feature - Create PRDs
3. execute-plan - Work through PRD tasks
4. check-implementation - Validate against PRD
5. debug-issue - Structured debugging
6. write-test - Generate tests (100% coverage)
7. review-code - Pre-push review
8. handoff-qa - QA documentation

**Utilities:** init-wordpress, document-file

## WordPress Focus

Commands are designed for WordPress theme development with PHPCS/WPCS standards.

## Setup

Commands symlink: `~/.cursor/commands` → this repo's `commands/`
Rules: Copy `rules/cursor-global-rules.md` into Cursor Settings → Rules for AI
