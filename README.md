# Cursor Configuration Repository

A centralized repository for custom Cursor AI commands and rules that can be symlinked into your global `.cursor` directory.

## What This Is

This repository contains reusable Cursor AI configurations including:

- **Custom Commands** - Slash commands for documentation generation and code analysis
- **AI Rules** - Development guidelines and coding standards for AI assistance
- **Configuration** - Shared settings for consistent AI behavior across projects

By symlinking this repository into your global `.cursor` directory, you get instant access to all custom commands and rules without duplicating files across multiple projects.

## What's Included

### Commands

#### Documentation Commands
- **document-file** - Intelligently generate PHP DocBlocks for undocumented files and classes
- **document-project** - Project-wide documentation generation

#### Workflow Commands
- **estimate-ticket** - Code-aware ticket writer for Teamwork (analyzes codebase before writing tickets)
- **plan-feature** - PRD creator for feature planning
- **execute-plan** - Task execution assistant that works through PRDs interactively
- **check-implementation** - Validate code against design docs and requirements
- **debug-issue** - Structured debugging workflow
- **review-code** - Pre-push code review assistant
- **write-test** - Test generator targeting 100% coverage
- **handoff-qa** - QA handoff documentation generator

### Rules

Global development guidelines in `rules/cursor-global-rules.md` covering:
- Development approach and methodology
- Code quality standards
- Backend, frontend, database, and DevOps best practices

**To use:** Copy the contents of `cursor-global-rules.md` and paste into Cursor Settings → General → Rules for AI.

## Setup Instructions

### 1. Clone the Repository

Clone this repository to your preferred location:

```bash
git clone git@github.com:claytoncollie/cursor-for-clayton.git
```

### 2. Setup Commands (Symlink)

Create a symlink for the `commands` directory:

```bash
cd ~/.cursor
ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands
```

**Note:** If you cloned the repository to a different location, adjust the path accordingly.

### 3. Setup Rules (Manual Copy)

Copy the rules content into Cursor Settings:

1. Open `rules/cursor-global-rules.md` from this repository
2. Copy the entire contents
3. Open Cursor Settings → General → Rules for AI
4. Paste the contents and save

### 4. Verify Setup

Check that the commands symlink was created successfully:

```bash
ls -la ~/.cursor/commands
```

### 5. Restart Cursor

Restart the Cursor editor to load the new commands.

## Workflow Commands

The workflow commands provide a structured approach to engineering work, from estimation through QA handoff.

### Command Overview

#### 1. `/estimate-ticket` - Code-Aware Ticket Writer

Creates structured engineering tickets for Teamwork by analyzing your codebase first.

**What it does:**
- Analyzes relevant codebase files to understand existing patterns
- Reviews blocks, utilities, partials, post types, taxonomies
- Identifies reusable components vs. new work needed
- Produces structured engineering ticket with:
  - Title (plain English description)
  - Definition (purpose, why needed, problem solved)
  - Engineering Approach (detailed technical plan referencing existing patterns)
  - Acceptance Criteria (testable checkboxes)
  - Estimate (FE/BE hours breakdown)

**Usage:**
```bash
/estimate-ticket
```

**Output:** Formatted ticket ready to paste into Teamwork

---

#### 2. `/plan-feature` - PRD Creator

Creates comprehensive Product Requirements Documents for features needing detailed planning.

**What it does:**
- Gathers context through interactive questions
- Documents: problem statement, goals, user stories, success criteria
- Creates detailed task breakdown with checkboxes
- Identifies dependencies and sequencing
- Can reference estimate ticket if already created

**Usage:**
```bash
/plan-feature
```

**Output:** PRD markdown file (`docs/ai/planning/feature-{name}.md`) that `/execute-plan` can read

---

#### 3. `/execute-plan` - Task Execution Assistant

Reads PRD from `/plan-feature` command and works through tasks interactively one-by-one.

**What it does:**
- Loads planning doc and parses tasks
- Works through each task systematically
- Tracks progress, blockers, newly discovered work
- Updates task status (done/in-progress/blocked)
- Can reference estimate ticket for context

**Usage:**
```bash
/execute-plan
```

**Workflow:** `estimate-ticket` → paste to Teamwork → `plan-feature` → **`execute-plan`**

