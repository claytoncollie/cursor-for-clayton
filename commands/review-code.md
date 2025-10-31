---
name: Review Code
description: Local pre-push code review assistant for WordPress theme development
author: Clayton Collie
version: 1.0.0
tags: [code-review, quality-assurance, wordpress, pre-push, validation]
---

# Review Code - Pre-Push Review Assistant

## Command Purpose

Helps you perform a thorough local code review **before** pushing changes. Catches issues early, validates against design docs, and ensures code quality standards are met.

## Usage

```bash
/review-code
```

The command will guide you through a structured code review process.

## When to Use This Command

Use `/review-code` for:
- **Before pushing to remote** to catch issues early
- **After completing features** to ensure quality
- **Before creating PRs** to streamline team review
- **After major refactoring** to verify nothing broke
- **Before QA handoff** to reduce back-and-forth

## Workflow Integration

**Typical workflow:**
1. Complete implementation with `/execute-plan`
2. Validate with `/check-implementation`
3. Add tests with `/write-test`
4. **Run `/review-code`** before pushing
5. Fix any issues found
6. Re-run `/review-code` after fixes
7. Push with confidence

## How It Works

This command follows a structured 6-step review workflow.

## Step 1: Gather Context

I'll ask you for:

### Feature Information
1. **Brief Feature/Branch Description**
   - What was built or changed?
   - Why was this work done?
   - What issue or ticket does it address?

2. **List of Modified Files**
   - New files created
   - Existing files modified
   - Files deleted
   - Optional: Brief summary per file

3. **Relevant Documentation**
   - Design/architecture documents
   - Requirements documents
   - Planning documents
   - Estimate ticket (Teamwork link or ID)
   - Any project-level design docs

4. **Known Constraints or Risky Areas**
   - Complex logic to review carefully
   - Performance-critical sections
   - Security-sensitive code
   - Known technical debt

5. **Open Bugs or TODOs**
   - Linked issues
   - TODOs in code
   - Known limitations
   - Deferred work

6. **Testing Status**
   - Which tests have been run?
   - Test results and coverage
   - Manual testing completed?

### Git Information

Request git diff:
```bash
git status -sb
git diff --stat
git diff [files]
```

## Step 2: Understand Design Alignment

I'll review provided documentation:

### Design Doc Summary

For each design doc:
- **Architectural intent**: Key technical decisions
- **Critical requirements**: Must-have functionality
- **Patterns**: Code conventions to follow
- **Constraints**: Performance, security, accessibility
- **Integration points**: APIs, hooks, dependencies

**Example:**
```markdown
### Design Intent: Featured Carousel

**Architecture:** Extend queried-content block, leverage existing carousel patterns
**Key Decisions:** No external JS libraries, progressive enhancement
**Constraints:** 10 event limit, keyboard accessible, IE11+ support
**Patterns:** Use horizontal-scroll.js, event-card.php partial
**Integration:** WP_Query for events, block editor controls
```

### Requirements Validation

- Core requirements to verify
- Acceptance criteria from estimate
- Edge cases to test
- Non-functional requirements (performance, a11y)

## Step 3: File-by-File Review

For every modified file, I'll check:

### 1. Design & Requirements Alignment

**Check:**
- [ ] Implements documented requirements?
- [ ] Follows design decisions?
- [ ] Uses specified patterns?
- [ ] Meets acceptance criteria?
- [ ] Handles documented edge cases?

**Deviations:**
- Identify unexplained divergences
- Assess if deviation is improvement or issue
- Note if docs need updating

### 2. Logic & Flow Issues

**Check:**
- [ ] Logic is correct and clear?
- [ ] Control flow makes sense?
- [ ] Conditions are accurate?
- [ ] No off-by-one errors?
- [ ] No infinite loops?
- [ ] No race conditions?

**Edge Cases:**
- [ ] Handles empty/null/zero?
- [ ] Handles maximum values?
- [ ] Handles unexpected input?
- [ ] Handles error states?

### 3. Code Quality

**Duplication:**
- [ ] No copy-pasted code?
- [ ] No redundant logic?
- [ ] Existing utilities used?
- [ ] Opportunities to extract functions?

**Simplification:**
- [ ] Code is as simple as possible?
- [ ] Complex logic explained?
- [ ] Unnecessary abstractions removed?
- [ ] Clear variable names?

**WordPress Standards:**
- [ ] Follows PHPCS/WPCS?
- [ ] Proper indentation?
- [ ] Correct naming conventions?
- [ ] DocBlocks present?
- [ ] Inline comments for complex logic?

### 4. Security Review

**Input Validation:**
- [ ] User input validated?
- [ ] Type checking present?
- [ ] Range/length limits enforced?
- [ ] Malicious input rejected?

**Output Escaping:**
- [ ] All output escaped (esc_html, esc_attr)?
- [ ] URLs escaped (esc_url)?
- [ ] JavaScript escaped (esc_js)?
- [ ] SQL escaped (prepare, wpdb->prepare)?

