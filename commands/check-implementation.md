---
name: Check Implementation
description: Implementation validator that compares code against PRD and estimate ticket
author: Clayton Collie
version: 1.0.0
tags: [validation, quality-assurance, implementation, wordpress, code-review]
---

# Check Implementation - Implementation Validator

## Command Purpose

Compares your current implementation against the design doc (PRD) and estimate ticket to ensure the code matches the planned approach and satisfies requirements.

## Usage

```bash
/check-implementation
```

The command will perform a structured review of your implementation.

## When to Use This Command

Use `/check-implementation` for:
- **After completing major features** to validate against plan
- **Before code review** to catch deviations early
- **During implementation** to verify alignment with design
- **After refactoring** to ensure requirements still met
- **Before QA handoff** to confirm acceptance criteria

## Workflow Integration

**Typical workflow:**
1. Complete implementation with `/execute-plan`
2. **Run `/check-implementation`** to validate
3. Fix any gaps or deviations found
4. Run `/writing-test` to add tests
5. Run `/code-review` before pushing

## How It Works

This command follows a structured 4-step validation workflow.

## Step 1: Gather Context

I'll ask you for:

### Feature Information
1. **Feature/Branch Description**: Brief summary of what was built
2. **Modified Files**: List of files created or changed
   - New files
   - Modified files
   - Deleted files
3. **Relevant Docs**: Paths to validation sources
   - Design/architecture documents
   - Requirements documents
   - Planning documents
   - Estimate ticket (Teamwork link or ID)
4. **Known Constraints**: Any limitations or assumptions
5. **Implementation Notes**: Decisions made, deviations, concerns

### Diff Information
Request git diff to see what changed:
```bash
git status -sb
git diff --stat
git diff [files]
```

## Step 2: Understand Design Intent

For each provided doc, I'll summarize:

### Design Doc Analysis
- **Architectural decisions**: Key technical choices made during design
- **Component structure**: Expected components and their relationships
- **Data models**: Post types, taxonomies, fields, data flow
- **Integration points**: APIs, hooks, external systems
- **Critical constraints**: Performance, security, accessibility requirements
- **Patterns to follow**: Existing code patterns to mirror

### Requirements Doc Analysis
- **Core requirements**: Must-have functionality
- **User stories**: Expected user interactions
- **Success criteria**: Measurable outcomes
- **Edge cases**: Boundary conditions and error handling
- **Non-functional requirements**: Performance, accessibility, security

### Estimate Ticket Analysis
- **Acceptance criteria**: QA-testable checkboxes
- **Engineering approach**: Technical implementation plan
- **Data sources**: Expected data flows
- **Files mentioned**: Components to create/modify
- **Reusable components**: Existing patterns to leverage

## Step 3: File-by-File Comparison

For every modified file, I'll review:

### Design Alignment
**Check against design doc:**
- [ ] Follows architectural decisions?
- [ ] Implements expected components?
- [ ] Uses correct data models?
- [ ] Integrates at proper points?
- [ ] Respects critical constraints?
- [ ] Follows established patterns?

**Identify deviations:**
- Does implementation match design intent?
- Are there unexplained divergences?
- Are deviations improvements or regressions?
- Should design doc be updated to reflect reality?

### Requirements Alignment
**Check against requirements:**
- [ ] Implements all core requirements?
- [ ] Satisfies user stories?
- [ ] Meets success criteria?
- [ ] Handles edge cases?
- [ ] Meets non-functional requirements?

**Identify gaps:**
- Missing functionality?
- Incomplete user flows?
- Unhandled edge cases?
- Performance concerns?
- Accessibility gaps?

### Acceptance Criteria Validation
**Check against estimate ticket:**
- [ ] Each acceptance criterion met?
- [ ] Behavior matches expectations?
- [ ] Data flows as designed?
- [ ] Editor controls work as specified?
- [ ] Responsive behavior correct?
- [ ] JavaScript interactions functional?

### Code Quality Review
**Logic and Flow:**
- [ ] Logic is clear and correct?
- [ ] Edge cases handled?
- [ ] Error handling appropriate?
- [ ] No obvious bugs?

**Code Organization:**
- [ ] Code structure is logical?
- [ ] Functions are single-purpose?
- [ ] No duplicate code?
- [ ] Follows WordPress coding standards?

**WordPress Patterns:**
- [ ] Uses correct hooks/filters?
- [ ] Follows template hierarchy?
- [ ] Queries are optimized?
- [ ] Proper data sanitization?
- [ ] Security best practices followed?

**Performance:**
- [ ] No N+1 queries?
- [ ] Appropriate caching?
- [ ] Efficient algorithms?
- [ ] Assets optimized?

**Security:**
- [ ] Input validation present?
- [ ] Output escaping correct?
- [ ] Nonce verification for forms?
- [ ] Capability checks for admin?
- [ ] SQL queries prepared/escaped?

**Accessibility:**
- [ ] Semantic HTML?
- [ ] ARIA labels where needed?
- [ ] Keyboard navigation works?
- [ ] Color contrast sufficient?
- [ ] Screen reader friendly?

### Simplification Opportunities
- Redundant code to remove?
- Complex logic to simplify?
- Better abstractions possible?
- Existing utilities to leverage?

### Missing Elements
- Required comments/documentation?
- Unit/integration tests?
- Error logging?
- Admin documentation?

## Step 4: Summarize Findings

I'll provide structured results:

### Summary

```markdown
### Implementation Validation Summary

**Overall Status:** [Ready for Review / Needs Revision / Major Issues]

**Issues Found:**
- Blocking: [count] - Must fix before proceeding
- Important: [count] - Should fix soon
- Nice-to-have: [count] - Consider for improvement

**Acceptance Criteria:** [X of Y] met ([%])
```

