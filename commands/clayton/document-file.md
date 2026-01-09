---
name: Document File
description: Generate PHP DocBlocks for undocumented files with smart preservation of existing documentation
---

# Document File

Analyzes PHP files to generate intelligent DocBlocks for files, classes, and methods missing documentation. Preserves existing documentation while adding new DocBlocks where needed.

Use @file to reference the target file directly.

## When to Use

- After creating new PHP classes or functions
- When onboarding to undocumented code
- Before code reviews to improve documentation quality
- During code cleanup or refactoring

## Usage

```bash
/clayton/document-file [filepath]
```

## Process

### Step 1: Read and Analyze

1. Read the target file completely
2. Identify existing DocBlocks to preserve
3. List undocumented elements (file, classes, methods)
4. Analyze file's role in the project structure

### Step 2: Generate DocBlocks

**File DocBlock:**
```php
/**
 * [Brief description of file's purpose]
 *
 * @package App\[Namespace]
 */
```

**Class DocBlock:**
```php
/**
 * [Clear description of class purpose]
 *
 * Explains responsibilities and system integration.
 */
```

**Method DocBlock:**
```php
/**
 * [Concise method description]
 *
 * @param Type $paramName Description of parameter
 * @return Type Description of return value
 * @throws ExceptionType When exception occurs
 */
```

### Step 3: Quality Check

- Verify DocBlock syntax is valid PHP
- Ensure parameter types match signatures
- Validate @throws tags against actual exceptions
- Confirm descriptions are meaningful (not just repeating names)

### Step 4: Apply Changes

1. Insert DocBlocks at appropriate locations
2. Preserve all existing code and documentation
3. Add TODO markers for complex logic needing manual review

## What NOT to Document

- **WordPress core functions** (esc_attr, esc_html, wp_enqueue_script, get_option)
- **PHP standard library** (array_map, json_encode)
- **Common third-party utilities**

Focus only on custom business logic and application-specific code.

## TODO Markers

Add markers for items requiring human review:
```php
/**
 * Processes payment transactions
 *
 * <!-- TODO: Document edge cases for failed transactions -->
 *
 * @param array $payment_data Payment information
 * @return bool Success status
 */
```

## Output Format

```markdown
## Documentation Summary

**File:** [filepath]

**Added:**
- File-level DocBlock
- Class DocBlock for [ClassName]
- Method DocBlocks: [method1], [method2], [method3]

**Preserved:** [N] existing DocBlocks unchanged

**TODO Markers:** [N] items flagged for manual review

**Next Steps:**
1. Review TODO markers
2. Verify exception types
3. Commit documented file
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

This is a standalone utility command. Use anytime you need to document PHP files.
