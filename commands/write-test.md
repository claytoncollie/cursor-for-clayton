---
name: Write Test
description: Test generator targeting 100% code coverage for WordPress theme development
author: Clayton Collie
version: 1.0.0
tags: [testing, unit-tests, integration-tests, phpunit, wordpress, coverage]
---

# Write Test - Test Generator

## Command Purpose

Generates unit and integration tests for WordPress theme code, targeting 100% coverage. Provides test cases aligned with acceptance criteria from estimate tickets and requirements docs.

## Usage

```bash
/write-test
```

The command will guide you through comprehensive test generation.

## When to Use This Command

Use `/write-test` for:
- **After implementing features** to add test coverage
- **During `/execute-plan`** to test as you build
- **After `/review-code`** identifies missing tests
- **When fixing bugs** to add regression tests
- **Before QA handoff** to ensure quality

## Workflow Integration

**Typical workflow:**
1. Complete implementation with `/execute-plan`
2. Run `/check-implementation` to validate
3. **Run `/write-test`** to achieve 100% coverage
4. Run `/review-code` before pushing
5. Use `/handoff-qa` for manual QA prep

## How It Works

This command follows a structured 7-step test generation workflow.

## Step 1: Gather Context

I'll ask you for:

### Feature Information
1. **Feature Name and Branch**
   - What feature was implemented?
   - Which branch contains the code?

2. **Summary of Changes**
   - What code changed?
   - New files created
   - Modified files
   - Deleted files

3. **Documentation Links**
   - Design/architecture documents
   - Requirements documents
   - Testing documents
   - Estimate ticket (for acceptance criteria)

### Environment Information
1. **Target Environment**
   - Backend (PHP)
   - Frontend (JavaScript)
   - Full-stack (both)

2. **Existing Test Suites**
   - Unit test framework (PHPUnit, Jest, etc.)
   - Integration test setup (wp-browser, etc.)
   - E2E test framework (Playwright, Cypress, etc.)
   - Test file locations

3. **Testing Tools**
   - PHPUnit version
   - wp-browser setup
   - WP_Mock or Brain Monkey
   - Code coverage tools

### Known Issues
1. **Flaky Tests**
   - Tests that intermittently fail
   - Tests to avoid patterns from

2. **Slow Tests**
   - Long-running tests
   - Performance constraints

## Step 2: Analyze Testing Template

I'll review your testing documentation:

### Testing Doc Review
If a testing document exists:
- Review required sections
- Check coverage targets
- Note testing strategy
- Identify test categories

### Success Criteria & Edge Cases
From requirements & design docs:
- Extract acceptance criteria
- Identify edge cases
- Find error conditions
- Note performance requirements

### Existing Test Patterns
- Review existing test files
- Understand test structure
- Note helper functions/fixtures
- Identify mocks and stubs available

## Step 3: Unit Tests (Target 100% Coverage)

For each module/function, I'll create tests for:

### Happy Path Tests
Standard expected behavior:
```php
/**
 * Test: Carousel displays correct number of events
 */
public function test_carousel_displays_selected_event_count() {
    // Arrange: Create 10 events
    $events = $this->factory->post->create_many(10, ['post_type' => 'event']);
    
    // Act: Render carousel with limit of 5
    $output = render_carousel(['posts_per_page' => 5]);
    
    // Assert: Verify exactly 5 events rendered
    $this->assertCount(5, $this->extract_event_cards($output));
}
```

### Edge Cases
Boundary conditions and limits:
```php
/**
 * Test: Carousel handles zero events
 */
public function test_carousel_with_no_events_shows_empty_state() {
    // Arrange: No events exist
    
    // Act: Render carousel
    $output = render_carousel(['posts_per_page' => 10]);
    
    // Assert: Shows empty state message
    $this->assertStringContainsString('No events found', $output);
    $this->assertStringNotContainsString('<article', $output);
}

/**
 * Test: Carousel enforces maximum limit
 */
public function test_carousel_enforces_max_limit_of_ten() {
    // Arrange: Create 20 events
    $events = $this->factory->post->create_many(20, ['post_type' => 'event']);
    
    // Act: Render carousel requesting 15 events
    $output = render_carousel(['posts_per_page' => 15]);
    
    // Assert: Only 10 events rendered (max limit)
    $this->assertCount(10, $this->extract_event_cards($output));
}
```

