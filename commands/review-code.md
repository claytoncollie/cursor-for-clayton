---
name: Review Code
description: Pre-push code review for WordPress theme development
---

# Review Code

Performs thorough local code review before pushing changes. Catches issues early, validates against design docs, and ensures code quality.

## When to Use

- Before pushing to remote
- After completing features
- Before creating PRs
- After major refactoring
- Before QA handoff

## Process

### Step 1: Gather Context

I'll ask you for:

- **Feature description**: What was built/changed and why
- **Modified files**: New, modified, and deleted files
- **Relevant docs**: Design docs, PRD, estimate ticket
- **Known risks**: Complex logic, performance-critical, security-sensitive areas
- **Testing status**: What tests have been run

Use @Git to get diff context:
```bash
git status -sb
git diff --stat
```

Use @Linter Errors to check for coding standards issues.

### Step 2: Understand Design Alignment

For each design doc, I'll identify:
- Architectural decisions and patterns to follow
- Critical requirements and constraints
- Integration points and dependencies

### Step 3: File-by-File Review

For every modified file, I'll check:

**Design Alignment:**
- Implements documented requirements
- Follows specified patterns
- Meets acceptance criteria

**Logic & Flow:**
- Logic is correct and clear
- Edge cases handled (empty, null, max values, errors)
- No obvious bugs

**Security (WordPress):**
- Input validated
- Output escaped (esc_html, esc_attr, esc_url)
- Nonces verified for forms
- Capability checks for admin
- SQL queries prepared

**Performance:**
- No N+1 queries
- Appropriate caching
- Assets loaded conditionally

**Accessibility:**
- Semantic HTML
- ARIA labels where needed
- Keyboard navigation works

**Code Quality:**
- Follows PHPCS/WPCS
- No duplicate code
- Clear naming
- DocBlocks present

### Step 4: Cross-Cutting Concerns

- Naming consistency across files
- Documentation reflects changes
- Test coverage adequate
- Config/migration needs documented

### Step 5: Summarize Findings

## Output Format

```markdown
### Code Review Summary

**Overall Assessment:** [Ready to Push / Needs Revision / Major Issues]

**Review Stats:**
- Files reviewed: [count]
- Issues found: [count]
  - Blocking: [count]
  - Important: [count]
  - Nice-to-have: [count]

**Quality Metrics:**
- Design alignment: ✅/⚠️/❌
- Security: ✅/⚠️/❌
- Performance: ✅/⚠️/❌
- Accessibility: ✅/⚠️/❌

---

### Findings

#### 1. [File Path]

**Issue:** [Description]
**Impact:** [Blocking / Important / Nice-to-have]
**Category:** [Security / Performance / Logic / etc.]

**Current:**
```php
// problematic code
```

**Recommended:**
```php
// fixed code
```

---

### Recommended Next Steps

#### Blocking (Fix Before Push)
- [ ] Issue 1
- [ ] Issue 2

#### Important (Fix Soon)
- [ ] Issue 1

#### Testing Required
- [ ] Test case 1
- [ ] Test case 2

---

**Pre-Push Checklist:**
- [ ] All blocking issues fixed
- [ ] Security validated
- [ ] Tests passing
- [ ] Documentation updated

**Status:** [✅ Ready to Push / ⚠️ Fix Issues First]
```

## Output Rules

CRITICAL: Follow these output rules exactly.

1. Output ONLY the formatted review summary specified above
2. Do NOT add introductions ("Here's...", "I've reviewed...")
3. Do NOT add summaries or wrap-up text after the output
4. Do NOT add meta-commentary about what you produced
5. The formatted output IS your complete response

The output must be IMMEDIATELY COPY-PASTEABLE without removing surrounding text.

---

Next: Run `/handoff-qa` to generate QA documentation.
Related: /check-implementation, /write-test, /handoff-qa