### Detailed Notes

For each finding:

```markdown
### 1. [File or Component Name]

**Issue/Observation:**
[Description of the finding]

**Impact:** [Blocking / Important / Nice-to-have]

**Expected (from design/requirements):**
[What the docs specify]

**Actual (in implementation):**
[What the code does]

**Recommendation:**
[Specific action to take]

**Design Reference:**
[Link to relevant section of design/requirements doc]
```

### Examples

```markdown
### 1. blocks/queried-content/carousel-view.php

**Issue:** Missing keyboard navigation support

**Impact:** Blocking (accessibility requirement)

**Expected:**
Estimate ticket AC: "Keyboard navigation works (tab to arrows, arrow keys to scroll)"

**Actual:**
Carousel has arrow buttons but no keyboard event listeners

**Recommendation:**
Add keyboard event listeners in carousel.js:
- Arrow keys for scrolling
- Tab navigation to arrow buttons
- Focus indicators on active card

**Design Reference:**
Design doc § Accessibility Requirements
```

```markdown
### 2. assets/js/carousel.js

**Issue:** Using existing horizontal-scroll utility incorrectly

**Impact:** Important (code quality, maintainability)

**Expected:**
Design specifies: "Reference /assets/js/horizontal-scroll.js for scroll behavior"

**Actual:**
Custom scroll implementation that duplicates existing utility

**Recommendation:**
Import and use existing horizontalScroll() function from horizontal-scroll.js
Remove duplicate code

**Design Reference:**
Estimate ticket § Engineering Approach: "Reference /assets/js/horizontal-scroll.js"
```

```markdown
### 3. blocks/queried-content/render.php

**Issue:** Excellent reuse of existing patterns

**Impact:** Positive (no action needed)

**Expected:**
Use event-card.php partial for card rendering

**Actual:**
Correctly uses get_template_part('partials/cards/event-card') 
Follows established pattern from other blocks

**Recommendation:**
None - implementation matches design perfectly

**Design Reference:**
Estimate ticket § Engineering Approach: "Cards should use existing event card partial"
```

### Recommended Next Steps

```markdown
### Recommended Next Steps

#### Blocking Issues (Must Fix)
- [ ] Add keyboard navigation to carousel
- [ ] Implement screen reader labels
- [ ] Add nonce verification to AJAX handler

#### Important Follow-Ups (Should Fix)
- [ ] Refactor to use horizontal-scroll.js utility
- [ ] Add error handling for failed queries
- [ ] Optimize carousel images (lazy loading)

#### Documentation Updates
- [ ] Update design doc to reflect lazy loading decision
- [ ] Add inline comments for complex scroll logic
- [ ] Update implementation doc with keyboard nav patterns

#### Testing Required
**Unit Tests:**
- [ ] Test carousel initialization
- [ ] Test arrow disable logic
- [ ] Test scroll position calculation

**Integration Tests:**
- [ ] Test with 5, 8, and 10 events
- [ ] Test empty state (0 events)
- [ ] Test with missing images

**Manual Testing:**
- [ ] Keyboard navigation
- [ ] Screen reader (VoiceOver, NVDA)
- [ ] Cross-browser (Chrome, Firefox, Safari, Edge)
- [ ] Mobile (iOS, Android touch interactions)

#### Before Next Steps
- [ ] Fix blocking issues
- [ ] Run `/writing-test` to generate test cases
- [ ] Re-run `/check-implementation` after fixes
- [ ] Run `/code-review` when ready
```

## WordPress Theme-Specific Validation

I'll specifically check for:

### Theme Structure
- [ ] Files in correct directories?
- [ ] Naming conventions followed?
- [ ] Template hierarchy respected?

### WordPress Standards
- [ ] PHPCS/WPCS compliant?
- [ ] Proper indentation and spacing?
- [ ] DocBlocks present and accurate?

### Block Patterns
- [ ] block.json properly configured?
- [ ] Render callback correct?
- [ ] Block attributes validated?
- [ ] Editor styles included?

### Query Optimization
- [ ] WP_Query efficient?
- [ ] No uncached expensive queries?
- [ ] Transients used appropriately?
- [ ] Post queries limited reasonably?

### Security
- [ ] Data sanitized on input?
- [ ] Data escaped on output?
- [ ] Nonces verified?
- [ ] Capabilities checked?
- [ ] SQL prepared properly?

### Performance
- [ ] Scripts enqueued properly?
- [ ] Conditional loading where possible?
- [ ] Images optimized?
- [ ] No blocking resources?

### Accessibility
- [ ] Semantic HTML elements?
- [ ] ARIA labels where needed?
- [ ] Focus management correct?
- [ ] Keyboard accessible?

## Best Practices

### What Makes Good Validation

✅ **DO:**
- Check every modified file
- Compare against all available docs
- Test each acceptance criterion
- Identify both problems and wins
- Provide specific recommendations
- Reference exact doc sections
- Note positive patterns too

❌ **DON'T:**
- Skip files (check everything)
- Only look for problems (acknowledge good work)
- Give vague feedback ("looks good")
- Ignore edge cases
- Skip security/accessibility checks
- Forget to check tests

### Validation Quality Checklist

Before finishing validation:
- [ ] All modified files reviewed
- [ ] Design alignment checked
- [ ] Requirements coverage verified
- [ ] Acceptance criteria tested
- [ ] Code quality assessed
- [ ] Security validated
- [ ] Performance considered
- [ ] Accessibility checked
- [ ] Tests identified
- [ ] Recommendations provided

## Related Commands

After validation:
- Use `/writing-test` to add missing tests
- Use `/debug` if issues are found
- Use `/code-review` for final pre-push review
- Use `/update-planning` to document deviations

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-10-31  
**Compatible With**: Cursor AI Editor

