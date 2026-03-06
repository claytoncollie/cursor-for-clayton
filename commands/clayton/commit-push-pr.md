---
name: Commit Push PR
description: Commit all staged/unstaged changes, push the branch, and open a PR/MR (GitHub or GitLab) with a generated description
user_invocable: true
---

# Commit Push PR

Commit all changes, push the current branch, and open a pull request (GitHub) or merge request (GitLab) with a generated description.

<process>

## 1. Gather context (run all three in parallel)

- `git status` — see all modified/untracked files
- `git diff` and `git diff --cached` — see unstaged and staged changes
- `git log --oneline -10` — recent commit style reference

If there are no changes to commit, stop and tell the user.

## 2. Stage and commit

- Stage all modified and untracked files relevant to the work (prefer explicit file paths over `git add -A`)
- Do NOT stage files that look like secrets (.env, credentials, etc.) — warn the user if any are present
- Write a concise commit message:
  - First line: imperative summary under 72 chars
  - Blank line, then a short paragraph explaining the "why"
- Use a HEREDOC to pass the message:

```
git commit -m "$(cat <<'EOF'
Subject line here

Body here.
EOF
)"
```

- If a pre-commit hook fails, fix the issue, re-stage, and create a NEW commit (never amend)

## 3. Push

- Push the current branch with `-u origin <branch>`

## 4. Open PR / MR

- Determine the base branch (usually `main` or `master`)
- Generate a title (under 70 chars) and body from ALL commits on the branch since it diverged from base: `git log <base>..HEAD --oneline`
- Detect the host from the remote: `git remote get-url origin`
  - **GitHub** (github.com): use `gh pr create`
  - **GitLab** (gitlab.com or self-hosted *gitlab* in URL): use `glab mr create` (GitLab CLI)
- **If GitHub:** use `gh pr create` with a HEREDOC body:

```
gh pr create --title "PR title" --body "$(cat <<'EOF'
Summary

- Bullet points describing what changed and why

Test plan

- Verification steps
EOF
)"
```

- **If GitLab:** use `glab mr create` with a HEREDOC description (`--description`, not `--body`):

```
glab mr create --title "MR title" --description "$(cat <<'EOF'
Summary

- Bullet points describing what changed and why

Test plan

- Verification steps
EOF
)"
```

- If the repo is GitLab but `glab` is not installed, push first then tell the user to open the "Create merge request" link GitLab prints, or install [glab](https://gitlab.com/gitlab-org/cli)
- Return the PR/MR URL to the user when done

## 5. Watch CI pipeline

- After the PR/MR is created, monitor CI check status:
  - **GitHub:** `gh pr checks <pr-number> --watch`
  - **GitLab:** `glab ci status --live`
- If a CI check fails:
  1. Read the failure logs (`gh run view <run-id> --log-failed` or `glab ci trace`)
  2. Identify the root cause (lint error, test failure, type error)
  3. Fix the issue locally
  4. Stage, commit (new commit — never amend), and push
  5. Resume watching checks
- Give up after 3 fix attempts — report remaining failures to the user with log excerpts
- Once all checks pass, report the green status and PR/MR URL

</process>

<output_rules>
- Return the PR or MR URL to the user when it is created
- Warn the user if any modified files look like secrets; do not stage them
- Never amend after a failed pre-commit hook — fix, re-stage, and create a new commit
- Report CI check results after pipeline completes (pass or fail)
</output_rules>

<error_handling>
- If pre-commit hook fails: fix the reported issue, re-stage the affected files, then run `git commit` again with a NEW commit (do not use `--amend`)
- If push fails (e.g. no upstream, auth): report the error and suggest next steps (e.g. `gh auth status` or `glab auth status`, set remote)
- If GitHub and `gh pr create` fails: report the error and suggest checking `gh pr create --help` or repo PR settings
- If GitLab and `glab mr create` fails: report the error; if `glab` is missing, suggest installing the GitLab CLI or using the "Create merge request" link after push
- If CI checks fail after 3 fix attempts: stop, report the failures with log excerpts, and suggest manual investigation
</error_handling>

---

Next: Share the PR/MR URL with reviewers or run `/clayton/handoff-qa` when ready for QA.
