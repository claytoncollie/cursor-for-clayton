---
name: Plan Feature
description: Create comprehensive Product Requirements Documents (PRD) for feature planning and execution
author: Clayton Collie
version: 1.0.0
tags: [planning, prd, requirements, wordpress, feature-planning, documentation]
---

# Plan Feature - Product Requirements Document Creator

## Command Purpose

Creates comprehensive Product Requirements Documents (PRD) for features requiring detailed planning. The PRD serves as the source of truth for the `/execute-plan` command and provides a structured breakdown of work.

## Usage

```bash
/plan-feature
```

The command will guide you through an interactive process to create a complete PRD.

## When to Use This Command

Use `/plan-feature` for:
- **Complex features** requiring multiple implementation phases
- **Large projects** with numerous dependencies
- **Features needing detailed task breakdown** before starting work
- **Work requiring stakeholder alignment** before implementation
- **Projects where you need to reference an estimate ticket** for context

**Note:** For simpler features, you may be able to skip the PRD and work directly from an estimate ticket.

## Workflow Integration

**Typical workflow:**
1. Run `/estimate-ticket` to create engineering ticket
2. Paste estimate ticket into Teamwork
3. Get ticket approved
4. Run `/plan-feature` to create detailed PRD (reference the estimate ticket)
5. Run `/execute-plan` to implement tasks from the PRD

## How It Works

This command follows a structured 4-phase workflow to create comprehensive PRDs.

## Phase 1: Requirements Gathering

I'll ask you for:

### Problem Statement
- What problem are we solving?
- What's broken, missing, or inefficient?
- What's the current workaround or situation?

### Users Affected
- Who experiences this problem?
- What user types or roles are involved?
- How many users does this impact?

### Goals
- What do we want to achieve?
- What are the primary objectives?
- What does success look like?

### Non-Goals
- What's explicitly out of scope?
- What aren't we trying to solve?
- What's deferred to future iterations?

### User Stories
- As a [user type], I want to [action] so that [benefit]
- Key workflows and scenarios
- Common and edge-case paths

### Success Criteria
- How will we measure success?
- What metrics matter?
- What qualifies as "done"?

### Constraints
- Technical limitations
- Business constraints
- Time/budget restrictions
- Platform or browser requirements
- Accessibility requirements

### Assumptions
- What are we taking for granted?
- What needs validation?
- What dependencies exist?

### Estimate Ticket Reference
- Link to or ID of the estimate ticket (if available)
- Pull in context from the estimate

## Phase 2: Technical Planning

I'll help you document:

### High-Level Approach
- Overall technical strategy
- Major implementation phases
- Integration with existing systems

### Components to Create/Modify
- New blocks, templates, patterns
- Modified partials or utilities
- Updated post types or taxonomies
- New or changed ACF field groups

### Data Models
- Post types and their fields
- Taxonomies and term structure
- Custom meta fields
- Relationships between entities
- Data sources (APIs, external systems)

### Integration Points
- WordPress hooks and filters
- Block editor integrations
- Third-party services or APIs
- JavaScript libraries or frameworks
- CSS frameworks or utilities

### WordPress-Specific Considerations
- Template hierarchy usage
- Query patterns and performance
- Caching strategies
- Rewrite rules or permalinks
- Roles and capabilities

## Phase 3: Task Breakdown

I'll help you create:

### Detailed Task List with Checkboxes
Organized into logical sections (e.g., Foundation, Core Features, Testing, Documentation)

**Example structure:**
```markdown
### Foundation
- [ ] Register custom post type
- [ ] Create ACF field groups
- [ ] Add taxonomy registrations

### Core Features
- [ ] Build primary block
- [ ] Create template files
- [ ] Implement query logic

### Testing
- [ ] Write unit tests
- [ ] Perform integration testing
- [ ] Manual QA checklist
```

### Dependencies and Ordering
- Which tasks must happen before others?
- What external dependencies exist?
- What can be parallelized?

### Risk Identification
- Technical risks and unknowns
- Complexity hotspots
- Potential blockers
- Mitigation strategies

### Estimate Rollup
- Hours per task or section
- Total estimated effort
- Buffer for unknowns
- Comparison to estimate ticket

## Phase 4: Output

I'll help you create a structured planning document.

### File Structure

