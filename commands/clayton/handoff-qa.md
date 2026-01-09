---
name: Handoff QA
description: Validates acceptance criteria and generates QA documentation for Teamwork
---

# Handoff QA

Verifies acceptance criteria from the estimate ticket are met and generates comprehensive QA handoff documentation ready to paste into Teamwork.

## When to Use

- Implementation is complete and developer-tested
- Ready to move ticket from "In Progress" to "Ready for QA"
- Before deploying to staging for QA review

## Process

### Step 1: Gather Context

Ask for:
1. **Estimate Ticket** - Teamwork ID/link, or paste acceptance criteria directly
2. **Feature Summary** - What was built, key functionality, any changes from estimate
3. **Environment** - URL to test, required test accounts, special setup
4. **Entry Points** - URLs to pages, admin paths, how to access the feature
5. **Known Limitations** - Expected behaviors that might seem like bugs, deferred items

### Step 2: Validate Acceptance Criteria

For each acceptance criterion from the estimate ticket:

1. **Check status** - Met, Partially Met, or Not Met
2. **Document implementation** - How it was implemented
3. **Note verification steps** - How QA can verify it works
4. **Flag gaps** - If not fully met, explain what's missing and recommend action

Use @file to reference relevant implementation files.

### Step 5: Output

Generate the QA handoff document following this structure:

```markdown
## Summary
[2-3 sentences on what was built]

## Where to Test

**Environment:** [URL]

## Testing Steps

### Test 1: [Name]
**AC:** [Acceptance criterion]
**Expected:** [Result]

[Continue for all critical tests]

```

## Output Rules

CRITICAL: Follow these rules exactly.

1. Output ONLY the QA Handoff document
2. Do NOT add introductions ("Here's the documentation...", "I've prepared...")
3. Do NOT add summaries or wrap-up text after the document
4. Do NOT explain what the document contains
5. The formatted document IS your complete response

The output must be IMMEDIATELY COPY-PASTEABLE into Teamwork.

---

Next: Paste into Teamwork and move ticket to "Ready for QA".
Related: `/clayton/review-code`, `/clayton/write-test`, `/clayton/debug-issue`
