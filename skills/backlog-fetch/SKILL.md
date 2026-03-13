---
name: backlog-fetch
description: Fetches open tickets from specified Teamwork task lists by name or ID.
context: fork
agent: general-purpose
disable-model-invocation: true
user-invocable: false
---

# Backlog Fetch

Fetches open tickets from one or more Teamwork task lists. Accepts list names (quoted strings, case-insensitive match) and/or numeric list IDs. Invoked by the `/backlog` orchestrator — not meant to be run directly.

## Input

Receives task list names and/or IDs as `$ARGUMENTS` and reads `PROJECT_ID` from the `.teamwork` file.

## Process

### 1. Load project config

- Read `.teamwork` file from the project root for `PROJECT_ID`
- If missing, stop with error: "No `.teamwork` file found. Create one with `PROJECT_ID=<id>`."

### 2. Resolve list names/IDs

- Call `getTaskListsByProjectId` with the project ID to get all lists
- For each argument:
  - If numeric: use directly as a list ID (verify it exists in the project)
  - If string: match against list names (case-insensitive)
- Warn for any unmatched names/IDs, continue with matched ones
- If nothing matches, stop with error listing available list names and IDs

### 3. Fetch tickets

- For each matched task list, fetch all tasks using the Teamwork MCP tools
- Filter to open tickets only (skip completed/deleted)
- Deduplicate by ticket ID (tickets may appear in multiple lists)

### 4. Return structured data

For each ticket, extract:
- Ticket ID
- Title
- Description / body
- Existing tags
- Task list name
- Assignee (if any)

## Output

Return the ticket list in a structured format the orchestrator can iterate over:

```
Found {N} open tickets across {M} lists:

| Ticket | Title | List | Tags |
|--------|-------|------|------|
| 12345  | Fix header | Museum Backlog | bug |
| 12346  | Add export | Museum Up Next | feature |
...
```

Rules:
- Only return open, non-deleted tickets
- Deduplicate across lists
- Include all existing tags so downstream agents can check for early exits
