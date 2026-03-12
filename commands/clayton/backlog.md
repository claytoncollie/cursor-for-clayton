---
name: Backlog Pipeline
description: Autonomous pipeline that triages a Teamwork backlog, writes PRDs, executes code changes, and reviews PRs
user_invocable: true
---

# Backlog Pipeline

Autonomous pipeline for bulk backlog processing. Point it at Teamwork task lists and it triages, writes PRDs, executes code, and reviews PRs — designed to run overnight unattended.

## Usage

```
/backlog "List Name 1" "List Name 2" ...
```

<process>

## Phase 1: Setup

- Read `.teamwork` file from the project root for `PROJECT_ID`
- If missing, stop: "No `.teamwork` file found. Create one with `PROJECT_ID=<id>`."
- Detect VCS host from `git remote get-url origin` (GitHub → `gh`, GitLab → `glab`)
- Determine base branch from git (usually `trunk`, `main`, or `master`)

## Phase 2: Fetch tickets

- Call `getTaskListsByProjectId` with the project ID
- Match each user-provided list name (case-insensitive) against returned lists
- If a name has no match, warn and continue with the others
- If no names match, stop with an error listing available list names
- For each matched task list, fetch all open tickets
- Deduplicate by ticket ID

## Phase 3: Triage

Use the **Skill tool** to invoke `/clayton/backlog-triage` for each ticket sequentially.

Pass each ticket's ID, title, description, and existing tags. The skill will:
- Classify the ticket as code-solvable (`good-first-issue`) or skip (with reason tag)
- Respect existing pipeline/skip tags — already-processed tickets are skipped
- Update the ticket's tags in Teamwork

Print a triage summary table when complete:

```
| # | Ticket | Title                    | Decision          |
|---|--------|--------------------------|-------------------|
| 1 | 12345  | Fix header overflow       | good-first-issue  |
| 2 | 12346  | Redesign footer           | needs-design      |
...
Tagged: X code-solvable, Y skipped
```

## Phase 4: Parallel ticket workers

For each ticket tagged `good-first-issue` (and not already `prd-written` or beyond), launch a worker using the **Agent tool** with `isolation: "worktree"`.

Each worker agent runs three skills **sequentially** on its ticket:

1. **Skill: `/clayton/backlog-prd`** — Analyze codebase, write engineering PRD, post as Teamwork comment, tag `prd-written`
2. **Skill: `/clayton/backlog-execute`** — Branch, implement, lint, test, open MR/PR, post link to Teamwork, tag `pr-open`
3. **Skill: `/clayton/backlog-review`** — Review diff against requirements, auto-fix or tag `needs-human`, tag `review-passed` if clean

**Worker agent prompt template:**

```
You are a backlog worker processing Teamwork ticket #{ticket_id}: "{title}".
Project ID: {project_id}. VCS: {gh|glab}. Base branch: {base_branch}.

Run these three skills in order using the Skill tool:
1. /clayton/backlog-prd — args: "{ticket_id}"
2. /clayton/backlog-execute — args: "{ticket_id} {base_branch}"
3. /clayton/backlog-review — args: "{ticket_id}"

Stop and tag the ticket `needs-human` if any skill fails after its retry limit.
Report the final state: which skills succeeded and the MR/PR URL if created.
```

Launch agents in parallel — up to 5 concurrent workers. Queue the rest and launch as workers complete.

## Phase 5: Final summary

After all workers finish, print a pipeline summary:

```
### Backlog Pipeline Complete

Triaged: X tickets
  - Code-solvable: Y
  - Skipped: Z (needs-design: A, needs-investigation: B, ...)

PRDs written: N
PRs opened: M
Reviews passed: P
Needs human review: Q

MR/PR Links:
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
</resumability>

<output_rules>
- Print the triage summary table after Phase 3 completes
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
| Agent crash | Log error, tag ticket `needs-human`, continue with next ticket |

</error_handling>