### Error Handling
How code handles failures:
```php
/**
 * Test: Carousel handles missing event data gracefully
 */
public function test_carousel_handles_event_without_featured_image() {
    // Arrange: Create event with no featured image
    $event = $this->factory->post->create([
        'post_type' => 'event',
        'post_title' => 'Test Event'
    ]);
    
    // Act: Render carousel
    $output = render_carousel(['post__in' => [$event]]);
    
    // Assert: Uses fallback image
    $this->assertStringContainsString('fallback-image.jpg', $output);
}
```

### Input Validation
Test various input types:
```php
/**
 * Test: Carousel validates posts_per_page parameter
 */
public function test_carousel_validates_posts_per_page() {
    // Test invalid inputs
    $this->assertEquals(10, validate_posts_per_page(-5));  // negative
    $this->assertEquals(10, validate_posts_per_page(0));   // zero
    $this->assertEquals(10, validate_posts_per_page(100)); // too large
    $this->assertEquals(5, validate_posts_per_page(5));    // valid
}
```

### WordPress-Specific Tests
Test WordPress integrations:
```php
/**
 * Test: Carousel respects post status
 */
public function test_carousel_only_shows_published_events() {
    // Arrange: Create published and draft events
    $published = $this->factory->post->create(['post_type' => 'event', 'post_status' => 'publish']);
    $draft = $this->factory->post->create(['post_type' => 'event', 'post_status' => 'draft']);
    
    // Act: Render carousel
    $output = render_carousel(['posts_per_page' => 10]);
    
    // Assert: Only published event appears
    $cards = $this->extract_event_cards($output);
    $this->assertContains($published, array_column($cards, 'id'));
    $this->assertNotContains($draft, array_column($cards, 'id'));
}

/**
 * Test: Carousel applies WordPress query filters
 */
public function test_carousel_applies_pre_get_posts_filters() {
    // Arrange: Add filter to modify query
    add_filter('pre_get_posts', function($query) {
        if ($query->get('post_type') === 'event') {
            $query->set('orderby', 'title');
        }
        return $query;
    });
    
    $events = $this->factory->post->create_many(5, ['post_type' => 'event']);
    
    // Act: Render carousel
    $output = render_carousel(['posts_per_page' => 10]);
    
    // Assert: Events ordered by title
    $cards = $this->extract_event_cards($output);
    $this->assertEquals(get_post($events[0])->post_title, $cards[0]['title']);
}
```

### Coverage Analysis
For each file, identify:
- Functions not yet tested
- Branches not yet covered
- Error paths not exercised
- Edge cases not tested

## Step 4: Integration Tests

Test component interactions:

### Block Integration Tests
```php
/**
 * Integration Test: Carousel block renders in editor
 */
public function test_carousel_block_renders_in_block_editor() {
    // Arrange: Register block and create post
    register_carousel_block();
    $post_id = $this->factory->post->create();
    
    // Act: Render block in editor context
    $block_content = '<!-- wp:acf/carousel {"postsPerPage":5} /-->';
    $output = do_blocks($block_content);
    
    // Assert: Block renders correctly
    $this->assertStringContainsString('carousel-container', $output);
}
```

### Query Integration Tests
```php
/**
 * Integration Test: Carousel with taxonomy filtering
 */
public function test_carousel_filters_by_event_category() {
    // Arrange: Create events in different categories
    $cat1 = $this->factory->term->create(['taxonomy' => 'event-category', 'name' => 'Workshop']);
    $cat2 = $this->factory->term->create(['taxonomy' => 'event-category', 'name' => 'Conference']);
    
    $workshop_events = $this->factory->post->create_many(3, [
        'post_type' => 'event',
        'tax_input' => ['event-category' => [$cat1]]
    ]);
    
    $conference_events = $this->factory->post->create_many(3, [
        'post_type' => 'event',
        'tax_input' => ['event-category' => [$cat2]]
    ]);
    
    // Act: Render carousel filtered by category
    $output = render_carousel([
        'posts_per_page' => 10,
        'tax_query' => [
            [
                'taxonomy' => 'event-category',
                'field' => 'term_id',
                'terms' => $cat1
            ]
        ]
    ]);
    
    // Assert: Only workshop events appear
    $cards = $this->extract_event_cards($output);
    $this->assertCount(3, $cards);
    foreach ($cards as $card) {
        $this->assertContains($card['id'], $workshop_events);
    }
}
```

