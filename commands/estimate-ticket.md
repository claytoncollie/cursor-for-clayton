---
name: Estimate Ticket
description: Code-aware ticket writer for Teamwork that analyzes the codebase to create structured engineering tickets
author: Clayton Collie
version: 1.0.0
tags: [planning, estimation, teamwork, wordpress, ticket-writing, codebase-analysis]
---

# Estimate Ticket - Code-Aware Ticket Writer

## Command Purpose

Combines codebase analysis with structured ticket writing for Teamwork. This command examines your WordPress theme codebase to understand existing patterns, components, and conventions before writing detailed engineering tickets.

## Usage

```bash
/estimate-ticket
```

The command will guide you through an interactive process to gather context and produce a ready-to-paste Teamwork ticket.

## How It Works

This command follows a structured 4-phase workflow to ensure all tickets are **code-aware** and aligned with your existing codebase patterns.

## Phase 1: Gather Context

I'll ask you for:

1. **Feature Description**: What are we building or changing?
2. **Goals**: Why is this needed now? What problem does it solve?
3. **Affected Areas**: Which parts of the codebase are involved?
   - Blocks (Gutenberg blocks)
   - Templates (page templates, template parts)
   - Post types (event, podcast, initiative, etc.)
   - Patterns (block patterns)
   - Partials (reusable PHP components)
   - Utilities (helper functions, classes)
4. **Relevant File Paths**: Any specific files or patterns to reference
5. **Design Links**: Mockups, Figma files, or design specifications (if available)
6. **Additional Context**: Related tickets, dependencies, or constraints

## Phase 2: Analyze Codebase

Before writing the ticket, I'll examine the relevant codebase to understand:

### Existing Components
- Review block files to understand structure and registration patterns
- Check template files for layout conventions
- Identify partials that can be reused
- Review post type registrations and custom fields
- Understand taxonomy usage and relationships

### Naming Conventions
- Block naming patterns (e.g., `acf/block-name`)
- CSS class conventions (BEM, utility classes)
- Function and variable naming standards
- File organization patterns

### Existing Patterns
- How similar features are currently implemented
- Reusable utilities and helper functions
- Common markup structures and components
- Block editor patterns and behaviors

### Architectural Understanding
- Relationships between components
- Data flow (post meta, taxonomies, ACF fields)
- Conditional logic patterns
- JavaScript behavior patterns

## Phase 3: Write Structured Ticket

I'll generate a comprehensive ticket following this template:

### Title
Short, descriptive, plain English description of what's being built or changed.

*Example: "Add Featured Content Carousel to Event Landing Pages"*

---

### Definition

**Purpose and Context:**
- What the feature/component does
- Why this feature is needed now
- What problem it solves for users or editors
- Which specific post types, templates, or use cases it relates to
- How it fits into the larger system

**Clarity Guidelines:**
- Be specific about the user or editor benefit
- Provide context for why this work is prioritized
- Reference related features or dependencies

---

### Engineering Approach

**This is the most critical section.** It provides a detailed technical plan that:

1. **Defines New Functionality**
   - What new functionality is being added
   - Whether it's a block, pattern, template, or adjustment
   - Specific capabilities and behaviors

2. **Specifies Location**
   - Where this functionality belongs
   - Post type associations
   - Template placement
   - Pattern slug or identifier

3. **References Design System**
   - Which existing markup/components to reuse (e.g., `event-data.php`, `block-separator.php`)
   - How this relates to established patterns
   - CSS utilities and classes to apply

4. **Data Strategy**
   - Dynamic data sources (post meta, taxonomies, custom fields)
   - Fallback defaults
   - Data validation requirements

5. **Editorial Experience**
   - What's editable by content creators
   - What's automated/programmatic
   - Editor controls and options

6. **Conditional Logic**
   - When/where features display
   - Post type specific behaviors
   - Visibility rules

7. **JavaScript Behavior**
   - Interactive features
   - Scroll behaviors
   - Dynamic updates

8. **Visual Implementation**
   - Background styles and constraints
   - Layout specifications
   - Alignment rules
   - Responsive behavior

9. **File Impact**
   - Whether this updates existing files
   - New files to create
   - Partials to extend or reuse

**Important:** Avoid suggesting exact code implementations to allow engineer flexibility.

---

### Acceptance Criteria

Clear, testable checkboxes representing QA-checkable requirements:

- [ ] **Behavior**: Specific behavior or display expectation
- [ ] **Visibility**: When and where feature appears
- [ ] **Data Source**: Correct data is pulled and displayed
- [ ] **Editor Control**: Content creators can modify as intended
- [ ] **Responsive**: Works across device sizes
- [ ] **JavaScript**: Interactive elements function correctly
- [ ] **Performance**: Loads efficiently
- [ ] **Accessibility**: Keyboard navigation and screen readers work

**Criteria Guidelines:**
- Each item should be independently testable
- Use concrete, measurable language
- Avoid vague phrases like "should work" or "matches design"
- Include edge cases and error states

---

### Estimate

Break down the work into Front-End and Back-End hours:

```
FE: [hours] - UI implementation, styling, JavaScript
BE: [hours] - Data structure, registration, server logic
```

**Estimation Guidelines:**
- FE: Templates, CSS, JavaScript, block editor interfaces
- BE: Post type/taxonomy registration, meta fields, data queries
- Include time for testing and refinement

## Phase 4: Output

I'll present the formatted ticket with:

### Summary
A concise overview highlighting:
- **Existing components identified for reuse**
  - Partials that can be leveraged
  - Utilities already available
  - Similar patterns to follow
  
- **New work required**
  - Components to create
  - New functionality to implement
  - Features without existing precedent

- **Files that will be modified/created**
  - Specific file paths
  - Type of change (new, modified, extended)

