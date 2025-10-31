---
name: Execute Plan
description: Task execution assistant that works through PRD tasks interactively one-by-one
author: Clayton Collie
version: 1.0.0
tags: [execution, implementation, task-management, wordpress, prd, workflow]
---

# Execute Plan - Task Execution Assistant

## Command Purpose

Reads the PRD created by `/plan` (or any task list) and works through tasks interactively one-by-one. Tracks progress, blockers, and newly discovered work while maintaining task status.

## Usage

```bash
/execute-plan
```

The command will guide you through each task in your planning document systematically.

## When to Use This Command

Use `/execute-plan` for:
- **Working through a PRD** created by `/plan`
- **Systematic implementation** of complex features
- **Tracking progress** across multiple work sessions
- **Managing blockers** and newly discovered tasks
- **Maintaining context** from the estimate ticket

## Workflow Integration

**Typical workflow:**
1. Create estimate with `/estimate`
2. Create PRD with `/plan`
3. **Run `/execute-plan`** to implement tasks
4. Use `/writing-test` for test generation
5. Use `/check-implementation` to validate
6. Use `/code-review` before pushing

## How It Works

This command follows a structured 8-step workflow to execute tasks systematically.

## Step 1: Gather Context

I'll ask you for:

1. **Feature Name**: kebab-case name (e.g., `featured-content-carousel`)
2. **Feature/Branch Description**: Brief summary of what you're building
3. **Planning Doc Path**: Path to your planning document
   - Can work with any markdown file containing checkboxes
4. **Supporting Docs**: Links to related docs (optional)
   - Design doc path (if exists)
   - Requirements doc path (if exists)
   - Implementation doc path (if exists)
   - Estimate ticket reference
5. **Current Branch**: Git branch name
6. **Latest Diff Summary**: Request output from:
   ```bash
   git status -sb
   git diff --stat
   ```

## Step 2: Load the Plan

I'll load and parse your planning document:

### Reading the Plan
- Request the planning doc contents
- If file doesn't exist, offer to create from template
- Parse all sections with task lists

### Identifying Tasks
- Look for markdown checkboxes: `[ ]`, `[x]`, `[~]`
- Extract tasks grouped by section (e.g., Foundation, Core Features, Testing)
- Preserve task context (section, description, notes)
- Detect task status from checkbox state:
  - `[ ]` = todo
  - `[x]` = done
  - `[~]` = in-progress (if supported)
  - Inline notes for blocked status

### Building Task Queue
- Create ordered list of all tasks
- Group by logical sections
- Note dependencies from task descriptions
- Identify completed vs. outstanding work

## Step 3: Present Task Queue

I'll show you an overview:

```
### Task Queue: Featured Content Carousel

#### Foundation (2h)
1. [done] Update queried-content block.json with carousel settings
2. [done] Add carousel display mode option to block settings
3. [todo] Create carousel-view.php render partial

#### Core Features (6h)
4. [todo] Implement carousel HTML structure
5. [todo] Add CSS for horizontal scroll
6. [todo] Implement arrow navigation
7. [todo] Add touch/swipe support
8. [todo] Test responsive behavior

#### Testing & QA (2h)
9. [todo] Keyboard navigation testing
10. [todo] Cross-browser testing

#### Documentation (1h)
11. [todo] Update block documentation

---
Status: 2 of 11 tasks complete (18%)
Next up: Create carousel-view.php render partial
```

**Status Legend:**
- `todo` - Not started
- `in-progress` - Currently working on
- `done` - Completed
- `blocked` - Cannot proceed (with blocker info)

## Step 4: Interactive Task Execution

For each task, I'll guide you through:

### Task Presentation
- Display section context (e.g., "Foundation • Task 3 of 3")
- Show full task description
- Display any existing notes or dependencies
- Show related tasks from same section

### Context Reference
- Suggest relevant docs to reference:
  - Requirements/design for expected behavior
  - Implementation notes for technical approach
  - Estimate ticket for acceptance criteria
- Highlight related files from previous tasks

### Planning Discussion
Ask: **"Ready to plan this task?"**

Offer to:
- Break down into sub-steps
- Reference relevant design docs
- Identify files to create/modify
- Suggest implementation approach
- Highlight reusable components
- Note potential gotchas

### Implementation Guidance
- Provide code structure suggestions (not exact code)
- Reference existing patterns to follow
- Identify files to read for context
- Suggest utilities or helpers to use

### Status Update
Ask: **"What's the status of this task?"**

Options:
- `done` - Mark complete, add notes
- `in-progress` - Save progress notes, continue later
- `blocked` - Record blocker info, move to blocked list
- `skipped` - Mark as deferred, add reason

### Notes Capture
For each status, capture:
- **Done**: What was completed, any deviations, relevant commit/file
- **In Progress**: Current state, next steps, estimated completion
- **Blocked**: Blocker description, who can unblock, workaround if possible
- **Skipped**: Reason for deferring, priority, when to revisit