### JavaScript Integration Tests
```javascript
/**
 * Integration Test: Carousel navigation
 */
describe('Carousel Navigation', () => {
    let carousel;
    
    beforeEach(() => {
        document.body.innerHTML = createCarouselHTML(10);
        carousel = new Carousel('.carousel');
    });
    
    test('left arrow is disabled at start', () => {
        const leftArrow = carousel.element.querySelector('.arrow-left');
        expect(leftArrow.disabled).toBe(true);
    });
    
    test('clicking right arrow scrolls to next card', () => {
        const rightArrow = carousel.element.querySelector('.arrow-right');
        const initialScroll = carousel.element.scrollLeft;
        
        rightArrow.click();
        
        expect(carousel.element.scrollLeft).toBeGreaterThan(initialScroll);
    });
    
    test('right arrow is disabled at end', () => {
        // Scroll to end
        carousel.scrollToEnd();
        
        const rightArrow = carousel.element.querySelector('.arrow-right');
        expect(rightArrow.disabled).toBe(true);
    });
});
```

## Step 5: Coverage Strategy

I'll help you achieve 100% coverage:

### Coverage Commands
**PHP (PHPUnit):**
```bash
# Generate coverage report
phpunit --coverage-html coverage/

# Generate coverage text
phpunit --coverage-text

# Generate coverage for specific file
phpunit --coverage-filter src/carousel.php --coverage-text
```

**JavaScript (Jest):**
```bash
# Generate coverage report
npm run test -- --coverage

# Watch mode with coverage
npm run test -- --coverage --watch

# Coverage for specific file
npm run test -- carousel.test.js --coverage
```

### Coverage Analysis

I'll identify:

**Uncovered Functions:**
```markdown
### Functions Below 100% Coverage

1. **render_carousel()** - 85% coverage
   - Missing: Error handling when query fails (line 45-48)
   - Missing: Empty state branch (line 62-65)
   - Need: Test for failed WP_Query
   - Need: Test for zero results

2. **validate_posts_per_page()** - 75% coverage
   - Missing: Handling non-numeric input (line 22-24)
   - Missing: Handling float values (line 26-28)
   - Need: Test with string input
   - Need: Test with float input
```

**Uncovered Branches:**
```markdown
### Branch Coverage Gaps

1. **carousel-view.php:35** - "if (!has_post_thumbnail())" branch
   - Need: Test event without featured image

2. **carousel.js:67** - "else if (scrollPos === 0)" branch
   - Need: Test arrow state at scroll position 0

3. **block-settings.php:42** - "if (empty($attrs['postsPerPage']))" branch
   - Need: Test block with missing postsPerPage attribute
```

### Adding Missing Tests

For each gap, I'll provide:
```php
/**
 * Test: [What's being tested]
 * Coverage: [File:Line] - [Branch description]
 */
public function test_specific_coverage_gap() {
    // Test implementation
}
```

## Step 6: Manual & Exploratory Testing

I'll provide manual test checklists:

### Manual Testing Checklist

**Functional Testing:**
- [ ] Feature works with minimum input (5 events)
- [ ] Feature works with maximum input (10 events)
- [ ] Feature works with no input (0 events)
- [ ] Feature works with edge values (1 event, 11 events)
- [ ] Error states display correctly
- [ ] Loading states display correctly

**UX Testing:**
- [ ] Navigation is intuitive
- [ ] Feedback is immediate
- [ ] Actions are reversible where appropriate
- [ ] Help text is clear

**Accessibility Testing:**
- [ ] Tab navigation works
- [ ] Arrow key navigation works
- [ ] Screen reader announces correctly (VoiceOver, NVDA)
- [ ] Focus indicators visible
- [ ] Color contrast sufficient
- [ ] Works at 200% zoom

**Cross-Browser Testing:**
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)
- [ ] IE11 (if required)

**Cross-Device Testing:**
- [ ] Desktop (1920x1080)
- [ ] Laptop (1366x768)
- [ ] Tablet (iPad, 768x1024)
- [ ] Mobile (iPhone, 375x667)
- [ ] Mobile (Android, 360x640)

**Performance Testing:**
- [ ] Lighthouse score > 90
- [ ] Loads in < 2s on 3G
- [ ] No layout shift (CLS < 0.1)
- [ ] Smooth scrolling (60fps)

### Exploratory Testing Scenarios

**Chaos Testing:**
- Rapid clicking of navigation arrows
- Scrolling while navigating
- Resizing window during interaction
- Network interruption during load
- Browser back/forward during use

**WordPress-Specific Testing:**
- Different user roles (admin, editor, author)
- Different post statuses (published, draft, scheduled)
- Different taxonomy configurations
- With/without featured images
- With/without cache plugins active

## Step 7: Update Documentation & TODOs

I'll help you document test results:

### Testing Doc Updates

Update your testing documentation:

