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

### Step 3: Generate Test Steps

For each acceptance criterion, create test cases:

```markdown
### Test [N]: [Test Name]

**Acceptance Criterion:** [The AC being tested]

**Preconditions:**
- [Required state before testing]

**Steps:**
1. [Numbered action steps]
2. [Be specific and detailed]

**Expected Result:**
[What should happen]
```

Organize tests by priority:
- **Critical** - Must pass for feature to be acceptable
- **Important** - Should pass, workarounds may exist
- **Nice-to-have** - Test if time allows

### Step 4: Document Known Limitations

Capture:
- **Expected Behaviors** - Things that might seem like bugs but are intentional
- **Browser/Device Constraints** - Platform-specific limitations
- **Out of Scope** - Deferred functionality not included in this release

### Step 5: Output

Generate the QA handoff document following this structure:

```markdown
# QA Handoff: [Feature Name]

## Summary
[2-3 sentences on what was built]

**Estimate Ticket:** [Link]

---

## Where to Test

**Environment:** [URL]
**Test Accounts:** [Username/password or reference to credential store]

**Entry Points:**
- [URL or path to access feature]
- [Additional entry points]

---

## Testing Steps

### Critical Tests

#### Test 1: [Name]
**AC:** [Acceptance criterion]
**Steps:**
1. [Step]
2. [Step]
**Expected:** [Result]

[Continue for all critical tests]

### Important Tests

[Same format]

---

## Known Limitations

**Expected Behaviors (Not Bugs):**
- [Behavior]: [Why it's intentional]

**Out of Scope:**
- [Feature]: [Deferred to future release]

---

## Files Changed

**New:** [List new files]
**Modified:** [List modified files]

---

**QA Handoff Prepared:** [Date]
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
Related: `/review-code`, `/write-test`, `/debug-issue`
