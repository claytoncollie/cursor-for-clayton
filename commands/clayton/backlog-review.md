---
name: Backlog Review
description: Review a PR/MR against its ticket requirements and PRD, auto-fix issues or flag for human review
---

# Backlog Review

Reviews a PR/MR diff against the ticket requirements and PRD. Auto-fixes issues when possible, flags for human review when not. Used by `/clayton/backlog` during the review phase.

<process>

## 1. Load context

- Fetch the ticket from Teamwork via `getTaskById`
- Read all comments to find the PRD (contains "## Engineering Approach") and the MR/PR link
- Fetch the MR/PR diff:
  - **GitHub**: `gh pr diff {number}`
  - **GitLab**: `glab mr diff {number}`

## 2. Review against requirements

Check the diff against these criteria:

### Correctness
- Does the code do what the ticket asks for?
- Are all acceptance criteria from the PRD addressed?
- Are there missing edge cases?

### Security
- No XSS vulnerabilities (unescaped output in templates)
- No SQL injection (raw queries without preparation)
- No command injection
- Proper input validation and output sanitization
- Proper use of WordPress escaping functions (`esc_html`, `esc_attr`, `wp_kses`, etc.)

### Performance
- No unnecessary database queries in loops
- No missing caching where patterns exist in the codebase
- No large unoptimized asset additions

### Conventions
- Follows existing naming patterns (functions, classes, CSS, blocks)
- File placement matches project structure
- Code style matches surrounding code
- Comments only where logic is non-obvious

### Scope
- Changes are limited to what the ticket requires
- No unrelated refactors, cleanups, or improvements
- No added dependencies without justification

## 3. Classify findings

For each issue found, classify as:

- **auto-fixable** — lint issues, missing escaping, naming inconsistency, minor logic fix
- **needs-human** — architectural concern, ambiguous requirement, scope question, design decision

## 4. Auto-fix (if needed)

If auto-fixable issues found:

1. Check out the PR branch
2. Make targeted fixes (only address identified issues)
3. Run quality checks to confirm the fix doesn't break anything
4. Commit with message: `fix: address review findings (#{ticket-id})`
5. Push
6. Re-review the updated diff
7. Repeat up to 2 total fix attempts

## 5. Post review

### If all checks pass (no issues or all auto-fixed):

- Tag the ticket `review-passed` via `updateTask`
- Post a brief summary comment on the ticket:

```markdown
**Review passed.** MR/PR is ready for human merge.

Changes reviewed:
- [1-2 sentence summary of what was checked]
- All acceptance criteria addressed
- Quality checks passing
```

### If needs-human issues remain:

- Tag the ticket `needs-human` via `updateTask`
- Post detailed findings as a Teamwork comment:

```markdown
**Review: needs human attention.**

### Issues Found

1. **[Category]**: [Description of the issue and why it needs human judgment]
2. **[Category]**: [Description]

### Auto-fixed

- [List of issues that were automatically resolved, if any]

### MR/PR

{link}
```

</process>

<output_rules>
- Review every file in the diff, not just a sampling
- Reference specific line numbers and file paths in findings
- Auto-fix only clear-cut issues — when in doubt, flag for human
- Never approve changes that introduce security vulnerabilities
- Keep review comments actionable and specific
</output_rules>