```markdown
---
phase: planning
title: [Feature Name]
description: [Brief description]
estimate_ticket: [Link or ID]
created: [Date]
updated: [Date]
---

# [Feature Name] - Planning Document

## Problem Statement
[Description of problem being solved]

## Users Affected
[Who experiences this problem]

## Goals
- Goal 1
- Goal 2

## Non-Goals
- Non-goal 1
- Non-goal 2

## User Stories
- As a [user], I want to [action] so that [benefit]

## Success Criteria
- Criterion 1
- Criterion 2

## Constraints & Assumptions
**Constraints:**
- Constraint 1

**Assumptions:**
- Assumption 1

---

## Technical Planning

### High-Level Approach
[Overall strategy]

### Components to Create/Modify
- Component 1
- Component 2

### Data Models
**Post Types:**
- post-type-name: Description and fields

**Taxonomies:**
- taxonomy-name: Description and usage

**Custom Fields:**
- field-group-name: Field list and purpose

### Integration Points
- Integration 1
- Integration 2

---

## Task Breakdown

### Foundation
- [ ] Task 1
- [ ] Task 2

### Core Features
- [ ] Task 1
- [ ] Task 2

### Testing & QA
- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual QA

### Documentation
- [ ] Update README
- [ ] Document APIs
- [ ] Editor documentation

---

## Dependencies
- Dependency 1: Description
- Dependency 2: Description

## Risks & Mitigation
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Risk 1 | Medium | High | Strategy 1 |

## Estimate Summary
- Foundation: Xh
- Core Features: Yh
- Testing: Zh
- **Total: [Total]h**

---

## Notes & Open Questions
- Note 1
- Question 1 (needs answer by [date])
```

## WordPress Theme-Specific Features

All PRDs include awareness of:

- **Theme Structure** (blocks, templates, patterns, partials, inc/)
- **Post Types & Taxonomies** (custom post types, custom taxonomies)
- **Custom Fields** (ACF field groups, meta boxes)
- **Block Editor Integration** (block registration, InnerBlocks, variations)
- **Template Hierarchy** (WordPress template selection)
- **Query Patterns** (WP_Query, get_posts, pre_get_posts)
- **Hooks & Filters** (actions, filters, WordPress lifecycle)
- **Reusable Components** (partials for cards, metadata, navigation)
- **JavaScript Patterns** (vanilla JS, jQuery if needed, enqueue strategy)
- **CSS Architecture** (utility classes, BEM, responsive patterns)

## Best Practices

### What Makes a Good PRD

✅ **DO:**
- Start with clear problem statement
- Define measurable success criteria
- Break work into logical phases
- Identify dependencies early
- Be realistic about risks
- Reference the estimate ticket for consistency
- Include acceptance criteria from estimate
- Plan for testing and documentation
- Consider edge cases and error states
- Think about rollback and feature flags

❌ **DON'T:**
- Jump straight to tasks without context
- Assume everyone knows the background
- Skip non-goals (scope creep happens here)
- Forget about testing and QA tasks
- Ignore dependencies and blockers
- Over-plan (PRD should guide, not dictate)

### PRD Quality Checklist

Before finalizing, verify:
- [ ] Problem statement is clear and specific
- [ ] Goals are measurable
- [ ] Non-goals prevent scope creep
- [ ] User stories cover main workflows
- [ ] Success criteria are testable
- [ ] Technical approach aligns with estimate ticket
- [ ] Tasks are ordered by dependencies
- [ ] Risks are identified with mitigation
- [ ] Estimate rollup matches task breakdown
- [ ] Open questions are captured

## Example PRD (Abbreviated)