**Authentication & Authorization:**
- [ ] Nonces verified for forms?
- [ ] Capability checks for admin?
- [ ] AJAX actions secured?
- [ ] User permissions validated?

**WordPress Security:**
- [ ] No direct SQL queries?
- [ ] Using wpdb->prepare()?
- [ ] No eval() or create_function()?
- [ ] File uploads validated?
- [ ] Sensitive data not exposed?

### 5. Performance Review

**Database Queries:**
- [ ] No N+1 query problems?
- [ ] Queries using indexes?
- [ ] Appropriate LIMIT clauses?
- [ ] Transients/caching used?
- [ ] No queries in loops?

**Code Efficiency:**
- [ ] Efficient algorithms used?
- [ ] No unnecessary operations?
- [ ] Large loops optimized?
- [ ] Heavy operations cached?

**Asset Loading:**
- [ ] Scripts/styles enqueued properly?
- [ ] Only loaded when needed?
- [ ] Dependencies declared?
- [ ] Minified in production?

**WordPress Performance:**
- [ ] Using get_posts() vs WP_Query appropriately?
- [ ] Object caching leveraged?
- [ ] Avoiding expensive operations in hooks?
- [ ] Rewrite rules efficient?

### 6. Accessibility Review

**Semantic HTML:**
- [ ] Correct HTML elements used?
- [ ] Heading hierarchy logical?
- [ ] Lists for list content?
- [ ] Buttons vs links appropriate?

**ARIA & Labels:**
- [ ] ARIA labels where needed?
- [ ] Form labels associated?
- [ ] Screen reader text provided?
- [ ] Live regions for dynamic updates?

**Keyboard Navigation:**
- [ ] All interactive elements keyboard accessible?
- [ ] Tab order logical?
- [ ] Focus visible?
- [ ] Keyboard shortcuts work?

**Visual Accessibility:**
- [ ] Sufficient color contrast?
- [ ] No color-only information?
- [ ] Text resizable?
- [ ] No flashing content?

### 7. Error Handling & Logging

**Error Handling:**
- [ ] Try-catch where appropriate?
- [ ] Error messages helpful?
- [ ] Failures handled gracefully?
- [ ] Fallbacks provided?

**Logging:**
- [ ] Important actions logged?
- [ ] Errors logged appropriately?
- [ ] No sensitive data in logs?
- [ ] Log level appropriate?

### 8. Testing & Documentation

**Tests:**
- [ ] Unit tests cover new logic?
- [ ] Integration tests for features?
- [ ] Edge cases tested?
- [ ] Tests actually pass?

**Documentation:**
- [ ] DocBlocks updated?
- [ ] Complex logic commented?
- [ ] TODOs have owners/dates?
- [ ] README updated if needed?

## Step 4: Cross-Cutting Concerns

Beyond individual files:

### Naming Consistency
- [ ] File names follow conventions?
- [ ] Function names consistent?
- [ ] Variable names clear?
- [ ] Class names appropriate?

### Documentation Updates
- [ ] Docs reflect code changes?
- [ ] Comments updated?
- [ ] APIs documented?
- [ ] Examples provided?

### Test Coverage
- [ ] All new functionality tested?
- [ ] Modified code retested?
- [ ] Integration tests updated?
- [ ] Manual test cases documented?

### Configuration & Migration
- [ ] Config changes documented?
- [ ] Migration scripts if needed?
- [ ] Environment variables added?
- [ ] Database changes tracked?

## Step 5: Summarize Findings

I'll provide structured results:

```markdown
### Code Review Summary

**Overall Assessment:** [Ready to Push / Needs Revision / Major Issues]

**Review Stats:**
- Files reviewed: [count]
- Issues found: [count]
  - Blocking: [count] (must fix)
  - Important: [count] (should fix)
  - Nice-to-have: [count] (optional)

**Quality Metrics:**
- Design alignment: ✅/⚠️/❌
- Code quality: ✅/⚠️/❌
- Security: ✅/⚠️/❌
- Performance: ✅/⚠️/❌
- Accessibility: ✅/⚠️/❌
- Testing: ✅/⚠️/❌
- Documentation: ✅/⚠️/❌
```

### Detailed Notes

```markdown
### 1. [File Path]

**Issue/Observation:** [Description]

**Impact:** [Blocking / Important / Nice-to-have]

**Category:** [Logic / Security / Performance / Accessibility / etc.]

**Recommendation:** [Specific action to take]

**Design reference:** [Link to relevant doc section]

**Code reference:**
```php
// Current code (problematic)
$results = $wpdb->get_results("SELECT * FROM {$wpdb->posts} WHERE post_type = '{$type}'");
```

**Suggested fix:**
```php
// Improved code
$results = $wpdb->get_results($wpdb->prepare(
    "SELECT * FROM {$wpdb->posts} WHERE post_type = %s",
    $type
));
```
```

### Example Findings

```markdown
### 1. blocks/queried-content/carousel-view.php

**Issue:** Output not escaped in loop

**Impact:** Blocking (security issue)

**Category:** Security

**Current:**
```php
<h3><?php echo $post->post_title; ?></h3>
```

**Recommendation:**
```php
<h3><?php echo esc_html($post->post_title); ?></h3>
```

**Design reference:** WordPress Coding Standards § Output Escaping
```

