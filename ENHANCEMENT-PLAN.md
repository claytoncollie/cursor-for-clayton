# Cursor Commands Enhancement Plan

## Overview

This plan modernizes all 11 cursor commands with three primary goals:
1. **Strict output control** - Prevent Cursor from adding unwanted summaries/commentary
2. **Reduce command length** - Target ~150-200 lines max (currently 350-1600+ lines)
3. **Leverage new Cursor features** - Plan Mode, Debug Mode, @context symbols

---

## Priority Actions

### Action 1: Add Strict Output Control Pattern

**Problem:** When commands define specific output formats (like `/estimate-ticket`), Cursor adds preambles ("Here's the ticket...") and summaries ("I've created this for you...").

**Solution:** Add explicit "Output Rules" section to commands that produce formatted output.

**Pattern to add:**

```markdown
## Output Rules

CRITICAL: Follow these output rules exactly.

1. Output ONLY the formatted content specified in this command
2. Do NOT add introductions ("Here's...", "I've prepared...", "Below is...")
3. Do NOT add summaries or wrap-up text after the output
4. Do NOT add meta-commentary about what you produced
5. Do NOT explain what the output contains
6. The formatted output IS your complete response - nothing before, nothing after

The output must be IMMEDIATELY COPY-PASTEABLE without removing surrounding text.
```

**Commands that need this pattern:**
| Command | Produces Formatted Output | Priority |
|---------|--------------------------|----------|
| `/estimate-ticket` | Teamwork ticket markdown | HIGH |
| `/handoff-qa` | QA documentation for Teamwork | HIGH |
| `/execute-plan` | Task status updates, session summaries | HIGH |
| `/plan-feature` | PRD document | MEDIUM |
| `/review-code` | Review summary with findings | MEDIUM |
| `/write-test` | Test code and coverage reports | MEDIUM |
| `/debug-issue` | Issue documentation | LOW |
| `/check-implementation` | Validation summary | LOW |

---

### Action 2: Reduce Command Length

**Problem:** Commands are 350-1600+ lines. Long prompts dilute focus and the AI may not follow all instructions.

**Current Line Counts:**
| Command | Current Lines | Target Lines | Reduction |
|---------|--------------|--------------|-----------|
| `/generate-cursor-rules` | 1600+ | 300 | -81% |
| `/handoff-qa` | 709 | 200 | -72% |
| `/write-test` | 706 | 200 | -72% |
| `/debug-issue` | 616 | 180 | -71% |
| `/review-code` | 605 | 180 | -70% |
| `/execute-plan` | 565 | 180 | -68% |
| `/plan-feature` | 555 | 180 | -68% |
| `/check-implementation` | 458 | 150 | -67% |
| `/estimate-ticket` | 395 | 150 | -62% |
| `/document-project` | 560 | 200 | -64% |
| `/document-file` | 346 | 150 | -57% |

**What to Remove:**

1. **Footer metadata** (all commands)
   - "Command Version: X.X.X"
   - "Last Updated: YYYY-MM-DD"
   - "Compatible With: Cursor AI Editor"
   - Changelog sections

2. **Verbose examples** (most commands)
   - Full example tickets (keep 1 abbreviated example max)
   - Multi-page session transcripts
   - Extensive code samples (reduce to essential patterns)

3. **Redundant checklists** (review-code, write-test, check-implementation)
   - Quality checklists that repeat similar items
   - "Best Practices" DO/DON'T lists (keep only critical items)
   - Pre-flight checklists

4. **"Related Commands" sections** (all commands)
   - Replace with single line: "Related: /command-a, /command-b"

5. **"Next Command" sections** (all commands)
   - These are ~20-30 lines each
   - Replace with: "Next: Run `/next-command` to [brief purpose]"

6. **Workflow Integration sections** (all commands)
   - Redundant across commands
   - Keep only in `/estimate-ticket` as the workflow entry point

7. **WordPress-specific sections** (when redundant)
   - Keep essential patterns
   - Remove exhaustive lists that belong in project rules

**New Lean Structure:**

```markdown
---
name: Command Name
description: One-line description
---

# Command Name

Brief 2-3 sentence purpose statement.

## When to Use
- Scenario 1
- Scenario 2
- Scenario 3

## Process

### Step 1: [Name]
[Concise instructions]

### Step 2: [Name]
[Concise instructions]

[Continue for 4-7 steps max]

## Output Format

[Exact template/format to produce]

## Output Rules

[Strict output control pattern]

---

Next: Run `/next-command` to [purpose].
Related: /related-a, /related-b
```

---

### Action 3: Reference New Cursor Features

**Problem:** Commands don't leverage Cursor 2.0+ capabilities.

**Features to Reference:**

1. **@Context Symbols** (all commands)
   - Add: "Use @codebase to find related patterns"
   - Add: "Use @file to reference specific files"
   - Add: "Use @Git to check recent changes"