```markdown
---
phase: planning
title: Featured Content Carousel
description: Horizontal carousel for featuring events on landing pages
estimate_ticket: TW-12345
created: 2025-10-31
updated: 2025-10-31
---

# Featured Content Carousel - Planning Document

## Problem Statement

Event landing pages currently display a static grid of events. This limits our ability to highlight specific high-priority events and doesn't create visual hierarchy. Content creators have requested a way to manually feature 5-10 key events at the top of landing pages.

## Users Affected

- **Content Creators** (5 users): Need easy way to curate featured events
- **Site Visitors** (10,000+ monthly): Want to quickly see highlighted events

## Goals

- Allow manual curation of 5-10 featured events
- Create visually engaging carousel component
- Maintain performance (no external dependencies)
- Work across all device sizes

## Non-Goals

- Automatic event prioritization algorithm
- Video support in carousel
- Integration with ticket sales system
- Carousel animation customization by editors

## User Stories

- As a content creator, I want to manually select featured events so that I can highlight high-priority programs
- As a visitor, I want to see featured events immediately so that I don't miss important offerings
- As a mobile user, I want to swipe through events so that I can browse easily on my device

## Success Criteria

- Content creators can select and reorder 5-10 events in under 2 minutes
- Carousel loads in under 1 second on 3G connection
- 100% keyboard accessible
- Works on IE11+ and all modern browsers

## Constraints & Assumptions

**Constraints:**
- Must use existing event card partial
- No external JavaScript libraries
- Must respect existing query filters

**Assumptions:**
- Featured events are manually curated, not algorithmic
- Carousel appears on event landing page template only
- Event post type and fields already exist

---

## Technical Planning

### High-Level Approach

Extend the existing `queried-content` block with a carousel display mode. Leverage existing horizontal scroll patterns and event card markup. Implement with progressive enhancement (works without JS, enhanced with JS).

### Components to Create/Modify

**Modify:**
- `/blocks/queried-content/block.json` - Add carousel display mode
- `/blocks/queried-content/render.php` - Add carousel render logic

**Create:**
- `/blocks/queried-content/carousel-view.php` - Carousel render partial
- `/assets/js/carousel.js` - Arrow navigation and scroll behavior

**Reference:**
- `/partials/featured-laureates-carousel.php` - Carousel markup pattern
- `/partials/cards/event-card.php` - Event card component
- `/assets/js/horizontal-scroll.js` - Scroll utilities

### Data Models

**Post Type:** Event (already exists)
**Required Fields:**
- title
- featured_image
- event_date
- event_category (taxonomy)

No new post types or fields needed.

---

## Task Breakdown

### Foundation (2h BE)
- [ ] Update queried-content block.json with carousel settings
- [ ] Add carousel display mode option to block settings
- [ ] Create carousel-view.php render partial

### Core Features (6h FE)
- [ ] Implement carousel HTML structure (reference laureates carousel)
- [ ] Add CSS for horizontal scroll and card layout
- [ ] Implement left/right arrow navigation
- [ ] Add disabled state for arrows at boundaries
- [ ] Implement smooth scroll behavior
- [ ] Add touch/swipe support for mobile
- [ ] Test responsive behavior (mobile, tablet, desktop)

### Integration (1h)
- [ ] Integrate with existing event-card.php partial
- [ ] Respect event query filters
- [ ] Test in block editor preview

### Testing & QA (2h)
- [ ] Keyboard navigation testing
- [ ] Screen reader testing
- [ ] Cross-browser testing (Chrome, Firefox, Safari, Edge)
- [ ] Mobile device testing (iOS, Android)
- [ ] Performance testing (Lighthouse)

### Documentation (1h)
- [ ] Update block documentation
- [ ] Create editor guide for carousel usage
- [ ] Document code patterns for future carousel implementations

---

## Dependencies

- Event post type exists (already in place)
- Event card partial exists (already in place)
- Horizontal scroll utilities exist (already in place)

## Risks & Mitigation

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Performance on mobile | Low | High | Test early, optimize images, lazy load |
| Accessibility gaps | Medium | High | Test with screen reader, keyboard nav |
| IE11 support issues | Medium | Medium | Progressive enhancement, test in IE11 |

## Estimate Summary

- Foundation: 2h
- Core Features: 6h
- Integration: 1h
- Testing: 2h
- Documentation: 1h
- **Total: 12h** (FE: 10h, BE: 2h)

---

## Notes & Open Questions

- **Q:** Should carousel auto-play?
  **A:** No, auto-play deferred to future iteration

- **Q:** Maximum number of events?
  **A:** 10 events max for performance

- **Note:** Consider adding this pattern to pattern library for reuse
```

## Implementation Notes

When executing this command:

1. **Gather Context Thoroughly**: Don't rush the requirements phase
2. **Reference the Estimate**: Pull in context from the estimate ticket
3. **Think End-to-End**: Include all phases from implementation to documentation
4. **Be Realistic About Tasks**: Break work into manageable, testable chunks
5. **Identify Dependencies Early**: Blockers are easier to resolve when planned for
6. **Plan for Testing**: Don't make testing an afterthought
7. **Document Decisions**: Capture the "why" behind technical choices
8. **Save the File**: Create the planning doc for `/execute-plan` to use

## Related Commands

After creating a PRD:
- Use `/execute-plan` to work through tasks interactively
- Use `/check-implementation` to validate against the plan
- Use `/update-planning` to reconcile progress with the plan

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-10-31  
**Compatible With**: Cursor AI Editor

