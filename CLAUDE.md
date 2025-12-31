# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a Cursor AI configuration repository containing reusable slash commands and global AI rules. It is designed to be symlinked into `~/.cursor/` for global availability across projects.

## Structure

```
commands/           # Slash command definitions (markdown files)
rules/              # Global AI rules
  cursor-global-rules.md  # Development guidelines for Cursor Settings → Rules for AI
```

## Slash Commands

Commands follow a structured engineering workflow:

**Planning Phase:**
1. `/estimate-ticket` - Create engineering tickets for Teamwork (analyzes codebase first)
2. `/plan-feature` - Create PRD documents for complex features
3. `/execute-plan` - Work through PRD tasks interactively

**Implementation Phase:**
4. `/check-implementation` - Validate code against PRD/estimate
5. `/debug-issue` - Structured debugging workflow
6. `/write-test` - Generate tests targeting 100% coverage

**Review Phase:**
7. `/review-code` - Pre-push code review
8. `/handoff-qa` - Generate QA documentation for Teamwork

**Configuration:**
- `/generate-cursor-rules` - Generate project-specific `.cursor/rules/` MDC files
- `/document-file` - Generate PHP DocBlocks for individual files
- `/document-project` - Project-wide documentation generation

## Setup

Commands are symlinked: `ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands`

Rules are manually copied into Cursor Settings → General → Rules for AI.

## WordPress Focus

All workflow commands are designed with WordPress theme development awareness:
- PHPCS/WPCS coding standards
- Theme structure (blocks, patterns, templates, partials)
- Custom post types, taxonomies, custom fields
- Block editor patterns
- PHPUnit and wp-browser testing
