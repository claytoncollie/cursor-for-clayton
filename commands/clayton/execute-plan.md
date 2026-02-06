---
name: Execute Plan
description: Works through PRD tasks interactively, tracking progress and blockers
---

# Execute Plan

Works through PRD tasks, tracking progress and blockers.

<process>

## Step 1: Gather Context

Ask for:
1. **Feature Name** - kebab-case (e.g., `featured-carousel`)
2. **Planning Doc Path** - Path to PRD or task list with checkboxes
3. **Current Branch** - Git branch name
4. **Latest Diff** - Request: `git status -sb && git diff --stat`

## Step 2: Load the Plan

Parse the planning document:
- Find all checkboxes: `[ ]` (todo), `[x]` (done), `[~]` (in-progress)
- Group tasks by section
- Identify dependencies between tasks
- Calculate completion percentage

## Step 3: Present Task Queue

Show task overview using the task queue format below.

## Step 4: Execute Tasks

For each task:
1. **Present the task** with section context and dependencies
2. **Ask "Ready to plan this task?"** - Offer to break into sub-steps, identify files, suggest approach
3. **Provide implementation guidance** - Reference existing patterns, suggest utilities
4. **Ask "What's the status?"** after work:
   - `done` - Mark complete, capture notes
   - `in-progress` - Save progress notes
   - `blocked` - Record blocker and owner
   - `skipped` - Note reason for deferral

## Step 5: Update Planning Doc

After each status change, generate an update snippet using the task update format below.

## Step 6: Check for New Work

After each section, ask: **"Any new tasks discovered?"**

If yes, capture with estimate and priority.

## Step 7: Session Summary

At end of session, provide a session summary using the format below.

## Step 8: Next Actions

Remind to:
1. Update planning doc with status changes
2. Commit completed work with descriptive messages
3. Run `/clayton/handoff-qa` when ready for QA

</process>

<output_formats>

### Task Queue

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

### Task Update

```markdown
- [x] Task description
  - Notes: [What was done]
  - Files: [Files changed]
  - Completed: [Date]
```

### New Task

```markdown
- [ ] New task description
  - Discovered: [Context]
  - Estimate: [Hours]
  - Priority: [High/Medium/Low]
```

### Session Summary

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

</output_formats>

<communication_rules>
Updates are visible to entire team including clients.

**Do:**
- Use plain English without jargon
- State what was done, not implementation details
- Keep notes brief and focused

**Never:**
- Include technical implementation details
- Write lengthy explanations
- Over-explain process
</communication_rules>

<output_rules>
- When providing task updates or markdown snippets, output ONLY the formatted content
- Do NOT add introductions ("Here's the update...", "I've prepared...")
- Do NOT add summaries after the formatted output
- Let the formatted content speak for itself
- Status updates and session summaries must be IMMEDIATELY COPY-PASTEABLE
</output_rules>

---

Next: Run `/clayton/handoff-qa` to generate QA documentation for Teamwork.
