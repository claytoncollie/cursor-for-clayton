---
name: Estimate Ticket
description: Code-aware ticket writer that analyzes codebase patterns before creating Teamwork tickets
---

# Estimate Ticket

Creates Teamwork tickets after analyzing codebase patterns and conventions.

<process>

## Step 1: Gather Context

Ask for:
1. **Feature Description** - What are we building or changing?
2. **Goals** - Why is this needed? What problem does it solve?
3. **Affected Areas** - Blocks, templates, post types, patterns, partials, utilities?
4. **Design Links** - Mockups, Figma files (if available)
5. **Additional Context** - Related tickets, dependencies, constraints

## Step 2: Analyze Codebase

Examine relevant code before writing the ticket:
- **Existing Components** - Blocks, templates, partials that can be reused
- **Naming Conventions** - Block names, CSS classes, function prefixes
- **Similar Implementations** - How comparable features are built
- **Data Patterns** - Post meta, taxonomies, ACF fields, query patterns

## Step 3: Write Ticket

Generate the ticket using the output format below.

## Step 4: Output

Provide:
1. **Brief Summary** (3-5 bullets) highlighting:
   - Existing components identified for reuse
   - New work required
   - Key files to modify/create
2. **Formatted Ticket** - Ready to paste into Teamwork

</process>

<output_format>

```markdown
## Title
[Short, plain English description]

---

## Definition

[2-3 sentences explaining:]
- What the feature/component does
- Why it's needed and what problem it solves
- Which post types, templates, or contexts it relates to

---

## Engineering Approach

[Technical plan covering:]
- What new functionality is being added (block, pattern, template, etc.)
- Where it belongs (post type associations, template placement)
- Which existing components to reuse (specific file paths)
- Data sources and fallback defaults
- What's editable vs automated
- Conditional display logic
- JavaScript behaviors (if any)
- Files to create or modify

**Note:** Provide technical direction without dictating exact implementation.

---

## Acceptance Criteria

- [Specific, testable behavior]
- [Visibility/display conditions]
- [Data source verification]
- [Editor controls work as intended]
- [Responsive behavior]
- [Accessibility requirements]

---

## Estimate

FE: [hours] - UI, styling, JavaScript
BE: [hours] - Data structure, registration, server logic
```

</output_format>

<output_rules>
- Output ONLY the Summary and Formatted Ticket
- Do NOT add introductions ("Here's the ticket...", "I've prepared...")
- Do NOT add explanations after the ticket
- Do NOT add meta-commentary about what you produced
- The formatted output IS your complete response
- The ticket must be IMMEDIATELY COPY-PASTEABLE into Teamwork
</output_rules>

---

Next: Run `/clayton/execute-plan` to work through tasks interactively.
