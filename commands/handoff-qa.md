---
name: Handoff QA
description: QA handoff generator that validates acceptance criteria and creates testing documentation
author: Clayton Collie
version: 1.0.0
tags: [qa, testing, handoff, teamwork, acceptance-criteria, wordpress]
---

# Handoff QA - QA Handoff Generator

## Command Purpose

Verifies that acceptance criteria from the estimate ticket are met, generates comprehensive QA handoff documentation, and creates ready-to-paste text for Teamwork tickets.

## Usage

```bash
/handoff-qa
```

The command will guide you through creating a complete QA handoff document.

## When to Use This Command

Use `/handoff-qa` for:
- **Before QA testing** to prepare handoff documentation
- **After implementation is complete** and tested by developer
- **Before deploying to staging** for QA review
- **When ready to move ticket** from "In Progress" to "Ready for QA"
- **To document test scenarios** for manual testing

## Workflow Integration

**Typical workflow:**
1. Complete implementation with `/execute-plan`
2. Validate with `/check-implementation`
3. Add tests with `/write-test`
4. Run `/review-code` and fix issues
5. **Run `/handoff-qa`** to prepare for QA
6. Paste output into Teamwork ticket
7. Move ticket to "Ready for QA"

## How It Works

This command follows a structured 5-step workflow to create comprehensive QA handoff documentation.

## Step 1: Gather Context

I'll ask you for:

### Ticket Information
1. **Estimate Ticket**
   - Teamwork ticket ID or link
   - Or: Paste acceptance criteria directly
   - Or: Point to estimate doc file

2. **Feature Summary**
   - Brief description of what was built
   - Key functionality implemented
   - Any changes from original estimate

### Environment Information
1. **Where to Test**
   - Environment URL (staging, QA, production)
   - Database/content state
   - Any required test accounts
   - Special setup needed

2. **Entry Points**
   - URLs to specific pages
   - WordPress admin paths
   - Block editor locations
   - How to find/access the feature

### Implementation Details
1. **What Changed**
   - New files created
   - Modified components
   - Database changes
   - Config changes

2. **Known Limitations or Caveats**
   - Expected behaviors that might seem like bugs
   - Browser/device limitations
   - Performance considerations
   - Deferred functionality

### Testing Scope
1. **What to Test**
   - Primary functionality
   - Edge cases to verify
   - Error states to check
   - Responsive behavior

2. **What NOT to Test**
   - Out of scope items
   - Deferred features
   - Known existing issues

## Step 2: Validate Acceptance Criteria

I'll review each acceptance criterion:

### Load Acceptance Criteria

From estimate ticket or doc:
```markdown
### Original Acceptance Criteria

1. [ ] Block settings include "Carousel" display mode option
2. [ ] Editor can select 5-10 Event posts manually or via query
3. [ ] Cards display featured image, title, category, date, and CTA
4. [ ] Cards use existing event card partial markup
5. [ ] Left/right arrows appear and function correctly
6. [ ] Arrows disable appropriately at carousel boundaries
7. [ ] Smooth scroll snaps to card boundaries
8. [ ] Carousel works on mobile (touch swipe) and desktop (arrows + drag)
9. [ ] Respects existing event query filters (published, visible)
10. [ ] Renders correctly in block editor preview
11. [ ] Works across all breakpoints (mobile, tablet, desktop)
12. [ ] Keyboard navigation works (tab to arrows, arrow keys to scroll)
```

### Validate Each Criterion

For each AC, I'll verify:

```markdown
### AC #1: Block settings include "Carousel" display mode option

**Status:** ✅ Met

**Implementation:**
- Added "Display Mode" control to block settings
- Options: "Grid", "List", "Carousel"
- Default: "Grid"
- Setting persists correctly

**Testing Notes:**
- Found in: Block sidebar → Settings → Display
- Switching modes updates preview immediately
- Works in both post editor and site editor

**Files Changed:**
- blocks/queried-content/block.json (added displayMode attribute)
- blocks/queried-content/edit.js (added control)

**Verification Steps:**
1. Add queried-content block to page
2. Open block settings in sidebar
3. Locate "Display Mode" setting
4. Verify "Carousel" option is available
5. Select "Carousel" and verify preview updates
```

### Identify Gaps

If any AC not met:
```markdown
### AC #8: Carousel works on mobile (touch swipe)

**Status:** ⚠️ Partially Met

**Implementation:**
- Desktop arrow navigation: ✅ Complete
- Keyboard navigation: ✅ Complete
- Touch swipe: ⚠️ Works but not optimized

**Gap:**
Touch swipe works on iOS/Android but lacks momentum scrolling and 
snap points don't always align on touch devices.

**Recommendation:**
Either:
- Fix touch behavior before QA (estimated: 2h)
- Document as known limitation for this release
- Create follow-up ticket for touch optimization

**Files to Fix:**
- assets/js/carousel.js (add touch event listeners)
- assets/css/carousel.css (add scroll-snap properties)
```

