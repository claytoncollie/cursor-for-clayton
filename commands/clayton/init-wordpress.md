---
name: Initialize WordPress
description: Initialize WordPress project with a lean CLAUDE.md and migrate legacy config files
---

# Initialize WordPress Project

Generates a lean CLAUDE.md with only information the agent can't discover on its own. Migrates legacy Cursor config files if present.

<process>

## 1. Check for legacy files

Scan for files that need migration:
- `.cursorrules` in project root
- `.cursor/rules/*.mdc` files

If found, read their contents for migration in step 4.

## 2. Discover project basics

From code, determine:
- **Project name** from `package.json`, `composer.json`, or directory name
- **Type** — theme or plugin (from directory structure)

Confirm findings with the user.

## 3. Ask the user for undiscoverable info

The agent can grep for blocks, post types, build commands, namespaces, etc. It cannot discover:

1. **Environment URLs** — local dev, staging, production
2. **Team workflows** — deployment tool (e.g., Buddy, DeployHQ), branching strategy, PR review process
3. **Tribal knowledge** — conventions not in code (e.g., "use ACF for custom fields", "never modify mu-plugins directly", "CSS changes need design review")

Ask for all three. Skip any the user doesn't have.

## 4. Generate CLAUDE.md

Create a CLAUDE.md in the project root (aim for under 30 lines). Include only what the agent can't find by reading code:

```markdown
# {Project Name}

WordPress {theme|plugin}.

## Environments

- Local: {url}
- Staging: {url}
- Production: {url}

## Team Conventions

- {Deployment workflow}
- {Branching/PR conventions}
- {Any tribal knowledge from step 3}
```

Do NOT include: build commands, block inventories, post types, taxonomies, PHP namespaces, function prefixes, or file structure. The agent discovers these by reading `package.json`, `block.json`, and grepping the codebase.

## 5. Migrate legacy files (if found in step 1)

- **`.cursorrules`**: Extract any environment URLs, team conventions, or tribal knowledge. Merge relevant parts into the CLAUDE.md from step 4. Discard the rest (build commands, code patterns — the agent finds these itself).
- **`.cursor/rules/*.mdc`**: For each file, create a matching folder with a `RULE.md` file (e.g., `.cursor/rules/php-standards/RULE.md`). Copy the content, converting frontmatter from `.mdc` format to standard markdown frontmatter.

Show the user:
- The proposed CLAUDE.md content
- Migration plan for any legacy files (what moves where, what gets discarded)

Apply on confirmation. Delete legacy files after successful migration.

</process>

<output_rules>
- Keep CLAUDE.md under 30 lines — less is more
- Only include information the agent cannot discover from code
- Show diff preview before applying any changes
- No preambles or meta-commentary
</output_rules>

<error_handling>

| Scenario | Behavior |
|----------|----------|
| Not a WordPress project | Error: "No WordPress installation detected. This command is for WordPress projects." |
| No git repository | Warning, continue without git-related features |
| CLAUDE.md already exists | Show proposed changes as a diff against existing content |
| User declines changes | Exit: "No changes made." |

</error_handling>