2. **Plan Mode** (`/plan-feature`, `/execute-plan`)
   - Reference native Mermaid diagram support
   - Mention interactive Q&A capability
   - Note that complex tasks can spawn to parallel agents

3. **Debug Mode** (`/debug-issue`)
   - Reference Cursor's Debug Mode (v2.2)
   - Mention runtime logging instrumentation
   - Note automatic fix proposals

4. **Specific additions per command:**

| Command | Feature to Reference |
|---------|---------------------|
| `/estimate-ticket` | @codebase for pattern discovery |
| `/plan-feature` | Native Plan Mode, Mermaid diagrams |
| `/execute-plan` | Multi-agent for parallel tasks |
| `/review-code` | @Linter Errors, @Git for diff context |
| `/write-test` | @file for targeting specific files |
| `/debug-issue` | Debug Mode, @Git for recent changes |
| `/check-implementation` | @Git for diff against requirements |
| `/handoff-qa` | @file for linking test locations |
| `/document-file` | @file for the target file |
| `/document-project` | @codebase for discovery |
| `/generate-cursor-rules` | @codebase, @Git for project analysis |

---

## Implementation Order

### Phase 1: High-Impact Output Commands (3 commands)
These produce copy-paste output and need strict control most urgently.

1. `/estimate-ticket` - Most frequently produces formatted output
2. `/handoff-qa` - Direct paste to Teamwork
3. `/execute-plan` - Produces status updates

### Phase 2: Planning & Review Commands (3 commands)
These produce structured documents.

4. `/plan-feature` - PRD output
5. `/review-code` - Review findings
6. `/check-implementation` - Validation results

### Phase 3: Supporting Commands (3 commands)
These are used situationally.

7. `/write-test` - Test generation
8. `/debug-issue` - Debugging workflow
9. `/document-file` - DocBlock generation

### Phase 4: Configuration Commands (2 commands)
These run less frequently.

10. `/document-project` - Project documentation
11. `/generate-cursor-rules` - Rules generation (biggest reduction needed)

---

## Detailed Changes Per Command

### 1. `/estimate-ticket` (Phase 1)

**Current:** 395 lines
**Target:** 150 lines

**Remove:**
- Lines 272-269: Full example ticket (keep abbreviated version)
- Lines 369-396: Footer, changelog, "Next Command" verbose section
- Lines 238-270: Extensive "Best Practices" section (keep 5 key points)
- Lines 218-236: Verbose "WordPress Theme-Specific Features" (condense to list)

**Add:**
- Output Rules pattern after "Phase 4: Output"
- @codebase reference in Phase 2: Analyze Codebase

**Condense:**
- Phase 1-4 descriptions (currently verbose, can be half the length)
- Ticket template (keep structure, reduce explanatory text)

---

### 2. `/handoff-qa` (Phase 1)

**Current:** 709 lines
**Target:** 200 lines

**Remove:**
- Lines 346-606: Massive example handoff document (keep abbreviated)
- Lines 686-709: Footer, "Next Command" section
- Lines 639-673: Verbose best practices
- Lines 608-638: WordPress-specific section (condense)

**Add:**
- Output Rules pattern (critical - this outputs to Teamwork)
- @file references for test file locations

**Condense:**
- Step 1-5 can each be 50% shorter
- Test case format examples (keep 1, not 7)

---

### 3. `/execute-plan` (Phase 1)

**Current:** 565 lines
**Target:** 180 lines

**Remove:**
- Lines 429-529: Full example session transcript
- Lines 543-566: Footer section
- Lines 394-427: Verbose best practices
- Lines 331-367: Extensive output format examples

**Add:**
- Output Rules pattern for status updates
- Reference to multi-agent capability for parallel tasks
- @Git reference for diff tracking

**Condense:**
- Steps 1-8 have too much detail (each could be 40% shorter)
- Communication Guidelines section (keep core points only)

---

### 4. `/plan-feature` (Phase 2)

**Current:** 555 lines
**Target:** 180 lines

**Remove:**
- Lines 345-512: Extended example PRD
- Lines 534-555: Footer section
- Lines 307-343: Verbose best practices

**Add:**
- Reference to Cursor's native Plan Mode
- Native Mermaid diagram capability mention
- Output Rules pattern

**Condense:**
- Phase 1-4 explanations
- PRD template (keep structure, less explanation)

---

### 5. `/review-code` (Phase 2)

**Current:** 605 lines
**Target:** 180 lines

**Remove:**
- Lines 375-457: Extended example findings
- Lines 579-605: Footer section
- Lines 536-568: Verbose best practices
- Lines 459-505: Recommended next steps template (too long)

**Add:**
- @Linter Errors reference
- @Git for diff context
- Output Rules pattern

**Condense:**
- Step 3 file-by-file review (currently 150+ lines of checklists)
- Reduce 8 review categories to essential checks