```markdown
## Test Coverage Results

**Overall Coverage:** 100% (Target: 100%)

### Unit Test Coverage
- **render_carousel()**: 100% (12 tests)
- **validate_posts_per_page()**: 100% (5 tests)
- **get_carousel_events()**: 100% (8 tests)

### Integration Test Coverage
- Block registration: ✅ (3 tests)
- Taxonomy filtering: ✅ (4 tests)
- JavaScript navigation: ✅ (6 tests)

### Manual Test Results
- Functional testing: ✅ All passed
- Accessibility testing: ✅ WCAG 2.1 AA compliant
- Cross-browser testing: ✅ All supported browsers
- Performance testing: ✅ Lighthouse score: 95

### Test Files Created
- `tests/unit/test-carousel.php` (12 tests)
- `tests/unit/test-carousel-validation.php` (5 tests)
- `tests/integration/test-carousel-block.php` (3 tests)
- `tests/integration/test-carousel-queries.php` (4 tests)
- `assets/js/__tests__/carousel.test.js` (6 tests)

### Coverage Gaps (None)
All code paths covered. No deferred testing.

### Test Execution
```bash
# Run all tests
composer test

# Run with coverage
composer test:coverage

# View coverage report
open coverage/index.html
```

**Last Updated:** 2025-10-31
**Coverage Report:** coverage/index.html
```

### Follow-Up Tasks

Track deferred or missing tests:

```markdown
### Deferred Testing (None currently)

If any tests cannot be completed:

- [ ] Test: [Description]
  - Reason: [Why deferred]
  - Owner: [Who will add it]
  - Due: [When to complete]
  - Blocker: [What's preventing it]
```

## WordPress Testing Patterns

### PHPUnit + wp-browser Setup

```php
<?php
/**
 * Base test case for theme tests
 */
class Theme_Test_Case extends WP_UnitTestCase {
    
    public function setUp(): void {
        parent::setUp();
        
        // Register post types
        register_event_post_type();
        
        // Register taxonomies
        register_event_taxonomies();
        
        // Register blocks
        register_theme_blocks();
    }
    
    public function tearDown(): void {
        // Clean up
        parent::tearDown();
    }
    
    /**
     * Helper: Extract event cards from HTML
     */
    protected function extract_event_cards($html) {
        // Parse HTML and extract cards
        // Return array of card data
    }
}
```

### Mock WordPress Functions

```php
<?php
use Brain\Monkey\Functions;

/**
 * Test with mocked WordPress functions
 */
public function test_with_mocked_wp_functions() {
    // Mock get_option
    Functions\when('get_option')->justReturn('mocked_value');
    
    // Mock get_post_meta
    Functions\when('get_post_meta')
        ->with(123, 'event_date', true)
        ->justReturn('2025-12-01');
    
    // Test code that uses these functions
    $result = my_function_that_uses_wp_functions();
    
    $this->assertEquals('expected', $result);
}
```

## Best Practices

### What Makes Good Tests

✅ **DO:**
- Test one thing per test
- Use descriptive test names
- Follow Arrange-Act-Assert pattern
- Test edge cases and boundaries
- Test error handling
- Mock external dependencies
- Keep tests fast
- Make tests independent
- Target 100% coverage

❌ **DON'T:**
- Test multiple things in one test
- Use vague test names
- Skip edge cases
- Forget error paths
- Test implementation details
- Create slow tests
- Make tests depend on each other
- Settle for < 100% coverage

### Test Quality Checklist

Before finishing:
- [ ] All functions have tests
- [ ] All branches covered
- [ ] Edge cases tested
- [ ] Error handling tested
- [ ] Happy paths tested
- [ ] Integration points tested
- [ ] Tests are fast (< 100ms each)
- [ ] Tests are independent
- [ ] Test names are descriptive
- [ ] Coverage is 100%

## Related Commands

During testing:
- Use `/debug-issue` if tests reveal issues
- Use `/check-implementation` to validate fixes
- Use `/review-code` before finalizing

After testing:
- Use `/handoff-qa` for manual QA prep

---

## ✨ Next Command

After completing `/write-test`:

**Next Step:** Run `/review-code`

```bash
/review-code
```

**What it does:** Performs a thorough pre-push code review to catch issues early, validate against design docs, and ensure code quality standards are met before pushing changes.

**Why this matters:** Acts as your final quality gate before sharing code with the team. Catches security issues, performance problems, and validates that all your tests are comprehensive.

**Before running:** Make sure all your tests pass and you've achieved the coverage targets identified during `/write-test`.

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-10-31  
**Compatible With**: Cursor AI Editor

