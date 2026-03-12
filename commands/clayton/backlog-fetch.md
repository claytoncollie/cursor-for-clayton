---
name: Backlog Fetch
description: Skill that fetches open tickets from specified Teamwork task lists
---

# Backlog Fetch

Fetches open tickets from one or more Teamwork task lists by name. Invoked by the `/backlog` orchestrator — not meant to be run directly.

## Input

Receives task list names as arguments and reads `PROJECT_ID` from the `.teamwork` file.

<process>

## 1. Load project config

- Read `.teamwork` file from the project root for `PROJECT_ID`
- If missing, stop with error

## 2. Resolve list names to IDs

- Call `getTaskListsByProjectId` with the project ID
- Match each provided list name (case-insensitive) against returned lists
- Warn for any unmatched names, continue with matched ones
- If no names match, stop with error listing available list names

## 3. Fetch tickets

- For each matched task list, fetch all tasks using the Teamwork MCP tools
- Filter to open tickets only (skip completed/deleted)
- Deduplicate by ticket ID (tickets may appear in multiple lists)

## 4. Return structured data

For each ticket, extract:
- Ticket ID
- Title
- Description / body
- Existing tags
- Task list name
- Assignee (if any)

</process>

<output_format>
Return the ticket list in a structured format the orchestrator can iterate over:

```
Found {N} open tickets across {M} lists:

| Ticket | Title | List | Tags |
|--------|-------|------|------|
| 12345  | Fix header | Museum Backlog | bug |
| 12346  | Add export | Museum Up Next | feature |
...
```
</output_format>

<output_rules>
- Only return open, non-deleted tickets
- Deduplicate across lists
- Include all existing tags so downstream agents can check for early exits
</output_rules>
