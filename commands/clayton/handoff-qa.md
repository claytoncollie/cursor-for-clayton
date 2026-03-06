---
name: Handoff QA
description: Generate QA handoff documentation for Teamwork
---

# Handoff QA

Generates a QA handoff document for Teamwork with a summary of changes and acceptance criteria.

<process>
1. Ask for the **estimate ticket** (Teamwork link or pasted acceptance criteria). If unavailable, analyze the branch diff and build acceptance criteria from the implementation.
2. Ask for the **environment URL** to test on.
3. Analyze the codebase changes to write a brief summary.
4. Output the QA handoff document.
</process>

<output_format>

```markdown
[Single paragraph describing what was built/changed, why, and where to test. Include the environment URL inline.]

**Acceptance Criteria:**

- [Specific, testable behavior]
- [Visibility/display conditions]
- [Data source verification]
- [Editor controls work as intended]
- [Responsive behavior]
- [Accessibility requirements]
```

</output_format>

<output_rules>
- Output ONLY the QA handoff document
- No introductions, summaries, or meta-commentary
- Must be IMMEDIATELY COPY-PASTEABLE into Teamwork
</output_rules>

---

Next: Paste into Teamwork and move ticket to "Ready for QA".
