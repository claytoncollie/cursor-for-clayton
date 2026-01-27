---
name: Write Test
description: Test generator targeting 100% code coverage for WordPress theme development
---

# Write Test

Generates unit/integration tests targeting 100% coverage, aligned to acceptance criteria.

## When to Use

- After implementing features to add test coverage
- During `/clayton/execute-plan` to test as you build
- After `/clayton/review-code` identifies missing tests
- When fixing bugs to add regression tests

## Process

### Step 1: Gather Context

Ask for:
- **Feature name and branch** with summary of changes
- **Documentation links** (requirements, estimate ticket for acceptance criteria)
- **Target environment** (PHP backend, JavaScript frontend, or both)
- **Existing test setup** (PHPUnit, Jest, wp-browser, etc.)

Use @file to reference specific implementation files. Use @codebase to find existing test patterns.

### Step 2: Analyze Requirements

From requirements and design docs:
- Extract acceptance criteria as test cases
- Identify edge cases and error conditions
- Review existing test files for patterns and helpers

### Step 3: Write Unit Tests

For each function, create tests covering happy path, edge cases, error handling, and input validation:

```php
public function test_carousel_displays_correct_count() {
    $events = $this->factory->post->create_many(10, ['post_type' => 'event']);
    $this->assertCount(5, $this->extract_event_cards(render_carousel(['posts_per_page' => 5])));
}

public function test_carousel_empty_state() {
    $this->assertStringContainsString('No events found', render_carousel([]));
}
```

### Step 4: Write Integration Tests

Test component interactions:
```php
public function test_carousel_filters_by_event_category() {
    $cat = $this->factory->term->create(['taxonomy' => 'event-category']);
    $events = $this->factory->post->create_many(3, [
        'post_type' => 'event',
        'tax_input' => ['event-category' => [$cat]]
    ]);

    $output = render_carousel(['tax_query' => [['taxonomy' => 'event-category', 'terms' => $cat]]]);
    $this->assertCount(3, $this->extract_event_cards($output));
}
```

### Step 5: Achieve 100% Coverage

Run coverage analysis:
```bash
# PHP
phpunit --coverage-html coverage/

# JavaScript
npm run test -- --coverage
```

Identify and fill gaps:
- Functions not yet tested
- Branches not yet covered
- Error paths not exercised

### Step 6: Create Manual Test Checklist

Provide checklist for QA:
- [ ] Feature works with minimum/maximum/zero input
- [ ] Error and loading states display correctly
- [ ] Tab and arrow key navigation works
- [ ] Screen reader announces correctly
- [ ] Works across browsers (Chrome, Firefox, Safari, Edge)
- [ ] Works across devices (desktop, tablet, mobile)

### Step 7: Document Results

Update testing documentation with coverage results and test file locations.

## Output Format

```markdown
## Test Coverage Results

**Overall Coverage:** [X]% (Target: 100%)

### Test Files Created
- `tests/unit/test-[feature].php` ([N] tests)
- `tests/integration/test-[feature]-block.php` ([N] tests)

### Coverage Gaps (if any)
- [File:Line] - [Branch description] - Need: [test to add]

### Manual Test Checklist
- [ ] [Test case 1]
- [ ] [Test case 2]
```

## Output Rules

CRITICAL: Follow these output rules exactly.

1. Output ONLY the formatted content specified in this command
2. Do NOT add introductions ("Here's...", "I've prepared...", "Below is...")
3. Do NOT add summaries or wrap-up text after the output
4. Do NOT add meta-commentary about what you produced
5. Do NOT explain what the output contains
6. The formatted output IS your complete response - nothing before, nothing after

The output must be IMMEDIATELY COPY-PASTEABLE without removing surrounding text.

---

Next: Run `/clayton/review-code` to perform pre-push code review.