## Step 3: Generate Testing Steps

I'll create detailed test steps:

### For Each Acceptance Criterion

**Test Case Format:**
```markdown
## Test Case 1: Carousel Display Mode Selection

**Acceptance Criterion:** Block settings include "Carousel" display mode option

**Preconditions:**
- Logged in as Editor or Admin
- On a page with the block editor enabled
- Event post type exists with at least 5 published events

**Test Steps:**
1. Navigate to Pages → Add New (or edit existing page)
2. Click the "+" to add a block
3. Search for "Queried Content" block
4. Add the block to the page
5. Click the block to select it
6. Open the block settings panel (right sidebar)
7. Locate the "Display Mode" setting
8. Verify "Carousel" option is available
9. Select "Carousel" from the dropdown
10. Observe the block preview updates to carousel layout

**Expected Results:**
- "Display Mode" setting is visible in block settings
- "Carousel" is an available option
- Selecting "Carousel" immediately updates the preview
- Preview shows events in horizontal scrollable row
- Left/right navigation arrows appear

**Test Data:**
- Events: Any 5+ published events with featured images

**Browser/Device:**
- Chrome, Firefox, Safari (latest)
- Desktop (1920x1080)
```

### Organized by Priority

**Critical Tests (Must Pass):**
```markdown
### Critical Functionality (Blocking)

These tests must pass for the feature to be acceptable.

1. **Carousel displays correct number of events**
   - Test with 5, 8, 10 events
   - Verify max limit of 10 enforced

2. **Navigation arrows function correctly**
   - Left/right arrows scroll properly
   - Disabled states work correctly

3. **Events display correct data**
   - Featured image, title, date, category, CTA all present
   - No missing or broken data
```

**Important Tests (Should Pass):**
```markdown
### Important Functionality (High Priority)

These tests should pass but workarounds might exist.

1. **Keyboard navigation works**
   - Tab to arrows
   - Arrow keys scroll
   - Focus indicators visible

2. **Responsive behavior correct**
   - Works on mobile, tablet, desktop
   - Touch swipe on mobile
   - Layout doesn't break
```

**Nice-to-Have Tests (Optional):**
```markdown
### Edge Cases & Polish (Nice to Have)

Test if time allows.

1. **Empty state displays correctly**
   - With 0 events
   - Shows appropriate message

2. **Loading state handles well**
   - During query
   - Shows loading indicator
```

## Step 4: Document Known Limitations

I'll capture known issues and caveats:

### Expected Behaviors

Things that might seem like bugs but are intentional:
```markdown
### Known Behaviors (Not Bugs)

1. **Carousel shows partial next card**
   - **Behavior:** The right edge shows a partial view of the next card
   - **Why:** Intentional design to indicate more content is available
   - **Do NOT report as:** "Card is cut off"

2. **Arrow navigation snaps to cards**
   - **Behavior:** Clicking arrows jumps to next card (not smooth scroll)
   - **Why:** Better UX for discrete card navigation
   - **Do NOT report as:** "Scroll is too fast/jumpy"

3. **Maximum 10 events enforced**
   - **Behavior:** Even if you query 20 events, only 10 display
   - **Why:** Performance and design constraint per estimate
   - **Do NOT report as:** "Not all events showing"
```

### Browser/Device Limitations

```markdown
### Browser/Device Constraints

1. **IE11 Support**
   - Status: Basic functionality only
   - Known Issues: CSS scroll-snap not supported (graceful degradation)
   - Workaround: Manual scroll still works

2. **Safari Mobile**
   - Status: Fully supported
   - Known Issues: Touch momentum scrolling differs from other browsers
   - Acceptable: Platform-specific behavior

3. **Older Android (< 8.0)**
   - Status: Not tested
   - Out of Scope: Per requirements doc
```

### Deferred Functionality

```markdown
### Out of Scope (Deferred to Future Releases)

Not included in this release:

1. **Carousel auto-play** - Intentionally excluded per estimate
2. **Video support in carousel** - Not in original requirements
3. **Drag-to-reorder in editor** - Nice-to-have deferred
4. **Animation speed customization** - Future enhancement
```

## Step 5: Generate QA Handoff Text

I'll create formatted text ready to paste into Teamwork:

### Handoff Document Structure