- **Patterns to follow**
  - Code conventions to maintain
  - Similar implementations to reference
  - Architectural guidelines

### Formatted Ticket
Ready to copy and paste directly into Teamwork.

## WordPress Theme-Specific Features

All tickets include awareness of:

- **WordPress Coding Standards** (PHPCS, WPCS)
- **Theme Structure**
  - `/blocks/` - Gutenberg block registration
  - `/patterns/` - Block patterns
  - `/templates/` - Page templates and template parts
  - `/partials/` - Reusable PHP components
  - `/inc/` - Functions and utilities
  - `/assets/` - CSS, JS, images
- **Post Types & Taxonomies** (custom post types, terms, hierarchies)
- **Custom Fields** (ACF, meta boxes)
- **Block Editor Patterns** (InnerBlocks, block variations, block styles)
- **Reusable Components** (partials for cards, metadata, separators)
- **WP Hooks, Filters, Actions** (theme setup, enqueue scripts)
- **Template Hierarchy** (WordPress template selection logic)
- **Query Patterns** (WP_Query, get_posts, tax_query)

## Best Practices

### What Makes a Good Ticket

✅ **DO:**
- Review relevant codebase files before writing
- Reference existing partials and utilities by name
- Use specific file paths and component names
- Follow established naming conventions
- Identify reusable vs. new work clearly
- Write testable acceptance criteria
- Respect post type associations
- Consider responsive and accessible design

❌ **DON'T:**
- Suggest exact code implementations
- Create new abstractions unnecessarily
- Ignore existing patterns and conventions
- Write vague acceptance criteria
- Forget edge cases and error states
- Assume knowledge not in the codebase

### Ticket Quality Checklist

Before finalizing, verify:
- [ ] Title is clear and describes the work
- [ ] Definition explains WHY, not just WHAT
- [ ] Engineering approach references specific existing files
- [ ] New components are clearly distinguished from existing ones
- [ ] Acceptance criteria are independently testable
- [ ] Estimates include both FE and BE work
- [ ] Post types and contexts are specified
- [ ] Reusable components are identified

## Example Ticket Structure

```markdown
## Title
Add Featured Content Carousel to Event Landing Pages

---

## Definition

This block displays 5-10 featured Events in a horizontal carousel with left/right navigation. It will be used on event landing pages to highlight upcoming events and drive registrations. Content creators need to be able to manually curate the featured events or allow automatic selection based on recency.

**Affected Post Types:** Event
**Affected Templates:** `template-event-landing.php`

---

## Engineering Approach

Extend the existing `queried-content` block (see `/blocks/queried-content/`) to add a "Display as carousel" layout option. Use the carousel markup structure from `/partials/featured-laureates-carousel.php` as the base pattern.

**Block Behavior:**
- Add "Carousel" display mode to block settings
- Allow selection of 5-10 Event posts
- Support both manual post selection and automatic (query-based)
- Display in horizontal scroll container

**Card Components:**
Each event card should use the existing event card partial (`/partials/cards/event-card.php`) and include:
- Featured image (with fallback)
- Event title
- Event category (primary term)
- Event date
- "Learn More" CTA linking to event

**Navigation:**
- Use the arrow markup from `/partials/block-separator.php` for left/right controls
- Disable left arrow at start of carousel
- Disable right arrow at end of carousel
- Implement smooth scroll behavior (reference `/assets/js/horizontal-scroll.js`)

**Layout:**
- Follow existing `horizontal-scroll` CSS utility pattern
- Snap to card boundaries on scroll
- Maintain consistent card width across breakpoints
- Show partial next card to indicate scrollability

**Data:**
- Query events using existing event query utility (`/inc/queries/event-queries.php`)
- Respect event visibility and publish status
- Allow override of title, excerpt, image, and link per card slot (optional)

**Files to Create/Modify:**
- Modify: `/blocks/queried-content/block.json` (add carousel display mode)
- Modify: `/blocks/queried-content/render.php` (conditional carousel markup)
- Create: `/blocks/queried-content/carousel-view.php` (carousel-specific render partial)
- Reference: `/partials/featured-laureates-carousel.php` (markup pattern)
- Reference: `/assets/js/horizontal-scroll.js` (scroll behavior)

---

## Acceptance Criteria

- Block settings include "Carousel" display mode option
- Editor can select 5-10 Event posts manually or via query
- Cards display featured image, title, category, date, and CTA
- Cards use existing event card partial markup
- Left/right arrows appear and function correctly
- Arrows disable appropriately at carousel boundaries
- Smooth scroll snaps to card boundaries
- Carousel works on mobile (touch swipe) and desktop (arrows + drag)
- Respects existing event query filters (published, visible)
- Renders correctly in block editor preview
- Works across all breakpoints (mobile, tablet, desktop)
- Keyboard navigation works (tab to arrows, arrow keys to scroll)

---

## Estimate

- FE: 6h
- BE: 1h
```

## Implementation Notes

When executing this command:

1. **Start with Questions**: Gather all necessary context before analyzing code
2. **Read Strategically**: Focus on relevant files based on affected areas
3. **Identify Reuse**: Actively look for existing components to leverage
4. **Respect Conventions**: Mirror naming patterns and architectural decisions
5. **Be Specific**: Use actual file paths and component names from the codebase
6. **Avoid Over-Prescription**: Provide technical direction without dictating exact implementation
7. **Think Like QA**: Write acceptance criteria that are independently testable
8. **Consider the Editor**: Remember content creators will use this, not just developers

## Related Commands

After creating an estimate ticket:
- Use `/plan-feature` to create a detailed PRD for larger features
- Use `/execute-plan` to implement the planned work
- Use `/check-implementation` to validate against the ticket

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-10-31  
**Compatible With**: Cursor AI Editor

