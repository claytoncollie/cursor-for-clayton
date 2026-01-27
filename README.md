# Cursor Configuration Repository

A centralized repository for custom Cursor AI commands and rules that can be symlinked into your global `.cursor` directory.

## What's Included

### Commands

Commands are namespaced under `commands/clayton/` and follow a structured engineering workflow:

**Workflow Commands:**
- **estimate-ticket** - Create engineering tickets for Teamwork (analyzes codebase first)
- **plan-feature** - Create PRD documents for complex features
- **execute-plan** - Work through PRD tasks interactively
- **check-implementation** - Validate code against PRD/estimate
- **debug-issue** - Structured debugging workflow
- **write-test** - Generate tests targeting 100% coverage
- **review-code** - Pre-push code review
- **handoff-qa** - Generate QA documentation for Teamwork

**Utilities:**
- **init-wordpress** - Initialize WordPress project with docs, rules, and AGENTS.md
- **document-file** - Generate PHP DocBlocks for individual files

### Rules

Global development guidelines in `rules/cursor-global-rules.md` covering development approach, code quality standards, and best practices.

## Setup

### 1. Clone the Repository

```bash
git clone git@github.com:claytoncollie/cursor-for-clayton.git ~/www/cursor-for-clayton
```

### 2. Symlink Commands

```bash
ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands
```

### 3. Setup Rules

Copy the contents of `rules/cursor-global-rules.md` into Cursor Settings → General → Rules for AI.

### 4. Restart Cursor

Restart the editor to load the new commands.

## Workflow Order

```
1. /estimate-ticket     → Create engineering ticket
2. /plan-feature        → Create detailed PRD (optional)
3. /execute-plan        → Implement tasks from PRD
4. /check-implementation → Validate code against design
5. /write-test          → Generate tests for coverage
6. /review-code         → Pre-push code review
7. /handoff-qa          → Generate QA documentation
8. /debug-issue         → Use anytime issues arise
```

## WordPress Focus

All commands are designed with WordPress theme development awareness:
- PHPCS/WPCS coding standards
- Theme structure (blocks, patterns, templates, partials)
- Custom post types, taxonomies, custom fields
- PHPUnit and wp-browser testing

## Updating

Changes to commands are immediately available via the symlink. After pulling updates, manually copy updated rules into Cursor Settings.

```bash
cd ~/www/cursor-for-clayton && git pull origin trunk
```

## Troubleshooting

If the commands symlink already exists, remove and recreate it:

```bash
rm -rf ~/.cursor/commands
ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands
```
