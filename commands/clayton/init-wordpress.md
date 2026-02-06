---
name: Initialize WordPress
description: Initialize WordPress project with docs, rules, and CLAUDE.md
---

# Initialize WordPress Project

Single command that initializes a WordPress project for AI-assisted development by generating documentation, Cursor rules, and CLAUDE.md.

Execute these 5 phases in order.

<phase_1_discovery>

Scan the codebase to discover:

**Project Identification:**
- Project name from `package.json`, `composer.json`, or directory name
- Git root location via `git rev-parse --show-toplevel`
- Theme/plugin directory paths

**Tech Stack:**
- PHP version from `composer.json`
- Node version from `.nvmrc` or `package.json` engines
- Build tool: webpack, gulp, 10up-toolkit, vite
- Package manager: npm, yarn, pnpm
- CSS preprocessor: sass, postcss, less
- Testing tools: PHPUnit, Jest, Cypress
- Code quality: PHPCS, ESLint, Stylelint

**WordPress Components:**
- Custom blocks: scan `blocks/`, `includes/blocks/` for `block.json` files
- Custom post types: grep for `register_post_type` calls
- Taxonomies: grep for `register_taxonomy` calls
- Custom fields: detect ACF, Field Manager, or meta boxes

**Naming Conventions:**
- PHP namespace from class files
- Function/constant prefix from `functions.php`
- Block namespace from `block.json` files
- CSS methodology from class naming patterns

**Build Commands:**
- Extract scripts from `package.json`
- Extract scripts from `composer.json`

**Existing Configuration:**
- Check for `docs/` directory and contents
- Check for `.cursor/rules/` directory and contents
- Check for `CLAUDE.md`
- Check for legacy `.mdc` files
- Check for legacy `.cursorrules` file

**Existing Documentation Deep Scan:**
If `docs/` exists, read each markdown file and extract:
- Document title and purpose
- Key content sections and topics covered
- Information that should be preserved or updated
- Outdated information that conflicts with discovered codebase state
- Links that need updating

This content informs Phase 4 edits and rule file links.

</phase_1_discovery>

<phase_2_analysis>

Present findings in this format:

```
Analyzing project...

Project: {name}
Type: WordPress {Theme|Plugin}

Tech Stack:
  - PHP {version}, Node {version}
  - Build: {tool}
  - Quality: {tools}

WordPress Components:
  - {count} custom blocks ({list first 3}...)
  - {count} post types ({slugs})
  - {count} taxonomies ({slugs})
  - Custom fields: {ACF|Field Manager|None}

Conventions:
  - Namespace: {Namespace}\
  - Prefix: {prefix}-
  - CSS: {methodology}

{If fresh project:}
No existing configuration found.

Will create:
  - CLAUDE.md
  - .cursor/rules/ (5 rule folders)
  - docs/ ({count} markdown files)

{If existing setup:}
Existing Configuration:

  docs/ ({count} files)
  - {file} - current, no changes needed
  - {file} - needs update: {specific issue}
  - {file} - will merge new discoveries
  - Missing: {files}

  .cursor/rules/ ({count} folders)
  - {folder}/ - {status}
  - Missing: {folders}

  CLAUDE.md - {status}

  {If legacy files:}
  Legacy files to migrate:
  - {file} -> {destination}

Will:
  - Create {count} new files
  - Modify {count} existing files
  - Delete {count} legacy files
```

</phase_2_analysis>

<phase_3_diff_preview>

For each file that will be created or modified, show unified diff:

```
---
{path} ({new file|modified})
---

{Show unified diff with @@ line markers}
{For new files, show all lines as additions (+)}
{For modifications, show context with -/+ changes}

---
{legacy file} (delete - migrated to {destination})
---

Summary:
  - {count} files modified
  - {count} files created
  - {count} files deleted

Apply changes? [Y/n]
```

Wait for user confirmation before proceeding.

</phase_3_diff_preview>

<phase_4_generation>

After user approves, create files in this order:

**1. CLAUDE.md** (project root)

```markdown
# {Project Name}

{Brief description from discovered info}

## Code Style

- **Namespace**: `{Namespace}\`
- **Prefix**: `{prefix}-` for post types, taxonomies, blocks
- **Constants**: `{PREFIX}_` prefix
- **PHP**: WordPress Coding Standards
- **JS**: Modern vanilla JavaScript, no jQuery
- **CSS**: {methodology}

## Custom Blocks

{count} blocks in `{blocks path}`:
{List blocks as bullet points}

## Post Types

{List post types with slugs}

## Taxonomies

{List taxonomies with slugs}

## Development Commands

```bash
nvm use              # Node {version}
{build command}      # Production build
{watch command}      # Development watch
{lint command}       # PHP linting
```

## Documentation

See [docs/README.md](docs/README.md) for full documentation.
```