```markdown
### 2. assets/js/carousel.js

**Issue:** Excellent keyboard navigation implementation

**Impact:** Positive (no action needed)

**Category:** Accessibility

**Observation:**
Arrow key navigation works perfectly, focus management is correct, 
and keyboard shortcuts are intuitive. Great work!

**Design reference:** Estimate ticket AC: "Keyboard navigation works"
```

### Recommended Next Steps

```markdown
### Recommended Next Steps

#### Blocking Issues (Fix Before Push)
- [ ] Escape output in carousel-view.php (Security)
- [ ] Add nonce verification to AJAX handler (Security)
- [ ] Fix N+1 query in event loading (Performance)

#### Important Follow-Ups (Should Fix Soon)
- [ ] Add error handling for empty results (Logic)
- [ ] Extract duplicate carousel logic to utility (Quality)
- [ ] Add missing DocBlocks (Documentation)

#### Nice-to-Have Improvements (Optional)
- [ ] Consider lazy loading images (Performance)
- [ ] Add animation options (Feature)
- [ ] Improve mobile touch interactions (UX)

#### Testing Required
**Unit Tests:**
- [ ] Test carousel with 0, 5, 10 events
- [ ] Test arrow disable logic
- [ ] Test keyboard navigation

**Integration Tests:**
- [ ] Test block in editor
- [ ] Test with different post types
- [ ] Test query filtering

**Manual Testing:**
- [ ] Keyboard navigation (Tab, Arrow keys)
- [ ] Screen reader (VoiceOver, NVDA)
- [ ] Cross-browser (Chrome, Firefox, Safari, Edge, IE11)
- [ ] Mobile (iOS Safari, Android Chrome)
- [ ] Performance (Lighthouse, slow 3G)

#### Documentation
- [ ] Update README with carousel usage
- [ ] Add inline comments for complex scroll logic
- [ ] Document keyboard shortcuts
```

## Step 6: Final Checklist

Confirm completion:

```markdown
### Pre-Push Checklist

**Code Quality:**
- [ ] Implementation matches design & requirements
- [ ] No obvious logic or edge-case gaps
- [ ] Redundant code removed or justified
- [ ] Follows WordPress coding standards
- [ ] DocBlocks complete and accurate

**Security:**
- [ ] All input validated
- [ ] All output escaped
- [ ] Nonces verified
- [ ] Capabilities checked
- [ ] No SQL injection vulnerabilities

**Performance:**
- [ ] No N+1 queries
- [ ] Appropriate caching used
- [ ] Assets enqueued efficiently
- [ ] No blocking resources

**Accessibility:**
- [ ] Semantic HTML used
- [ ] ARIA labels present
- [ ] Keyboard navigation works
- [ ] Screen reader friendly

**Testing:**
- [ ] Unit tests written and passing
- [ ] Integration tests updated
- [ ] Manual testing complete
- [ ] Edge cases covered

**Documentation:**
- [ ] Code comments added
- [ ] Design docs updated if needed
- [ ] Implementation notes captured
- [ ] README updated if needed

**Overall Status:** [✅ Ready to Push / ⚠️ Fix Issues First]
```

## WordPress Theme-Specific Checks

Additional WordPress considerations:

### Theme Standards
- [ ] Files in correct theme directories?
- [ ] Template hierarchy respected?
- [ ] Naming conventions followed?
- [ ] Theme functions prefixed?

### Block Development
- [ ] block.json properly configured?
- [ ] Attributes validated?
- [ ] Editor styles included?
- [ ] Save/edit callbacks correct?

### Hooks & Filters
- [ ] Hook names correct?
- [ ] Priority appropriate?
- [ ] Correct number of arguments?
- [ ] Remove hooks when needed?

### Queries
- [ ] WP_Query vs get_posts appropriate?
- [ ] Tax_query syntax correct?
- [ ] Meta_query optimized?
- [ ] Query reset properly?

## Best Practices

### What Makes Good Code Review

✅ **DO:**
- Review all modified files
- Check against documentation
- Test security thoroughly
- Consider performance impact
- Verify accessibility
- Look for simplification opportunities
- Acknowledge good work too

❌ **DON'T:**
- Skip files (review everything)
- Only look for problems
- Ignore edge cases
- Forget accessibility
- Skip testing verification
- Rush through review

### Code Review Quality Checklist

Before finishing review:
- [ ] All files reviewed thoroughly
- [ ] Design alignment verified
- [ ] Security validated
- [ ] Performance assessed
- [ ] Accessibility checked
- [ ] Tests verified
- [ ] Documentation reviewed
- [ ] Recommendations provided
- [ ] Prioritized by impact

## Related Commands

After code review:
- Fix blocking issues
- Re-run `/review-code` after fixes
- Use `/write-test` if test gaps found
- Use `/check-implementation` for design validation

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-10-31  
**Compatible With**: Cursor AI Editor

