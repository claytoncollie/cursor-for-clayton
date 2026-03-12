---
name: Backlog Pipeline
description: Autonomous pipeline that triages a Teamwork backlog, writes PRDs, executes code changes, and reviews PRs
user_invocable: true
---

# Backlog Pipeline

Autonomous pipeline that fetches tickets from Teamwork task lists, triages them against the codebase, writes PRDs, executes code changes, and reviews the resulting PRs. Designed to run overnight unattended.

## Usage

```
/backlog "List Name 1" "List Name 2" ...
```

Pass one or more Teamwork task list names. The pipeline reads the project ID from `.teamwork` in the working directory.

<process>

## 1. Load project config

- Read `.teamwork` file from the project root for `PROJECT_ID`
- If missing, stop: "No `.teamwork` file found. Create one with `PROJECT_ID=<id>`."
- Detect VCS host from `git remote get-url origin` (GitHub → `gh`, GitLab → `glab`)
- Determine base branch from git (usually `trunk`, `main`, or `master`)

## 2. Fetch task lists

- Call `getTaskListsByProjectId` with the project ID
- Match each user-provided list name (case-insensitive) against returned lists
- If a name has no match, warn and continue with the others
- If no names match, stop with an error

## 3. Fetch tickets

- For each matched task list, call `getTasksByProjectId` filtered to that list
- Collect all open tickets (skip completed/deleted)
- Deduplicate by ticket ID

## 4. Triage (sequential)

For each ticket, run the triage logic from `/clayton/backlog-triage`:

- Read the ticket title, description, and existing tags
- Evaluate against the codebase to determine if it can be solved with code
- Classify into one of:
  - **code-solvable** → tag `good-first-issue`
  - **skip** → tag with reason: `needs-design`, `needs-investigation`, `infrastructure`, `third-party`, `needs-discussion`, `wont-fix`, `for-designer`
- Respect existing tags — if already tagged with a skip reason or `good-first-issue`, don't re-evaluate
- If ticket already has state tags (`prd-written`, `pr-open`, `review-passed`), skip entirely (already in pipeline)

Print a triage summary table when complete:

```
| # | Ticket | Title                    | Decision          |
|---|--------|--------------------------|-------------------|
| 1 | 12345  | Fix header overflow       | good-first-issue  |
| 2 | 12346  | Redesign footer           | needs-design      |
...
Tagged: X code-solvable, Y skipped
```

## 5. PRD + Execute + Review (parallel per ticket)

For each ticket tagged `good-first-issue` (and not already `prd-written` or beyond):

Launch an Agent per ticket (use worktree isolation) that runs these stages sequentially:

### Stage A: Write PRD (`/clayton/backlog-prd` logic)

- Analyze the codebase for relevant files, patterns, and conventions
- Write a detailed engineering PRD as a Teamwork comment on the ticket
- Tag the ticket `prd-written`

### Stage B: Execute (`/clayton/backlog-execute` logic)

- Create branch: `agent/{ticket-id}-{kebab-slug}`
- Implement the changes described in the PRD
- Run project lint and test commands
- Auto-fix lint/test failures (up to 3 attempts)
- Commit with descriptive message referencing the ticket
- Push and create MR/PR targeting the base branch
- Post MR/PR link as a Teamwork comment
- Tag the ticket `pr-open`

### Stage C: Review (`/clayton/backlog-review` logic)

- Review the diff against the ticket requirements and PRD
- Check for: correctness, security, performance, conventions, test coverage
- If issues found: auto-fix, commit, push (up to 2 attempts)
- If still failing after 2 attempts: tag `needs-human` and post findings as Teamwork comment
- If passing: tag `review-passed`

## 6. Final summary

Print a pipeline summary:

```
### Backlog Pipeline Complete

Triaged: X tickets
  - Code-solvable: Y
  - Skipped: Z (needs-design: A, needs-investigation: B, ...)

PRDs written: N
PRs opened: M
Reviews passed: P
Needs human review: Q

PR/MR Links:
- #12345 Fix header overflow → !2600
- #12346 Add calendar export → !2601
...
```

</process>

<resumability>
The pipeline is resumable. Re-running `/backlog` with the same lists will:

- Skip tickets already tagged with state tags (`prd-written`, `pr-open`, `review-passed`)
- Skip tickets tagged with skip reasons
- Only process new or untagged tickets
- Pick up `good-first-issue` tickets that haven't reached `prd-written` yet

This means a failed or interrupted run can be resumed by running the same command again.
</resumability>

<output_rules>
- Print the triage summary table after triage completes
- Print the final pipeline summary when all agents finish
- Log each stage transition per ticket (one line: ticket ID, stage, status)
- Do not ask for human input at any point — this runs unattended
</output_rules>

<error_handling>

| Scenario | Behavior |
|----------|----------|
| No `.teamwork` file | Stop with setup instructions |
| Task list name not found | Warn, continue with matched lists |
| No matching lists at all | Stop with error listing available list names |
| Teamwork API failure | Retry once, then skip ticket and continue |
| Git conflict on branch creation | Append `-2` suffix and retry |
| Lint/test failure after 3 fix attempts | Tag `needs-human`, post failures as Teamwork comment, continue |
| Review failure after 2 fix attempts | Tag `needs-human`, post findings as Teamwork comment, continue |
| Agent crash | Log error, tag ticket `needs-human`, continue with next ticket |

</error_handling>

---

Next: Review tagged tickets in Teamwork or re-run to pick up where you left off.
