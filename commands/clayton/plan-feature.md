---
name: Plan Feature
description: Create Product Requirements Documents (PRD) for feature planning
---

# Plan Feature

Creates PRDs for complex features. Source of truth for `/clayton/execute-plan`.

## When to Use

- Complex features requiring multiple implementation phases
- Large projects with numerous dependencies
- Features needing detailed task breakdown before starting
- Work requiring stakeholder alignment before implementation

For simpler features, work directly from an estimate ticket.

## Process

### Step 1: Requirements Gathering

I'll ask you for:

**Problem & Context:**
- What problem are we solving?
- Who experiences this problem?
- What does success look like?

**Scope:**
- Goals (primary objectives)
- Non-goals (explicitly out of scope)
- User stories (As a [user], I want to [action] so that [benefit])
- Success criteria (measurable outcomes)

**Constraints & References:**
- Technical/business constraints
- Estimate ticket reference (if available)

Use @codebase to discover existing patterns and related implementations.

### Step 2: Technical Planning

I'll help you document:

- **High-level approach**: Overall technical strategy
- **Components**: What to create/modify (blocks, templates, patterns, partials)
- **Data models**: Post types, taxonomies, custom fields, relationships
- **Integration points**: Hooks, filters, APIs, third-party services

### Step 3: Task Breakdown

I'll create:

- **Detailed task list** with checkboxes organized by phase (Foundation, Core Features, Testing, Documentation)
- **Dependencies**: Which tasks must happen before others
- **Risks**: Technical unknowns and mitigation strategies
- **Estimate rollup**: Hours per section, total effort

### Step 4: Output

Use @Git to reference recent changes when planning iterations.

## Output Format

```markdown
---
phase: planning
title: [Feature Name]
description: [Brief description]
estimate_ticket: [Link or ID]
created: [Date]
---

# [Feature Name] - Planning Document

## Problem Statement
[Description of problem being solved]

## Goals
- Goal 1
- Goal 2

## Non-Goals
- Non-goal 1

## User Stories
- As a [user], I want to [action] so that [benefit]

## Success Criteria
- Criterion 1
- Criterion 2

## Constraints & Assumptions
- Constraint 1
- Assumption 1

---

## Technical Planning

### High-Level Approach
[Overall strategy]

### Components to Create/Modify
- Component 1
- Component 2

### Data Models
- Post types, taxonomies, custom fields

### Integration Points
- Hooks, APIs, external systems

---

## Task Breakdown

### Foundation
- [ ] Task 1
- [ ] Task 2

### Core Features
- [ ] Task 1
- [ ] Task 2

### Testing & QA
- [ ] Unit tests
- [ ] Integration tests

### Documentation
- [ ] Update README

---

## Dependencies
- Dependency 1

## Risks & Mitigation
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Risk 1 | Medium | High | Strategy 1 |

## Estimate Summary
- Foundation: Xh
- Core Features: Yh
- Testing: Zh
- **Total: [Total]h**
```

## Output Rules

CRITICAL: Follow these output rules exactly.

1. Output ONLY the formatted PRD specified above
2. Do NOT add introductions ("Here's...", "I've prepared...")
3. Do NOT add summaries or wrap-up text after the output
4. Do NOT add meta-commentary about what you produced
5. The formatted output IS your complete response

The output must be IMMEDIATELY COPY-PASTEABLE without removing surrounding text.

---

Next: Run `/clayton/execute-plan` to work through tasks interactively.