```markdown
# QA Handoff: Featured Content Carousel

## Summary

Implemented a horizontal carousel display mode for the Queried Content block, allowing editors to feature 5-10 Events in a scrollable carousel with arrow navigation.

**Key Features:**
- Carousel display mode added to Queried Content block
- Manual selection of 5-10 events or automatic query-based selection
- Arrow navigation with keyboard accessibility
- Responsive behavior across devices
- Touch/swipe support on mobile

**Estimate Ticket:** [TW-12345](https://teamwork.com/tickets/12345)

---

## Where to Test

**Environment:** https://staging.example.com

**Test Accounts:**
- Username: `qa_editor`
- Password: `[See 1Password: QA Accounts]`

**Entry Points:**

1. **Block Editor:**
   - URL: https://staging.example.com/wp-admin/post-new.php?post_type=page
   - Add "Queried Content" block
   - Select "Carousel" display mode

2. **Example Page (already configured):**
   - URL: https://staging.example.com/events/
   - Scroll to "Featured Events" section
   - Carousel should be visible with 10 events

3. **Site Editor:**
   - URL: https://staging.example.com/wp-admin/site-editor.php
   - Navigate to template: Event Landing Page
   - Carousel block should be in template

---

## Testing Steps

### Test 1: Carousel Configuration (Critical)

**Acceptance Criteria:**
- [ ] Block settings include "Carousel" display mode option
- [ ] Editor can select 5-10 Event posts manually or via query

**Steps:**
1. Log in as Editor
2. Navigate to Pages → Add New
3. Add "Queried Content" block
4. Open block settings (right sidebar)
5. Locate "Display Mode" setting
6. Verify "Carousel" option exists
7. Select "Carousel"
8. Verify "Number of Posts" setting (range: 5-10)
9. Set to 5, then 8, then 10
10. Verify preview updates correctly each time

**Expected:** Carousel displays selected number of events (5, 8, or 10)

---

### Test 2: Event Card Display (Critical)

**Acceptance Criteria:**
- [ ] Cards display featured image, title, category, date, and CTA
- [ ] Cards use existing event card partial markup

**Steps:**
1. On a page with a configured carousel (use /events/)
2. Inspect each event card in the carousel
3. Verify each card contains:
   - Featured image (or fallback if missing)
   - Event title
   - Event category (primary term)
   - Event date (formatted: "Jan 15, 2025")
   - "Learn More" CTA button
4. Click a card's CTA
5. Verify navigates to correct event detail page

**Expected:** All data present and formatted correctly, links work

---

### Test 3: Arrow Navigation (Critical)

**Acceptance Criteria:**
- [ ] Left/right arrows appear and function correctly
- [ ] Arrows disable appropriately at carousel boundaries

**Steps:**
1. On /events/ page with carousel
2. Verify left arrow is disabled initially (at start)
3. Click right arrow repeatedly
4. Verify carousel scrolls to next card each time
5. Verify scroll animation is smooth
6. Continue clicking right arrow until end
7. Verify right arrow becomes disabled at end
8. Click left arrow to scroll back
9. Verify left arrow becomes disabled at start again

**Expected:** Arrows work correctly, disable at boundaries

---

### Test 4: Keyboard Navigation (Critical)

**Acceptance Criteria:**
- [ ] Keyboard navigation works (tab to arrows, arrow keys to scroll)

**Steps:**
1. On /events/ page with carousel
2. Use Tab key to navigate to right arrow
3. Verify focus indicator visible on arrow
4. Press Enter/Space to activate arrow
5. Verify carousel scrolls
6. Press Tab to left arrow
7. Press Enter/Space to activate
8. Verify carousel scrolls back
9. Try Left/Right arrow keys
10. Verify carousel scrolls with arrow keys

**Expected:** Full keyboard accessibility, visible focus indicators

---

### Test 5: Responsive Behavior (Important)

**Acceptance Criteria:**
- [ ] Carousel works on mobile (touch swipe) and desktop (arrows + drag)
- [ ] Works across all breakpoints (mobile, tablet, desktop)

**Steps:**
1. On /events/ page with carousel
2. Test Desktop (1920x1080):
   - Arrow navigation works
   - Drag to scroll works
   - Cards display in single row
3. Test Tablet (768x1024):
   - Touch swipe works
   - Layout adjusts correctly
   - Cards remain readable
4. Test Mobile (375x667):
   - Touch swipe works smoothly
   - Cards stack appropriately
   - Text remains legible

**Expected:** Carousel works correctly across all breakpoints and input methods

---

### Test 6: Block Editor Preview (Important)

**Acceptance Criteria:**
- [ ] Renders correctly in block editor preview

**Steps:**
1. In block editor with carousel block
2. Verify preview shows carousel layout
3. Verify preview shows correct number of events
4. Change display mode to "Grid"
5. Verify preview updates to grid layout
6. Change back to "Carousel"
7. Verify preview returns to carousel layout

**Expected:** Preview accurately reflects carousel state

---

### Test 7: Query Filters (Important)

**Acceptance Criteria:**
- [ ] Respects existing event query filters (published, visible)

**Steps:**
1. Create a draft event (unpublished)
2. On /events/ page with carousel
3. Verify draft event does NOT appear in carousel
4. Only published events appear
5. Publish the draft event
6. Refresh page
7. Verify event now appears in carousel

**Expected:** Only published events display

---

## Known Limitations & Caveats

**These are EXPECTED behaviors, not bugs:**

1. **Partial Next Card Visible**
   - The right edge shows part of the next card
   - This is intentional to indicate more content

2. **Maximum 10 Events**
   - Even if more events exist, max 10 display
   - Per design constraints

3. **Touch Scroll Behavior**
   - iOS/Android have platform-specific scroll feel
   - This is normal and acceptable

**Out of Scope:**
- Auto-play carousel (deferred)
- Video in carousel (not in requirements)
- Custom animation speeds (future enhancement)

---

## Test Environment Setup

**Prerequisites:**
- At least 10 published events with featured images
- Event categories assigned to events
- Clear browser cache before testing

**If Events Missing:**
Run this WP-CLI command to generate test events:
```bash
wp generate-events --count=10
```

---

## Files Changed

**New Files:**
- `/blocks/queried-content/carousel-view.php`
- `/assets/js/carousel.js`
- `/assets/css/carousel.css`

**Modified Files:**
- `/blocks/queried-content/block.json`
- `/blocks/queried-content/render.php`
- `/blocks/queried-content/edit.js`

---

## Questions or Issues?

**Developer Contact:** [Your Name]
**Estimate Ticket:** [TW-12345](https://teamwork.com/tickets/12345)

If you find bugs or have questions, please:
1. Comment on the Teamwork ticket
2. Include screenshots/screen recordings if possible
3. Note browser/device and exact steps to reproduce

---

**QA Handoff Prepared:** 2025-10-31
**Ready for Testing:** Yes ✅
```