---

#### 4. `/check-implementation` - Implementation Validator

Compares code against PRD or estimate ticket to ensure implementation matches planned approach.

**What it does:**
- File-by-file validation
- Checks if implementation matches planned approach
- References existing patterns to ensure consistency
- Validates acceptance criteria from estimate

**Usage:**
```bash
/check-implementation
```

---

#### 5. `/debug-issue` - Debugging Assistant

Structured debugging workflow for troubleshooting issues.

**What it does:**
- Clarifies expected vs actual behavior
- Helps isolate root cause
- Surfaces resolution options before coding
- WordPress and theme-aware debugging

**Usage:**
```bash
/debug-issue
```

---

#### 6. `/review-code` - Pre-Push Review

Pre-push code review assistant for catching issues before they reach the team.

**What it does:**
- File-by-file analysis
- Security, performance, logic checks
- References estimate/PRD if available
- Provides actionable recommendations

**Usage:**
```bash
/review-code
```

---

#### 7. `/write-test` - Test Generator

Generates unit and integration tests targeting 100% coverage.

**What it does:**
- Analyzes code to identify test scenarios
- Generates test cases for happy paths, edge cases, errors
- WordPress testing patterns (PHPUnit, wp-browser)
- References estimate acceptance criteria

**Usage:**
```bash
/write-test
```

---

#### 8. `/handoff-qa` - QA Handoff Generator

Prepares comprehensive QA handoff documentation for Teamwork tickets.

**What it does:**
- Verifies acceptance criteria from estimate ticket are met
- Asks for: estimate ticket (or ACs), URLs/entry points, environment
- Validates implementation against each AC
- Generates QA handoff text with:
  - High-level summary of what's being tested
  - Entry points with URLs
  - Concise testing steps per AC
  - Known limitations or caveats

**Usage:**
```bash
/handoff-qa
```

**Output:** Formatted text ready to paste into Teamwork ticket

---

### Example Workflow

Here's how these commands work together:

#### Phase 1: Planning & Estimation
```bash
# 1. Create engineering ticket
/estimate-ticket

# 2. Paste ticket into Teamwork and get approval
# (Manual step in Teamwork)

# 3. Create detailed PRD
/plan-feature
```

#### Phase 2: Implementation
```bash
# 4. Execute tasks from PRD
/execute-plan

# 5. Validate implementation against design
/check-implementation

# 6. Debug any issues found
/debug-issue  # (if needed)
```

#### Phase 3: Testing & Review
```bash
# 7. Generate tests (target 100% coverage)
/write-test

# 8. Pre-push code review
/review-code

# 9. Fix any issues and re-run review-code
```

#### Phase 4: QA Handoff
```bash
# 10. Generate QA handoff documentation
/handoff-qa

# 11. Paste into Teamwork and move to "Ready for QA"
# (Manual step in Teamwork)
```

### WordPress Theme Features

All workflow commands include awareness of:
- WordPress Coding Standards (PHPCS, WPCS)
- Theme structure (blocks, patterns, templates, partials)
- Post types, taxonomies, custom fields
- Block editor patterns
- Reusable utilities and components
- WP hooks, filters, actions
- WP CLI commands
- PHPUnit and wp-browser testing

### Command Integration

Commands are designed to work together:
- **estimate-ticket** provides context for **plan-feature**
- **plan-feature** creates the roadmap for **execute-plan**
- **check-implementation** validates against **plan-feature** and **estimate-ticket**
- **debug-issue** helps resolve issues found during **execute-plan**
- **write-test** creates tests based on **estimate-ticket** acceptance criteria
- **review-code** does final validation before push
- **handoff-qa** uses **estimate-ticket** acceptance criteria for testing docs

## Updating

**Commands:** Changes are immediately available since the symlink points to the repository.

**Rules:** After pulling updates, manually copy the updated `cursor-global-rules.md` content into Cursor Settings → General → Rules for AI.

```bash
cd ~/www/cursor-for-clayton
git pull origin trunk
```

## Troubleshooting

**If commands symlink already exists:**

Remove and recreate the symlink:

```bash
cd ~/.cursor
rm -rf commands
ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands
```
