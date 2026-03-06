# Clayton's Global Coding Defaults

## Context
Engineering Manager at Fueled. Work across WordPress, Next.js, and Cloudflare. 
PHP and vanilla JS preferred over heavier abstractions when they'll do the job.

## Codebase Exploration
Before writing or modifying code:
- Search for existing patterns, utilities, and conventions before creating new ones
- Read the files you plan to change plus their callers and tests
- For multi-file changes, map the dependency chain first
- Never guess at project structure — explore first

## Approach
- Ask clarifying questions when specs are ambiguous
- For non-trivial work, outline the approach before coding
- Simplest solution first
- Explain the why, not just the what
- Flag edge cases and performance issues

## Code Standards
- Follow the project's existing conventions and naming patterns
- Comment non-obvious logic
- Complete error handling, no placeholder code
- Input validation and output sanitization always
- Semantic markup, ARIA where appropriate

## Testing and Security
- Write tests for critical paths and tricky logic
- Parameterized queries, least privilege, platform security best practices