## WordPress Theme-Specific QA Guidance

I'll include WordPress-specific test scenarios:

### WordPress Editor Testing
- Block appears in inserter
- Block settings save correctly
- Block preview accurate
- Block works in post editor and site editor
- Block exports/imports correctly
- Block works with Gutenberg plugin

### Post Type & Taxonomy Testing
- Query respects post types
- Taxonomy filters work
- Custom fields display correctly
- Post status respected
- Post visibility honored

### User Role Testing
- Works for Admin
- Works for Editor
- Works for Author (if applicable)
- Respects capability checks

### Performance Testing
- No N+1 queries (use Query Monitor)
- Transients/caching working
- Page load time acceptable
- No PHP errors/warnings

## Best Practices

### What Makes Good QA Handoff

✅ **DO:**
- Provide clear entry points
- Write detailed, numbered steps
- Include expected results
- Document known limitations
- Specify test environment
- List test accounts/credentials
- Include acceptance criteria
- Note out-of-scope items

❌ **DON'T:**
- Assume QA knows the feature
- Skip reproduction steps
- Forget edge cases
- Leave out test data
- Ignore known issues
- Use vague language
- Skip environment details

### QA Handoff Quality Checklist

Before submitting:
- [ ] All acceptance criteria validated
- [ ] Test steps are detailed and clear
- [ ] Entry points documented with URLs
- [ ] Test environment specified
- [ ] Known limitations documented
- [ ] Out-of-scope items listed
- [ ] Test data/setup instructions provided
- [ ] Contact info included
- [ ] Formatted and ready to paste

## Related Commands

Before QA handoff:
- Use `/check-implementation` to validate
- Use `/write-test` for automated tests
- Use `/review-code` to catch issues

After QA feedback:
- Use `/debug-issue` to troubleshoot issues
- Use `/update-planning` to document findings

---

## ✨ Workflow Complete!

After completing `/handoff-qa`:

**You've completed the development workflow! 🎉**

**Final Steps:**
1. Paste the generated QA handoff documentation into your Teamwork ticket
2. Move the ticket to "Ready for QA" status
3. Notify the QA team that the feature is ready for testing
4. Monitor for QA feedback and be ready to address any issues

**If QA finds issues:** Use `/debug-issue` to troubleshoot and fix problems, then repeat relevant workflow steps as needed.

**Starting a new feature?** Begin again with `/estimate-ticket` for your next task.

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-10-31  
**Compatible With**: Cursor AI Editor

