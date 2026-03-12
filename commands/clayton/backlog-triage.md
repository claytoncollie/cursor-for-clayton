---
name: Backlog Triage
description: Evaluate a Teamwork ticket against the codebase and classify it as code-solvable or skip
---

# Backlog Triage

Evaluates a single Teamwork ticket against the codebase to determine if it can be solved with a code change. Used by `/clayton/backlog` during the triage phase.

<process>

## 1. Read the ticket

Extract from the Teamwork ticket:
- Title
- Description / body
- Existing tags
- Assignee (if any)
- Task list name

## 2. Check for early exits

Skip immediately (no codebase analysis needed) if:

- **Already in pipeline**: has tag `good-first-issue`, `prd-written`, `pr-open`, or `review-passed`
- **Already skipped**: has tag `needs-design`, `needs-investigation`, `infrastructure`, `third-party`, `needs-discussion`, `wont-fix`, `for-designer`
- **No description**: title-only tickets with no actionable detail → tag `needs-investigation`
- **Private/admin**: tickets about team processes, meetings, or admin tasks → skip without tagging

## 3. Analyze ticket intent

From the title and description, determine what the ticket is asking for:

- **Visual/CSS change** — layout fix, spacing, typography, responsive behavior
- **PHP/template change** — new field, conditional logic, data display, post type config
- **Block change** — new block, block modification, block option, allowlist change
- **Feature work** — new functionality (calendar export, search filter, etc.)
- **Content/editorial** — content updates, copy changes, editorial workflow
- **Design work** — requires new mockups, UX decisions, visual design
- **Infrastructure** — hosting, CI/CD, deployment, environment config
- **Third-party** — plugin config, external service integration
- **Investigation** — needs research before any code can be written

## 4. Evaluate against codebase

For code-likely tickets, search the codebase to confirm feasibility:

- Can you identify the specific files that would need to change?
- Do similar patterns already exist that can be followed?
- Is the scope contained (not a sprawling refactor)?
- Are there clear acceptance criteria (explicit or inferable)?

A ticket is **code-solvable** if you can answer yes to at least 3 of these.

## 5. Classify and tag

Based on analysis, apply exactly one tag:

### Code-solvable
- **`good-first-issue`** — Can be solved with a code change. Clear scope, identifiable files, existing patterns to follow.

### Skip reasons
- **`needs-design`** — Requires visual design decisions, mockups, or UX work before code. Also use for tickets explicitly labeled "for designer" or similar.
- **`needs-investigation`** — Requires research, discovery, or clarification before any work can begin. Vague tickets with no clear path.
- **`infrastructure`** — Server config, CI/CD, hosting, deployment — not a codebase change.
- **`third-party`** — Depends on external plugin, service, or vendor action.
- **`needs-discussion`** — Requires team alignment, stakeholder decision, or strategy call. Covers editorial strategy, content planning, and process tickets.
- **`wont-fix`** — Explicitly marked as won't fix, duplicate, or obsolete.

## 6. Update Teamwork

- Add the classification tag to the ticket via `updateTask`
- Do NOT remove existing tags — append to them

</process>

<output_format>
Return a single-line classification:

```
{ticket_id} | {title} | {tag} | {one-sentence reason}
```

Example:
```
19623200 | Calendar Export Functionality | good-first-issue | .ics generation with existing event post type data
19736948 | Tech Lead Admin Museum | skip | Private admin task, no code change needed
19748803 | Cover block/Text over image | good-first-issue | Core/cover block allowlisting in theme setup
```
</output_format>

<output_rules>
- Apply exactly one tag per ticket
- Never remove existing tags
- Skip tickets that already have pipeline or skip tags
- One-sentence reason must reference specific codebase evidence for code-solvable tickets
</output_rules>