---

### 6. `/check-implementation` (Phase 2)

**Current:** 458 lines
**Target:** 150 lines

**Remove:**
- Lines 238-301: Extended example findings
- Lines 435-458: Footer section
- Lines 392-425: Verbose best practices

**Add:**
- @Git reference for comparing against requirements
- Output Rules pattern

**Condense:**
- Step 3 file-by-file comparison (reduce checklist verbosity)
- Step 4 summary section

---

### 7. `/write-test` (Phase 3)

**Current:** 706 lines
**Target:** 200 lines

**Remove:**
- Lines 575-632: Extended PHPUnit patterns
- Lines 673-706: Footer section
- Lines 634-671: Verbose best practices
- Lines 122-248: Excessive code examples (keep 1 per category)

**Add:**
- @file reference for targeting test files
- Output Rules pattern

**Condense:**
- Steps 1-7 explanations
- Coverage strategy section
- Manual testing checklists

---

### 8. `/debug-issue` (Phase 3)

**Current:** 616 lines
**Target:** 180 lines

**Remove:**
- Lines 591-616: Footer section
- Lines 545-578: Verbose best practices
- Lines 410-444: Extended issue documentation example

**Add:**
- Reference to Cursor Debug Mode (v2.2)
- @Git for recent changes context
- Output Rules pattern (for issue documentation output)

**Condense:**
- Steps 1-7 (currently very detailed)
- WordPress-specific debugging section

---

### 9. `/document-file` (Phase 3)

**Current:** 346 lines
**Target:** 150 lines

**Remove:**
- Lines 306-346: Footer, changelog
- Lines 171-187: Mermaid diagram (Cursor does this natively)
- Lines 235-270: Extended example execution

**Add:**
- @file reference for the target file
- Output Rules pattern

**Condense:**
- Analysis process phases (currently verbose)
- Documentation principles (reduce examples)

---

### 10. `/document-project` (Phase 4)

**Current:** 560 lines
**Target:** 200 lines

**Remove:**
- Lines 525-560: Footer, changelog
- Lines 252-294: Extended README example
- Lines 336-386: Multiple Mermaid examples (Cursor generates these)

**Add:**
- @codebase reference for discovery
- Output Rules pattern

**Condense:**
- Phase 1-6 descriptions
- Documentation structure examples

---

### 11. `/generate-cursor-rules` (Phase 4)

**Current:** 1600+ lines
**Target:** 300 lines

**This is the largest reduction.**

**Remove:**
- Lines 236-1331: Embedded MDC file templates (over 1000 lines!)
  - These should be generated dynamically, not stored in the command
- Lines 1559-1600: Footer section
- Lines 1351-1408: Implementation notes (redundant)
- Lines 1420-1496: Extended usage session example

**Add:**
- @codebase, @Git references
- Output Rules pattern
- Brief description of what each MDC file contains (not full templates)

**Restructure:**
- Remove embedded templates entirely
- Add instruction: "Generate each MDC file following the patterns discovered in the codebase"
- Keep only the file list and brief descriptions

---

## Future Feature Ideas (For Later Implementation)

These are noted for potential future enhancement:

1. **Notepads Integration**
   - Create a "Project Context" notepad that commands reference
   - Store common project info once, reference everywhere

2. **MCP Server Integration**
   - Direct ticket creation in Linear/Jira/Teamwork
   - Automatic PR creation from `/review-code`

3. **Hooks Integration**
   - Pre-commit hooks that run linting
   - Post-task hooks that update planning docs

4. **Multi-Agent Orchestration**
   - `/execute-plan` spawning parallel agents for independent tasks
   - Background agents for long-running operations

5. **Browser Integration**
   - Visual testing for `/handoff-qa`
   - Screenshot capture for bug reports

---

## Verification Checklist

Before approving this plan, confirm:

- [ ] Output control pattern is acceptable for your workflow
- [ ] Target line counts are reasonable (150-300 lines per command)
- [ ] Removal of footer metadata is acceptable
- [ ] Condensing examples to 1 abbreviated version per command is acceptable
- [ ] Adding @context references is desired
- [ ] Implementation order (Phase 1-4) makes sense for your usage
- [ ] Future feature ideas are captured for later consideration

---

## Estimated Effort

| Phase | Commands | Estimated Changes |
|-------|----------|-------------------|
| Phase 1 | 3 commands | ~1,100 lines removed, patterns added |
| Phase 2 | 3 commands | ~1,000 lines removed, patterns added |
| Phase 3 | 3 commands | ~900 lines removed, patterns added |
| Phase 4 | 2 commands | ~1,500 lines removed (mostly /generate-cursor-rules) |
| **Total** | 11 commands | ~4,500 lines removed, ~200 lines added |

**Net result:** Commands will be approximately 70% smaller on average while being more effective.
