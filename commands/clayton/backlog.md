---
name: Backlog Pipeline
description: Autonomous pipeline that triages a Teamwork backlog, writes PRDs, executes code changes, and reviews MRs
user_invocable: true
---

# Backlog Pipeline

Autonomous pipeline for bulk backlog processing. Point it at Teamwork task lists and it fetches tickets, triages them, writes PRDs, opens MRs, and reviews the results — designed to run overnight unattended.

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

Use the **Skill tool** to invoke `/clayton/backlog-fetch` with the list names as arguments.

The skill returns a structured list of open tickets with their IDs, titles, descriptions, and existing tags.

## Phase 3: Triage

For each ticket returned by the fetch skill, launch a **triage agent** using the **Agent tool**.

Agent prompt template:

```
You are a triage agent. Evaluate Teamwork ticket #{ticket_id} ("{title}") against this project's codebase to determine if it can be solved with a code change.

Ticket description:
{description}

Existing tags: {tags}

Use the Skill tool to invoke /clayton/backlog-triage with args: "{ticket_id}"

Return the classification result.
```

Triage agents can run in parallel. Collect all results and print a summary table:

```
| # | Ticket | Title                    | Decision          |
|---|--------|--------------------------|-------------------|
| 1 | 12345  | Fix header overflow       | good-first-issue  |
| 2 | 12346  | Redesign footer           | needs-design      |
...
Tagged: X code-solvable, Y skipped
```

## Phase 4: Write PRDs

For each ticket tagged `good-first-issue` (and not already `prd-written` or beyond), launch a **PRD agent** using the **Agent tool**.

Agent prompt template:

```
You are a PRD writer agent. Analyze the codebase and write a detailed engineering PRD for Teamwork ticket #{ticket_id} ("{title}").

Ticket description:
{description}

Use the Skill tool to invoke /clayton/backlog-prd with args: "{ticket_id}"

Return the PRD content and confirmation that it was posted to Teamwork.
```

PRD agents can run in parallel. Wait for all to complete before proceeding.

## Phase 5: Execute — write MRs

For each ticket tagged `prd-written` (and not already `pr-open` or beyond), launch an **execute agent** using the **Agent tool** with `isolation: "worktree"`.

Agent prompt template:

```
You are an execution agent. Implement the code changes described in the PRD for Teamwork ticket #{ticket_id} ("{title}").

Project: {project_id}. VCS: {gh|glab}. Base branch: {base_branch}.

Use the Skill tool to invoke /clayton/backlog-execute with args: "{ticket_id} {base_branch}"

Return the MR/PR URL and final status.
```

Execute agents MUST use worktree isolation (one branch per ticket). Run in parallel, up to 5 concurrent. Queue the rest.

## Phase 6: Review MRs

For each ticket tagged `pr-open` (and not already `review-passed`), launch a **review agent** using the **Agent tool**.

Agent prompt template:

```
You are a code review agent. Review the MR/PR for Teamwork ticket #{ticket_id} ("{title}") against the ticket requirements and PRD.

Use the Skill tool to invoke /clayton/backlog-review with args: "{ticket_id}"

Return the review findings and final status.
```

Review agents can run in parallel. Collect all results.

## Phase 7: Final summary

```
### Backlog Pipeline Complete

Triaged: X tickets
  - Code-solvable: Y
  - Skipped: Z (needs-design: A, needs-investigation: B, ...)

PRDs written: N
MRs opened: M
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
- Pick up partially-processed tickets at the next unfinished stage
</resumability>

<output_rules>
- Print the triage summary table after Phase 3
- Print the final pipeline summary after Phase 6
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
