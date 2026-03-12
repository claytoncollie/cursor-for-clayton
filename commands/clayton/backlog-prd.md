---
name: Backlog PRD
description: Skill that writes a detailed engineering PRD for a triaged ticket and posts it as a Teamwork comment
---

# Backlog PRD

Writes a detailed engineering PRD for a ticket tagged `good-first-issue` and posts it as a Teamwork comment. Invoked by a PRD agent spawned from the `/backlog` orchestrator — not meant to be run directly.

## Input

Receives a ticket ID as an argument. Fetch the full ticket from Teamwork via `getTaskById`.

<process>

## 1. Load ticket context

- Read the title, description, tags, and any existing comments
- If the ticket already has a PRD comment (contains "## Engineering Approach"), skip — it's already done

## 2. Analyze codebase

Perform targeted codebase analysis:

- **Identify affected files** — search for related blocks, templates, partials, post types, taxonomies, styles
- **Find existing patterns** — how are similar features implemented? What conventions are used?
- **Map dependencies** — what calls or includes the affected code? What would break?
- **Check for reusable components** — existing blocks, partials, utilities, helpers
- **Note naming conventions** — block names, CSS class prefixes, function prefixes, namespace patterns

## 3. Write PRD

Generate a PRD following this structure:

```markdown
## Definition

[2-3 sentences: what the change does, why it's needed, which areas of the site it affects]

## Engineering Approach

[Technical plan:]
- Files to create or modify (with paths)
- Existing patterns/components to reuse
- Data sources and how to access them
- Conditional display logic
- Editor controls or block attributes (if applicable)
- CSS/layout approach (if applicable)
- JavaScript behaviors (if applicable)

## Acceptance Criteria

- [Specific, testable behavior — one per line]
- [Display conditions and visibility rules]
- [Data correctness verification]
- [Editor/admin behavior]
- [Responsive requirements]
- [Accessibility requirements]

## Estimate

FE: [hours] — [brief scope note]
BE: [hours] — [brief scope note]
```

## 4. Post to Teamwork

- Post the PRD as a comment on the ticket via `createComment`
- Tag the ticket `prd-written` via `updateTask` (append to existing tags)

</process>

<output_rules>
- PRD must reference specific file paths from the codebase
- Acceptance criteria must be testable — no vague statements
- Engineering approach provides direction without dictating exact implementation
- Estimate hours should be realistic for the scope
- The PRD is the comment body — no wrapper text
</output_rules>