### Code/Document Edits
- Encourage making edits directly in Cursor
- Offer to generate code snippets or boilerplate
- Suggest file creation commands
- Provide testing commands to verify work

## Step 5: Update Planning Doc

After each status change:

### Generate Markdown Snippet
Create formatted markdown to paste into planning doc:

```markdown
- [x] Task: Implement auth service
  - Notes: Finished POST /auth/login endpoint, added unit tests
  - Files: src/services/auth.js, tests/auth.test.js
  - Completed: 2025-10-31
```

### Remind User
- Show the snippet
- Remind to update the planning doc
- Offer to make the update if file is accessible

## Step 6: Check for Newly Discovered Work

After each section or every few tasks:

Ask: **"Any new tasks discovered?"**

If yes:
- Capture new task descriptions
- Assign `todo` status
- Add to "New Work" section
- Estimate additional hours
- Update total effort estimate

**Example:**
```markdown
### Newly Discovered Work
- [ ] Add image lazy loading to carousel cards
  - Discovered: During responsive testing
  - Estimate: 1h FE
  - Priority: High (performance impact)
```

## Step 7: Session Summary

At the end of a work session, provide:

### Summary Table

```markdown
### Execution Summary: Featured Content Carousel

**Progress:**
- Completed: 5 of 11 tasks (45%)
- In Progress: 1 task
- Blocked: 1 task
- Remaining: 4 tasks

**Completed This Session:**
- [x] Create carousel-view.php render partial
- [x] Implement carousel HTML structure
- [x] Add CSS for horizontal scroll
- [x] Implement arrow navigation
- [x] Add touch/swipe support

**In Progress:**
- [ ] Test responsive behavior
  - Next: Test on iPad and mobile devices
  - Files: /assets/css/carousel.css

**Blocked:**
- [ ] Cross-browser testing
  - Blocker: Need access to BrowserStack account
  - Owner: IT team

**Remaining:**
- [ ] Keyboard navigation testing
- [ ] Update block documentation

**Newly Discovered:**
- [ ] Add image lazy loading
- [ ] Optimize carousel performance on slow networks

**Hours Logged:** 6h FE
**Hours Remaining:** ~6h FE, 1h Documentation
```

### Files Modified
List all files created or modified this session:
```
Created:
- /blocks/queried-content/carousel-view.php
- /assets/js/carousel.js
- /assets/css/carousel.css

Modified:
- /blocks/queried-content/block.json
- /blocks/queried-content/render.php
```

## Step 8: Next Actions

Remind you to:

1. **Update Planning Doc**
   - Copy status updates to your planning document
   - Mark completed checkboxes
   - Add notes to in-progress items
   - Document blockers

2. **Update Supporting Docs**
   - Sync implementation doc if decisions changed
   - Update design doc if approach evolved
   - Note deviations from requirements

3. **Run Related Commands**
   - `/check-implementation` - Validate against design/requirements
   - `/writing-test` - Generate tests for completed work
   - `/update-planning` - Reconcile planning doc with current state

4. **Run Tests**
   - Unit tests for new functionality
   - Integration tests for modified features
   - Manual testing checklist

5. **Commit Work**
   - Commit completed tasks
   - Use descriptive commit messages
   - Reference ticket/task numbers

6. **Next Session Planning**
   - What to tackle next
   - Any prep work needed
   - Blockers to resolve

## WordPress Theme-Specific Features

During execution, I'll provide WordPress-aware guidance:

- **Theme Structure** (proper file locations)
- **WordPress Coding Standards** (PHPCS/WPCS compliance)
- **Block Registration** (block.json patterns, render callbacks)
- **Template Hierarchy** (correct template naming)
- **Hook Usage** (when to use actions vs. filters)
- **Query Optimization** (efficient WP_Query patterns)
- **Enqueue Patterns** (proper script/style registration)
- **Accessibility** (WordPress accessibility standards)
- **Security** (nonce verification, data sanitization)
- **Performance** (caching, transients, object cache)

## Communication Guidelines

**Important:** All documentation and status updates are visible to the entire project team, including clients.

### Writing Style

✅ **DO:**
- Use plain English without jargon
- Keep updates brief and focused
- State what was done, not how you did it
- Use simple, direct sentences
- Focus on outcomes and results

❌ **DON'T:**
- Include technical implementation details
- Write lengthy explanations or rambling notes
- Use developer-specific terminology
- Explain obvious things
- Over-explain your process

### Output Format

**Critical:** When providing ticket updates or markdown to paste into Teamwork:

✅ **DO:**
- Provide ONLY the formatted content to copy/paste
- Deliver the ticket information directly
- Let the content speak for itself

❌ **DON'T:**
- Summarize what you're about to provide
- Explain what you just wrote
- Add meta-commentary like "Here's the update..." or "I've prepared..."
- Include unnecessary preambles or conclusions

### Examples

**Good:**
```markdown
- [x] Create carousel-view.php render partial
  - Notes: Added carousel view with arrow navigation
  - Completed: 2025-10-31
```

