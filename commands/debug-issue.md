---
name: Debug Issue
description: Structured debugging assistant for WordPress theme development
author: Clayton Collie
version: 1.0.0
tags: [debugging, troubleshooting, wordpress, issue-resolution, workflow]
---

# Debug Issue - Debugging Assistant

## Command Purpose

Helps debug issues by clarifying expectations, identifying gaps, and agreeing on a fix plan before changing code. Takes a structured approach to isolate problems and surface resolution options.

## Usage

```bash
/debug-issue
```

The command will guide you through a systematic debugging process.

## When to Use This Command

Use `/debug-issue` for:
- **Unexpected behavior** that doesn't match requirements
- **Bugs discovered during testing** or in production
- **Features not working** as designed
- **Performance issues** that need investigation
- **Integration problems** with WordPress or third-party code
- **Edge cases** causing failures

## Workflow Integration

**Typical workflow:**
1. Encounter an issue during `/execute-plan`
2. **Run `/debug-issue`** to systematically troubleshoot
3. Implement agreed-upon fix
4. Run `/check-implementation` to verify
5. Add regression tests with `/write-test`

## How It Works

This command follows a structured 7-step debugging workflow.

## Step 1: Gather Context

I'll ask you for:

### Issue Description
1. **What is happening?**
   - Describe the observed behavior
   - When did this start?
   - Is it consistent or intermittent?

2. **Where is it happening?**
   - Which page, template, or component?
   - Which environment (local, staging, production)?
   - Which browsers/devices affected?

3. **What were you doing?**
   - Steps that led to the issue
   - What action triggered it?
   - Can you reproduce it reliably?

### Expected Behavior
1. **What should happen?**
   - Describe the correct behavior
   - Reference requirements or acceptance criteria
   - Link to design or estimate ticket

2. **Current vs. Expected**
   - Specific differences
   - Error messages or warnings
   - Visual bugs or functional failures

### Recent Changes
1. **What changed recently?**
   - Recent commits or deployments
   - New features or refactors
   - Plugin or WordPress updates
   - Environment or config changes

2. **Timeline**
   - When was it last working?
   - When did issue first appear?
   - Related changes in that timeframe?

### Impact Assessment
1. **Scope of Impact**
   - How many users affected?
   - What functionality is broken?
   - Which services or features?
   - Production vs. development?

2. **Severity**
   - Critical (blocks all users/functionality)
   - High (blocks major features)
   - Medium (workaround exists)
   - Low (cosmetic or edge case)

## Step 2: Clarify Reality vs Expectation

I'll help document:

### Restate the Problem
Clear summary of:
- **Observed Behavior**: What actually happens
- **Expected Behavior**: What should happen
- **Difference**: The gap between them

### Requirements Validation
- Which requirement, ticket, or acceptance criterion defines expectation?
- Is the expectation correct and current?
- Are there conflicting requirements?

### Acceptance Criteria for Fix
How we'll know the issue is resolved:
- [ ] Specific behavior criterion
- [ ] Measurable outcome
- [ ] Test case that passes

**Example:**
```markdown
### Problem Statement

**Observed:** Carousel shows 15 events instead of limiting to 10

**Expected:** Estimate ticket AC: "Can select 5-10 posts"

**Gap:** Query is not respecting the posts_per_page parameter

**Fix Criteria:**
- [ ] Carousel displays maximum of 10 events
- [ ] Query respects posts_per_page setting
- [ ] Block settings allow 5-10 range selection
- [ ] Works for both manual and automatic modes
```

## Step 3: Reproduce & Isolate

I'll help you:

### Determine Reproducibility
- **Always**: Issue happens every time
- **Intermittent**: Happens sometimes (pattern?)
- **Environment-specific**: Only in certain conditions
- **User-specific**: Only for certain users/roles

### Capture Reproduction Steps
Exact steps to reproduce:
```markdown
### Reproduction Steps

1. Navigate to Event Landing Page
2. Scroll to Featured Carousel section
3. Count visible event cards
4. Click right arrow 10 times
5. Observe: 15 total events visible (expected: 10 max)

**Environment:**
- WordPress: 6.4.1
- PHP: 8.1
- Theme: Custom theme v2.3.0
- Browser: Chrome 119 (also tested Firefox, Safari)
- User Role: Admin (also tested as Editor)
```

### Available Tests
- Are there existing unit/integration tests?
- Do any tests expose the failure?
- Can we write a test case for this?

### Suspected Components
List likely culprits:
- Specific files
- Functions or methods
- WordPress hooks
- Database queries
- JavaScript logic
- CSS/styling
- Third-party integrations

