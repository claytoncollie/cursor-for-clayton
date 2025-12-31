---
name: Debug Issue
description: Structured debugging assistant for WordPress theme development
---

# Debug Issue

Helps debug issues by clarifying expectations, identifying gaps, and agreeing on a fix plan before changing code. Takes a structured approach to isolate problems and surface resolution options.

Use Cursor's Debug Mode (Cmd+Shift+D) for runtime debugging with automatic logging instrumentation.

## When to Use

- Unexpected behavior that doesn't match requirements
- Bugs discovered during testing or in production
- Features not working as designed
- Performance issues needing investigation
- Integration problems with WordPress or third-party code

## Process

### Step 1: Gather Context

Ask for:

**Issue Description:**
- What is happening? (observed behavior, consistent or intermittent?)
- Where is it happening? (page, environment, browsers affected?)
- Reproduction steps

**Expected Behavior:**
- What should happen? (reference requirements or acceptance criteria)
- Link to design or estimate ticket

**Recent Changes:**
- Recent commits, deployments, or WordPress/plugin updates
- When was it last working?

Use @Git to check recent changes. Use @file to reference specific files.

### Step 2: Clarify Reality vs Expectation

Document:
```markdown
**Observed:** [What actually happens]
**Expected:** [What should happen, with source]
**Gap:** [The difference]

**Fix Criteria:**
- [ ] [Specific measurable outcome]
- [ ] [Test case that must pass]
```

### Step 3: Reproduce & Isolate

Determine:
- **Reproducibility:** Always, intermittent, environment-specific, user-specific?
- **Exact reproduction steps** with environment details
- **Suspected components:** Files, functions, hooks, queries, JavaScript

Write reproduction steps:
```markdown
1. Navigate to [page]
2. Perform [action]
3. Observe: [actual result] (expected: [expected result])

Environment: WordPress [version], PHP [version], Theme [version]
Browser: [browser and version]
```

### Step 4: Analyze Potential Causes

Brainstorm root causes:

| Category | Possible Causes |
|----------|-----------------|
| Code | Logic errors, missing validation, wrong conditionals |
| Data | Incorrect DB values, missing meta, corrupted data |
| Config | Wrong settings, plugin conflicts, server config |
| Integration | WP version incompatibility, API changes |
| Regression | Recent code changes, refactoring mistakes |

Gather evidence:
- PHP error logs, JS console errors, WP debug log
- Stack traces, query logs, Xdebug output
- Screenshots, Network tab inspection

### Step 5: Surface Options

Present resolution paths:

```markdown
### Option 1: [Name]
**Approach:** [Description]
**Pros:** [Benefits]
**Cons:** [Drawbacks]
**Risk:** [What could go wrong]
```

Common patterns:
- **Quick Fix:** Minimal change, addresses symptom, may need follow-up
- **Deep Fix:** Addresses root cause, may require refactoring
- **Rollback:** Revert recent changes, buys time for proper fix
- **Workaround:** Temporary solution, document for tracking

WordPress-specific options:
- Clear object cache, transients, rewrites, opcache
- Deactivate suspect plugins, test with default theme
- Add filter/hook to modify behavior, remove problematic hook

### Step 6: Confirm Path Forward

Recommend preferred option with rationale:

```markdown
### Chosen Approach: [Name]

**Steps:**
1. [Step 1]
2. [Step 2]

**Success Criteria:**
- [ ] Issue no longer reproduces
- [ ] Tests pass
- [ ] No new issues introduced

**Rollback Plan:**
If fix fails: Revert commit [hash], clear cache, verify
```

### Step 7: Document & Track

Create issue documentation:

```markdown
## Issue: [Title]

**Root Cause:** [Brief explanation]

**Fix:** [What was changed]

**Files Changed:**
- [file1] - [what changed]
- [file2] - [what changed]

**Testing:**
- [ ] Regression test added
- [ ] Manual verification complete
```

## Output Rules

CRITICAL: Follow these output rules exactly.

1. Output ONLY the formatted content specified in this command
2. Do NOT add introductions ("Here's...", "I've prepared...", "Below is...")
3. Do NOT add summaries or wrap-up text after the output
4. Do NOT add meta-commentary about what you produced
5. Do NOT explain what the output contains
6. The formatted output IS your complete response - nothing before, nothing after

The output must be IMMEDIATELY COPY-PASTEABLE without removing surrounding text.

---

After fixing: Run `/write-test` to add regression tests, then `/check-implementation` to verify.
Related: /check-implementation, /write-test, /review-code