**Bad (Unnecessary Noise):**
```
Great! I've prepared the following update for you to paste into Teamwork. This captures what was completed during this task. Here it is:

- [x] Create carousel-view.php render partial
  - Notes: Added carousel view with arrow navigation
  - Completed: 2025-10-31

As you can see, I've marked this as complete and included the key details about what was accomplished.
```

**Too Verbose:**
```markdown
- [x] Create carousel-view.php render partial
  - Notes: So I started by looking at the existing featured-laureates-carousel.php file to understand the pattern we're using, and then I created a new file called carousel-view.php in the blocks/queried-content directory. I followed the same structure as the laureates carousel but adapted it for our use case. I also made sure to include all the accessibility attributes like aria-labels because that's important for screen readers and we want to follow WCAG guidelines. I used get_template_part() to load the card partial which is the WordPress way of doing things...
  - Completed: 2025-10-31
```

## Best Practices

### What Makes Good Task Execution

✅ **DO:**
- Work through tasks in order (respect dependencies)
- Capture detailed notes for each task
- Document blockers immediately
- Track newly discovered work
- Test as you go
- Commit frequently
- Reference design/requirements docs
- Update planning doc regularly

❌ **DON'T:**
- Skip around randomly (breaks dependencies)
- Leave tasks partially done without notes
- Ignore blockers until later
- Forget about newly discovered work
- Wait to test until the end
- Make huge commits
- Deviate from plan without documenting why

### Execution Quality Checklist

For each task, verify:
- [ ] Task requirements are clear
- [ ] Related files are identified
- [ ] Implementation follows existing patterns
- [ ] Code is tested (unit/integration)
- [ ] Documentation is updated
- [ ] Status and notes are captured
- [ ] Planning doc is updated

## Example Session

```
You: /execute-plan

AI: I'll help you execute your feature plan. Let me gather context.

What's the feature name? (kebab-case, e.g., featured-carousel)

You: featured-content-carousel

AI: Great! Where's your planning doc?

You: planning/feature-featured-content-carousel.md

AI: [Loads planning doc]

Found 11 tasks across 4 sections:
- Foundation: 3 tasks (2 done, 1 todo)
- Core Features: 5 tasks (all todo)
- Testing: 2 tasks (all todo)
- Documentation: 1 task (todo)

Progress: 2 of 11 tasks complete (18%)

---

### Next Task: Foundation • Task 3 of 3

**Task:** Create carousel-view.php render partial

**Context:** This partial will render the carousel markup structure.
Should reference the existing featured-laureates-carousel.php pattern.

**Related Files:**
- Reference: /partials/featured-laureates-carousel.php
- Location: /blocks/queried-content/carousel-view.php

Ready to plan this task?

You: Yes

AI: Here's the implementation plan:

**Steps:**
1. Read /partials/featured-laureates-carousel.php for markup pattern
2. Create /blocks/queried-content/carousel-view.php
3. Structure as:
   - Container with horizontal-scroll class
   - Loop through posts rendering event cards
   - Include arrow navigation markup
   - Add aria-labels for accessibility

**Files to Create:**
- /blocks/queried-content/carousel-view.php

**Files to Reference:**
- /partials/featured-laureates-carousel.php (carousel structure)
- /partials/cards/event-card.php (card rendering)
- /partials/block-separator.php (arrow markup)

**Implementation Notes:**
- Use get_template_part() to include event-card partial
- Add data-attributes for JS hooks
- Follow WordPress template part conventions
- Include phpcs:disable comments if needed for template syntax

Ready to implement?

You: [implements the file]

You: Done

AI: Excellent! What's the status?

You: done

AI: Great! Any notes about this task?

You: Created carousel-view.php, follows laureates pattern, includes accessibility attributes

AI: Perfect! Here's the markdown snippet for your planning doc:

```markdown
- [x] Create carousel-view.php render partial
  - Notes: Created carousel-view.php, follows laureates pattern, includes accessibility attributes
  - Files: /blocks/queried-content/carousel-view.php
  - Completed: 2025-10-31
```

Foundation section complete! (3 of 3 tasks done)

Moving to next section: Core Features (5 tasks)

---

### Next Task: Core Features • Task 1 of 5

**Task:** Implement carousel HTML structure

[... continues through remaining tasks ...]
```

## Related Commands

During execution:
- Use `/check-implementation` to validate work against plan
- Use `/write-test` to generate tests for completed features
- Use `/debug-issue` if you encounter issues
- Use `/review-code` before committing major changes

After execution:
- Use `/update-planning` to reconcile progress with plan
- Use `/handoff-qa` to prepare for QA testing

---

## ✨ Next Command

After completing `/execute-plan`:

**Next Step:** Run `/check-implementation`

```bash
/check-implementation
```

**What it does:** Compares your implementation against the PRD and estimate ticket to ensure the code matches the planned approach and satisfies all requirements.

**Why this matters:** Validates that your implementation aligns with the design before moving forward with testing and review.

**Alternative:** If you encounter issues during execution, use `/debug-issue` to troubleshoot before continuing.

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-10-31  
**Compatible With**: Cursor AI Editor