## Step 4: Analyze Potential Causes

I'll help brainstorm:

### Plausible Root Causes

**Code Issues:**
- Logic errors or typos
- Missing validation
- Incorrect conditionals
- Wrong variable usage
- Missing return statements

**Data Issues:**
- Incorrect database values
- Missing post meta
- Wrong taxonomy terms
- Corrupted data
- Migration failures

**Configuration Issues:**
- Wrong settings or options
- Incorrect environment variables
- Plugin conflicts
- Theme conflicts
- Server configuration

**Integration Issues:**
- WordPress version incompatibility
- Plugin API changes
- Third-party service failures
- External dependency issues

**Regression Issues:**
- Recent code changes
- New feature side effects
- Refactoring mistakes
- Merge conflicts

### Gather Supporting Evidence

**Logs:**
- PHP error logs
- JavaScript console errors
- WordPress debug log
- Server access logs

**Metrics:**
- Performance timings
- Database query counts
- API response times
- Error rates

**Traces:**
- Stack traces
- Query logs
- Debug output
- Xdebug traces

**Visual Evidence:**
- Screenshots of issue
- Browser DevTools output
- Network tab inspection
- Comparison of expected vs. actual

### Gaps and Unknowns

What we still need to investigate:
- Information we don't have
- Tests we need to run
- Code we need to review
- Data we need to inspect

## Step 5: Surface Options

I'll present possible resolution paths:

### Option Analysis

For each potential fix:

```markdown
### Option 1: [Quick Fix Name]

**Approach:**
[Description of fix]

**Pros:**
- Fast to implement
- Low risk
- Minimal code changes

**Cons:**
- Doesn't address root cause
- May need revisiting
- Might not scale

**Risks:**
- Risk 1
- Risk 2

**Verification Steps:**
1. Step to verify fix worked
2. Test to run
3. Metric to check

**Time Estimate:** [hours]
```

### Common Fix Patterns

**Quick Fix:**
- Minimal code change
- Addresses immediate symptom
- May need follow-up
- Good for critical production issues

**Deep Fix:**
- Addresses root cause
- May require refactoring
- Takes more time
- Prevents future issues

**Rollback:**
- Revert recent changes
- Quick resolution
- Loses new functionality
- Buys time for proper fix

**Feature Flag:**
- Disable problematic feature
- Allows time for fix
- Users lose feature temporarily
- Good for non-critical features

**Workaround:**
- Temporary solution
- Doesn't fix code
- Manual or process-based
- Document for tracking

### WordPress-Specific Options

**Cache Clear:**
- Clear object cache
- Clear transients
- Regenerate rewrites
- Flush opcache

**Plugin Isolation:**
- Deactivate suspect plugins
- Test with default theme
- Check plugin conflicts
- Review plugin updates

**Database Fix:**
- Run database repair
- Update post meta
- Fix term relationships
- Regenerate data

**Hooks/Filters:**
- Add filter to modify behavior
- Hook into WordPress action
- Override with higher priority
- Remove problematic hook

## Step 6: Confirm Path Forward

I'll help you decide:

### Decision Criteria
- **Urgency**: How fast do we need a fix?
- **Impact**: How many users affected?
- **Risk**: What could go wrong?
- **Resources**: What do we have available?
- **Quality**: Long-term vs. short-term fix?

### Recommendation
Based on analysis, I'll recommend:
- **Preferred Option**: Best long-term solution
- **Rationale**: Why this option
- **Trade-offs**: What we're accepting

### Plan Summary

```markdown
### Chosen Approach: [Option Name]

**What we'll do:**
1. Step 1
2. Step 2
3. Step 3

**Why this approach:**
[Rationale]

**Pre-work needed:**
- [ ] Create backup/branch
- [ ] Write failing test
- [ ] Review related code

**Success Criteria:**
- [ ] Issue no longer reproduces
- [ ] Test passes
- [ ] No new issues introduced
- [ ] Performance acceptable

**Validation Steps:**
1. Run reproduction steps (should not reproduce)
2. Run test suite (all pass)
3. Manual testing checklist
4. Deploy to staging for verification

**Rollback Plan:**
If fix fails, we'll:
1. Revert commit [hash]
2. Clear cache
3. Verify rollback worked
```

## Step 7: Next Actions & Tracking

I'll help you:

### Document the Issue
Create or update issue tracker entry:

