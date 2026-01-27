---
name: Check Implementation
description: Validate code against PRD and estimate ticket
---

# Check Implementation

Validates implementation against PRD and estimate ticket.

## When to Use

- After completing major features to validate against plan
- Before code review to catch deviations early
- During implementation to verify alignment
- After refactoring to ensure requirements still met
- Before QA handoff to confirm acceptance criteria

## Process

### Step 1: Gather Context

- **Feature description**: Brief summary of what was built
- **Modified files**: New, modified, deleted files
- **Relevant docs**: Design docs, PRD, estimate ticket
- **Implementation notes**: Decisions made, deviations, concerns

Use @Git to see what changed:
```bash
git status -sb
git diff --stat
```

### Step 2: Understand Design Intent

For each provided doc, I'll identify:

- **Architectural decisions**: Key technical choices
- **Component structure**: Expected components and relationships
- **Data models**: Post types, taxonomies, fields
- **Integration points**: APIs, hooks, external systems
- **Acceptance criteria**: QA-testable requirements

### Step 3: File-by-File Comparison

For every modified file, I'll check:

**Design Alignment:**
- Follows architectural decisions
- Implements expected components
- Uses correct data models
- Integrates at proper points

**Requirements Alignment:**
- Implements core requirements
- Satisfies user stories
- Meets success criteria
- Handles edge cases

**Acceptance Criteria:**
- Each criterion met
- Behavior matches expectations
- Data flows as designed

**Code Quality:**
- Logic is clear and correct
- Edge cases handled
- Security best practices (input validation, output escaping)
- Performance (no N+1 queries, appropriate caching)
- Accessibility (semantic HTML, ARIA, keyboard nav)

### Step 4: Summarize Findings

## Output Format

```markdown
### Implementation Validation Summary

**Overall Status:** [Ready for Review / Needs Revision / Major Issues]

**Issues Found:**
- Blocking: [count]
- Important: [count]
- Nice-to-have: [count]

**Acceptance Criteria:** [X of Y] met ([%])

---

### Findings

#### 1. [File or Component Name]

**Issue:** [Description]
**Impact:** [Blocking / Important / Nice-to-have]

**Expected (from design):**
[What the docs specify]

**Actual (in implementation):**
[What the code does]

**Recommendation:**
[Specific action to take]

---

### Recommended Next Steps

#### Blocking (Must Fix)
- [ ] Issue 1
- [ ] Issue 2

#### Important (Should Fix)
- [ ] Issue 1

#### Documentation Updates
- [ ] Update design doc to reflect [decision]

#### Testing Required
- [ ] Test case 1
- [ ] Test case 2
```

## Output Rules

CRITICAL: Follow these output rules exactly.

1. Output ONLY the formatted validation summary specified above
2. Do NOT add introductions ("Here's...", "I've validated...")
3. Do NOT add summaries or wrap-up text after the output
4. Do NOT add meta-commentary about what you produced
5. The formatted output IS your complete response

The output must be IMMEDIATELY COPY-PASTEABLE without removing surrounding text.

---

Next: Run `/clayton/write-test` to generate tests for your implementation.
