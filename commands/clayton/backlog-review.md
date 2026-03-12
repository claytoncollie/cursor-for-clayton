---
name: Backlog Review
description: Skill that reviews a PR/MR against its ticket requirements and PRD, auto-fixes issues or flags for human review
---

# Backlog Review

Reviews a PR/MR diff against the ticket requirements and PRD. Auto-fixes issues when possible, flags for human review when not. Invoked by a backlog worker agent — not meant to be run directly.

## Input

Receives a ticket ID as an argument. Fetch the full ticket and comments from Teamwork to find the PRD and MR/PR link.

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
- No XSS (unescaped output in templates)
- No SQL injection (raw queries without preparation)
- Proper WordPress escaping (`esc_html`, `esc_attr`, `wp_kses`, etc.)
- Input validation and output sanitization

### Performance
- No unnecessary database queries in loops
- No missing caching where patterns exist
- No large unoptimized asset additions

### Conventions
- Follows existing naming patterns (functions, classes, CSS, blocks)
- File placement matches project structure
- Code style matches surrounding code

### Scope
- Changes limited to what the ticket requires
- No unrelated refactors, cleanups, or improvements

## 3. Classify findings

For each issue found:

- **auto-fixable** — lint issues, missing escaping, naming inconsistency, minor logic fix
- **needs-human** — architectural concern, ambiguous requirement, scope question, design decision

## 4. Auto-fix (if needed)

If auto-fixable issues found:

1. Check out the PR branch
2. Make targeted fixes (only address identified issues)
3. Run quality checks
4. Commit: `fix: address review findings (#{ticket-id})`
5. Push
6. Re-review the updated diff
7. Repeat up to 2 total fix attempts

## 5. Post results

### All checks pass (no issues or all auto-fixed):

- Tag the ticket `review-passed` via `updateTask`
- Post summary comment on the ticket:

```markdown
**Review passed.** MR/PR is ready for human merge.

- All acceptance criteria addressed
- Quality checks passing
- {1 sentence on what was verified}
```

### Needs-human issues remain:

- Tag the ticket `needs-human` via `updateTask`
- Post detailed findings as Teamwork comment:

```markdown
**Review: needs human attention.**

### Issues Found

1. **[Category]**: [Description and why it needs human judgment]

### Auto-fixed

- [Issues that were automatically resolved, if any]

### MR/PR

{link}
```

</process>

<output_rules>
- Review every file in the diff, not just a sampling
- Reference specific file paths and line numbers in findings
- Auto-fix only clear-cut issues — when in doubt, flag for human
- Never approve changes that introduce security vulnerabilities
</output_rules>
