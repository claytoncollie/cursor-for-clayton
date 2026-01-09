---
name: Execute Plan
description: Works through PRD tasks interactively, tracking progress and blockers
---

# Execute Plan

Reads a PRD or task list and works through tasks one-by-one, tracking progress, blockers, and newly discovered work.

## When to Use

- Working through a PRD created by `/clayton/plan-feature`
- Systematic implementation of complex features
- Tracking progress across multiple work sessions
- Managing blockers and new tasks as they arise

## Process

### Step 1: Gather Context

Ask for:
1. **Feature Name** - kebab-case (e.g., `featured-carousel`)
2. **Planning Doc Path** - Path to PRD or task list with checkboxes
3. **Current Branch** - Git branch name
4. **Latest Diff** - Request: `git status -sb && git diff --stat`

### Step 2: Load the Plan

Parse the planning document:
- Find all checkboxes: `[ ]` (todo), `[x]` (done), `[~]` (in-progress)
- Group tasks by section
- Identify dependencies between tasks
- Calculate completion percentage

Use @file to read the planning document.

### Step 3: Present Task Queue

Show task overview:

```
### Task Queue: [Feature Name]

#### [Section Name] ([estimate])
1. [done] Task description
2. [todo] Task description
3. [todo] Task description

#### [Next Section] ([estimate])
4. [todo] Task description

---
Status: X of Y tasks complete (Z%)
Next up: [Next todo task]
```

### Step 4: Execute Tasks

For each task:

1. **Present the task** with section context and dependencies
2. **Ask "Ready to plan this task?"** - Offer to break into sub-steps, identify files, suggest approach
3. **Provide implementation guidance** - Reference existing patterns, suggest utilities
4. **Ask "What's the status?"** after work:
   - `done` - Mark complete, capture notes
   - `in-progress` - Save progress notes
   - `blocked` - Record blocker and owner
   - `skipped` - Note reason for deferral

Use @codebase to find relevant patterns. Use @Git to track changes.

### Step 5: Update Planning Doc

After each status change, generate update snippet:

```markdown
- [x] Task description
  - Notes: [What was done]
  - Files: [Files changed]
  - Completed: [Date]
```

### Step 6: Check for New Work

After each section, ask: **"Any new tasks discovered?"**

If yes, capture with estimate and priority:
```markdown
- [ ] New task description
  - Discovered: [Context]
  - Estimate: [Hours]
  - Priority: [High/Medium/Low]
```

### Step 7: Session Summary

At end of session, provide:

```markdown
### Session Summary: [Feature Name]

**Progress:** X of Y complete (Z%)

**Completed This Session:**
- [x] Task 1
- [x] Task 2

**In Progress:**
- [ ] Task with next steps noted

**Blocked:**
- [ ] Task - Blocker: [description], Owner: [who]

**Newly Discovered:**
- [ ] New task 1
- [ ] New task 2

**Files Modified:**
- Created: [list]
- Modified: [list]

**Next Session:** [What to tackle next]
```

### Step 8: Next Actions

Remind to:
1. Update planning doc with status changes
2. Commit completed work with descriptive messages
3. Run `/clayton/check-implementation` to validate against design
4. Run `/clayton/write-test` for completed features

## Communication Guidelines

Updates are visible to entire team including clients.

**Do:**
- Use plain English without jargon
- State what was done, not implementation details
- Keep notes brief and focused

**Don't:**
- Include technical implementation details
- Write lengthy explanations
- Over-explain process

## Output Rules

CRITICAL: Follow these rules exactly.

1. When providing task updates or markdown snippets, output ONLY the formatted content
2. Do NOT add introductions ("Here's the update...", "I've prepared...")
3. Do NOT add summaries after the formatted output
4. Let the formatted content speak for itself

Status updates and session summaries must be IMMEDIATELY COPY-PASTEABLE.

---

Next: Run `/clayton/check-implementation` to validate against the plan.
Related: `/clayton/plan-feature`, `/clayton/debug-issue`, `/clayton/review-code`