**2. .cursor/rules/** (5 folders, each with RULE.md)

| Folder | Frontmatter | Content |
|--------|-------------|---------|
| project-context/ | `alwaysApply: true` | Project structure, tech stack, key components, **full documentation index** |
| development-workflow/ | `alwaysApply: true` | Commands from package.json/composer.json, git workflow, code quality |
| php-standards/ | `globs: *.php` | Namespace, naming conventions, security patterns, performance |
| wordpress-components/ | `globs: blocks/**/*,includes/blocks/**/*,inc/post-types/**/*,inc/taxonomies/**/*` | Blocks list with structure, post types, taxonomies, custom fields |
| frontend-standards/ | `globs: *.js,*.ts,*.jsx,*.tsx,*.scss,*.css` | No jQuery rule, ES6+ patterns, CSS methodology, build process |

**3. docs/** (8-12 markdown files)

| File | Content |
|------|---------|
| README.md | Entry point with navigation |
| project-overview.md | Project context, goals |
| development-workflow.md | Setup, branching, testing, build |
| environments.md | Local, staging, production |
| architecture.md | System design with Mermaid diagrams |
| features.md | Core functionality |
| integrations.md | Third-party services |
| operations.md | Database, caching, troubleshooting |
| api.md | API docs (if applicable) |
| content-types.md | CPTs, taxonomies, fields (WordPress) |
| block-editor.md | Custom blocks, patterns (WordPress) |
| themes.md | Theme structure (WordPress) |

**4. Delete legacy files**

- `.cursor/rules/*.mdc` - content migrated to folder structure
- `.cursorrules` - content merged to CLAUDE.md

</phase_4_generation>

<phase_5_summary>

```
Changes applied successfully.

Created:
  - CLAUDE.md (if new)
  - .cursor/rules/project-context/RULE.md
  - .cursor/rules/development-workflow/RULE.md
  - .cursor/rules/php-standards/RULE.md
  - .cursor/rules/wordpress-components/RULE.md
  - .cursor/rules/frontend-standards/RULE.md
  - docs/{new files only}

Modified:
  - CLAUDE.md (if existed)
  - docs/{existing files updated}
  - .cursor/rules/{existing rules updated}

Deleted:
  - {legacy files} (migrated)

Next steps:
  git add CLAUDE.md .cursor docs
  git commit -m "Initialize WordPress project configuration"
```

</phase_5_summary>

<critical_rules>

**project-context/RULE.md must include a Documentation section:**

```markdown
## Documentation

Reference these docs for detailed context:

- [Project Overview](../../docs/project-overview.md) - {brief description}
- [Architecture](../../docs/architecture.md) - {brief description}
- [Development Workflow](../../docs/development-workflow.md) - {brief description}
- [Content Types](../../docs/content-types.md) - {brief description}
- [Block Editor](../../docs/block-editor.md) - {brief description}
- [Environments](../../docs/environments.md) - {brief description}
{...list ALL docs files that exist or are created}
```

This ensures the AI always knows about and references project documentation.

**Handling existing docs/ files:**

NEVER skip existing `docs/` files. For each file:
1. Read the existing content entirely
2. Compare with discoveries from Phase 1
3. **Preserve** - Keep existing content that is accurate and valuable
4. **Update** - Modify outdated information (versions, counts, file paths)
5. **Merge** - Add new discoveries not yet documented
6. **Remove** - Delete references to components that no longer exist

Show these as modifications in Phase 3 diff preview, not new files. Existing content takes priority.

</critical_rules>

<error_handling>

| Scenario | Behavior |
|----------|----------|
| Not a WordPress project | Error: "No WordPress installation detected. This command is for WordPress projects." |
| No git repository | Warning, continue without git-related features |
| Permission denied | Error with specific file/directory |
| User declines changes | Exit: "No changes made." |

</error_handling>

<output_rules>
- Keep output concise. Avoid verbose explanations.
- Discovery output is informational
- Diff preview is the primary output before changes
- Summary confirms what was done
- No preambles ("Here's what I found...")
- No unnecessary commentary
- Clean, scannable format throughout
</output_rules>

<legacy_migration>
- **`.mdc` files:** Read content, create equivalent folder with RULE.md, delete after approval.
- **`.cursorrules`:** Read content, merge into CLAUDE.md, delete after approval.
</legacy_migration>
