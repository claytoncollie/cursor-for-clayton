---
name: Backlog Execute
description: Implement code changes for a triaged ticket with PRD, create branch, and open MR/PR
---

# Backlog Execute

Implements the code changes described in a ticket's PRD, creates a branch, runs quality checks, and opens an MR/PR. Used by `/clayton/backlog` during the execution phase.

<process>

## 1. Load context

- Fetch the ticket from Teamwork via `getTaskById`
- Read the PRD comment (the most recent comment containing "## Engineering Approach")
- Determine VCS host from `git remote get-url origin` (GitHub → `gh`, GitLab → `glab`)
- Determine base branch (usually `trunk`, `main`, or `master`)

## 2. Create branch

- Branch name: `agent/{ticket-id}-{kebab-slug}`
  - `{ticket-id}` is the Teamwork task ID
  - `{kebab-slug}` is the ticket title, lowercased, spaces to hyphens, max 50 chars, stripped of special characters
- Create from the base branch: `git checkout -b agent/{ticket-id}-{kebab-slug} origin/{base-branch}`

## 3. Implement changes

Follow the PRD's Engineering Approach:

- Read all files listed in the PRD before making changes
- Follow existing codebase conventions (naming, structure, patterns)
- Make small, focused changes — one concern per file modification
- Add comments only where logic is non-obvious
- Do NOT add unrelated improvements, refactors, or cleanup

## 4. Run quality checks

Run the project's quality gates:

```bash
# JavaScript/CSS (if changed)
npm run lint-js
npm run lint-style

# PHP (if changed)
composer lint
composer static

# Tests
npm run test        # JS tests
composer test       # PHP tests (if available)
```

Only run checks relevant to the files changed.

## 5. Auto-fix failures

If any quality check fails:

1. Read the error output
2. Fix the issue (lint auto-fix first: `npm run lint-js -- --fix`, `composer lint-fix`)
3. Re-run the failing check
4. Repeat up to 3 total attempts

If still failing after 3 attempts:
- Tag the ticket `needs-human` via `updateTask`
- Post the failure output as a Teamwork comment via `createComment`
- Stop execution for this ticket

## 6. Commit

- Stage only the files you changed (explicit paths, not `git add -A`)
- Do NOT stage secrets, `.env`, or unrelated files
- Write a commit message:

```
git commit -m "$(cat <<'EOF'
{imperative summary under 72 chars} (#{ticket-id})

{1-2 sentences explaining what changed and why}

Teamwork: #{ticket-id}
EOF
)"
```

## 7. Push and create MR/PR

- Push: `git push -u origin agent/{ticket-id}-{kebab-slug}`
- Create MR/PR with:
  - **Title**: commit subject line
  - **Body/Description**:

```markdown
## Summary

{2-3 bullets describing the change}

## Teamwork

{link to Teamwork ticket}

## Acceptance Criteria

{copied from PRD}
```

- **GitHub**: `gh pr create --title "..." --body "$(cat <<'EOF' ... EOF)"`
- **GitLab**: `glab mr create --title "..." --description "$(cat <<'EOF' ... EOF)"`

## 8. Post back to Teamwork

- Post the MR/PR URL as a comment on the ticket via `createComment`
- Tag the ticket `pr-open` via `updateTask` (append to existing tags)

</process>

<output_rules>
- One branch per ticket, one MR/PR per ticket
- Small, atomic changes — do not bundle unrelated work
- Follow existing codebase conventions exactly
- Never skip quality checks
- Always reference the ticket ID in the commit message and MR/PR
</output_rules>

<error_handling>

| Scenario | Behavior |
|----------|----------|
| PRD comment not found on ticket | Stop, tag `needs-human`, post error as comment |
| Branch name already exists | Append `-2` suffix and retry |
| Lint/test failures after 3 attempts | Tag `needs-human`, post failures as comment, stop |
| Push fails | Retry once, then tag `needs-human` and stop |
| MR/PR creation fails | Post error as Teamwork comment, tag `needs-human` |

</error_handling>
