---
name: Backlog Execute
description: Skill that implements code changes for a triaged ticket, creates a branch, and opens an MR/PR
---

# Backlog Execute

Implements the code changes described in a ticket's PRD, creates a branch, runs quality checks, and opens an MR/PR. Invoked by a backlog worker agent — not meant to be run directly.

## Input

Receives a ticket ID and base branch as arguments. Fetch the full ticket from Teamwork via `getTaskById`.

<process>

## 1. Load context

- Read all comments to find the PRD (the comment containing "## Engineering Approach")
- If no PRD comment found, stop and report failure
- Detect VCS host from `git remote get-url origin` (GitHub → `gh`, GitLab → `glab`)

## 2. Create branch

- Branch name: `agent/{ticket-id}-{kebab-slug}`
  - `{ticket-id}` is the Teamwork task ID
  - `{kebab-slug}` is the ticket title, lowercased, spaces to hyphens, max 50 chars, stripped of special characters
- Create from the base branch: `git checkout -b agent/{ticket-id}-{kebab-slug} origin/{base-branch}`
- If branch exists, append `-2` and retry

## 3. Implement changes

Follow the PRD's Engineering Approach:

- Read all files listed in the PRD before making changes
- Follow existing codebase conventions (naming, structure, patterns)
- Make small, focused changes — one concern per file modification
- Add comments only where logic is non-obvious
- Do NOT add unrelated improvements, refactors, or cleanup

## 4. Run quality checks

Run the project's quality gates (only for file types changed):

```bash
npm run lint-js        # JS changes
npm run lint-style     # CSS changes
composer lint           # PHP changes
composer static         # PHP changes
npm run test            # JS tests
```

## 5. Auto-fix failures

If any quality check fails:

1. Read the error output
2. Try auto-fix first: `npm run lint-js -- --fix`, `composer lint-fix`
3. Re-run the failing check
4. Repeat up to 3 total attempts
5. If still failing: stop, tag ticket `needs-human`, post failure output as Teamwork comment

## 6. Commit

- Stage only the files you changed (explicit paths, not `git add -A`)
- Do NOT stage secrets, `.env`, or unrelated files

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
- **GitHub**: `gh pr create --title "..." --body "$(cat <<'EOF' ... EOF)"`
- **GitLab**: `glab mr create --title "..." --description "$(cat <<'EOF' ... EOF)"`

MR/PR body format:

```markdown
## Summary

- {2-3 bullets describing the change}

## Teamwork

#{ticket-id}

## Acceptance Criteria

{copied from PRD}
```

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
| PRD comment not found | Stop, tag `needs-human`, post error as comment |
| Branch name collision | Append `-2` suffix and retry |
| Lint/test failures after 3 attempts | Tag `needs-human`, post failures as comment, stop |
| Push or MR/PR creation fails | Retry once, then tag `needs-human` and stop |

</error_handling>