```markdown
## Issue: Carousel displays 15 events instead of 10

**Status:** In Progress
**Priority:** High
**Assigned:** [Name]
**Due:** [Date]

**Problem:**
Query not respecting posts_per_page parameter in carousel display mode

**Root Cause:**
The `queried-content` block passes posts_per_page to WP_Query but carousel
render callback queries again without limit parameter

**Fix Plan:**
Pass posts_per_page to carousel-view.php and enforce in render

**Files to Change:**
- blocks/queried-content/render.php (pass parameter)
- blocks/queried-content/carousel-view.php (enforce limit)

**Testing:**
- [ ] Unit test for query limit
- [ ] Manual test with 5, 8, 10 events
- [ ] Verify both manual and auto modes

**Timeline:**
- Fix implementation: 1h
- Testing: 1h
- Code review: 0.5h
- Deploy to staging: same day
```

### Post-Deployment Actions

**Monitoring:**
- What metrics to watch?
- What logs to check?
- How long to monitor?

**Communication:**
- Who needs to know?
- What channels to use?
- When to notify?

**Documentation:**
- Update relevant docs
- Add comments in code
- Document lessons learned

### Follow-Up Tasks

**Immediate:**
- [ ] Implement fix
- [ ] Write regression test
- [ ] Manual testing
- [ ] Code review

**Short-term:**
- [ ] Deploy to staging
- [ ] QA verification
- [ ] Deploy to production
- [ ] Monitor metrics

**Long-term:**
- [ ] Update documentation
- [ ] Improve test coverage
- [ ] Review similar code for same issue
- [ ] Postmortem (if critical)

## WordPress Theme-Specific Debugging

I'll provide WordPress-aware guidance:

### Common WordPress Issues

**Query Problems:**
- Check posts_per_page limits
- Verify tax_query syntax
- Check meta_query logic
- Review pre_get_posts filters

**Template Issues:**
- Check template hierarchy
- Verify get_template_part paths
- Check conditional tags
- Review template includes

**Hook Issues:**
- Check hook priority
- Verify hook names
- Check number of args
- Review add_action vs add_filter

**Performance:**
- Check for N+1 queries
- Review transient usage
- Check cache effectiveness
- Profile with Query Monitor

**Security:**
- Check nonce verification
- Verify capability checks
- Review data sanitization
- Test with different user roles

### Debugging Tools

**WordPress:**
- Enable WP_DEBUG
- Enable WP_DEBUG_LOG
- Use Query Monitor plugin
- Enable SAVEQUERIES

**PHP:**
- Use error_log()
- Use var_dump() / var_export()
- Enable Xdebug
- Check PHP error logs

**JavaScript:**
- Console.log()
- Browser DevTools
- React DevTools (if applicable)
- Network tab inspection

**Database:**
- Query logs
- EXPLAIN queries
- Check indexes
- Review table structure

## Best Practices

### What Makes Good Debugging

✅ **DO:**
- Start with clear problem statement
- Gather evidence before theorizing
- Test one hypothesis at a time
- Document findings as you go
- Write tests to prevent regression
- Consider multiple solutions
- Think about future impact

❌ **DON'T:**
- Jump straight to coding
- Guess without evidence
- Change multiple things at once
- Skip reproduction steps
- Ignore edge cases
- Forget to test the fix
- Leave debugging code in production

### Debugging Checklist

Before finishing debugging:
- [ ] Issue clearly documented
- [ ] Root cause identified
- [ ] Fix plan agreed upon
- [ ] Test case written
- [ ] Fix implemented
- [ ] Tests passing
- [ ] No new issues introduced
- [ ] Documentation updated

## Related Commands

During debugging:
- Use `/check-implementation` to verify fix
- Use `/write-test` to add regression tests
- Use `/review-code` before deploying fix

After fixing:
- Use `/update-planning` to document issue
- Use `/handoff-qa` if deploying to QA

---

## ✨ Next Command

After completing `/debug-issue`:

**This command is used anytime issues arise during the workflow.**

**After fixing the issue, return to where you were:**

- **During `/execute-plan`?** → Continue with `/execute-plan` or move to `/check-implementation`
- **During `/check-implementation`?** → Re-run `/check-implementation` to verify the fix
- **During `/write-test`?** → Add regression tests, then continue to `/review-code`
- **During `/review-code`?** → Re-run `/review-code` after fixes
- **After QA feedback?** → Fix the issue, add tests, then run `/handoff-qa` again

**Always after debugging:**
1. Run `/write-test` to add regression tests that prevent the issue from recurring
2. Run `/check-implementation` to ensure the fix aligns with requirements
3. Continue with your normal workflow from where you left off

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-10-31  
**Compatible With**: Cursor AI Editor

