---
name: Generate Cursor Rules
description: Generate comprehensive Cursor AI rules tailored to your WordPress project structure and documentation
author: Clayton Collie
version: 1.0.0
tags: [cursor, rules, configuration, wordpress, documentation, ai-setup]
---

# Generate Cursor Rules - Project-Specific AI Configuration

## Command Purpose

Analyzes your WordPress project structure and generates comprehensive Cursor AI rules that provide context about your project's architecture, coding standards, and documentation. The generated rules help the AI understand your codebase patterns and provide better assistance.

**This command combines:**
- **Velcro-style structure**: Multiple MDC files with frontmatter (`alwaysApply`, `globs`, `description`) for organized, file-specific rules
- **Digital Science comprehensive content**: Detailed WordPress best practices for PHP, JavaScript, CSS, blocks, security, performance, and more
- **Project-specific discovery**: Custom blocks, post types, taxonomies, naming conventions, and build commands from your actual codebase

## ⚠️ Important: Run `/document-project` First

**This command should always be run AFTER `/document-project`.**

### Recommended Workflow

```bash
# Step 1: Generate/update project documentation
/document-project

# Step 2: Generate Cursor rules that reference the documentation
/generate-cursor-rules
```

**Why this order matters:**
1. `/document-project` creates or updates your project's documentation files
2. `/generate-cursor-rules` discovers and links to those documentation files
3. Running them in this order ensures your Cursor rules reference up-to-date, existing documentation
4. The rules will include `mdc:` links to the docs created by `/document-project`

**These commands work together** to provide comprehensive AI context about your project.

## Usage

```bash
# First, ensure documentation is current
/document-project

# Then, generate rules that reference that documentation
/generate-cursor-rules
```

The command will analyze your project and generate 8 MDC files in `.cursor/rules/`.

## When to Use This Command

Use `/generate-cursor-rules` for:
- **New projects** needing comprehensive AI context (after running `/document-project`)
- **Onboarding teammates** who use Cursor AI
- **After major refactors** that change project structure
- **After running `/document-project`** to refresh rules with updated doc links
- **Migrating from another editor** and setting up Cursor for the first time

**Always run `/document-project` first** to ensure documentation exists before generating rules.

## How It Works

This command follows a structured 5-step workflow to generate comprehensive, project-aware rules.

## Step 1: Analyze Project Structure

I'll examine your project to understand:

### WordPress Project Type
- **Theme Project**: Custom WordPress theme
- **Plugin Project**: WordPress plugin development
- **Full Site**: Complete WordPress installation
- **Multisite**: WordPress multisite setup
- **Headless**: Decoupled WordPress with separate frontend

### Directory Structure
I'll map out key directories:
- `wp-content/themes/` - Theme files and directories
- `wp-content/plugins/` - Custom plugins
- `wp-content/mu-plugins/` - Must-use plugins
- `blocks/` or `includes/blocks/` - Custom Gutenberg blocks
- `templates/` - Page templates and template parts
- `partials/` - Reusable PHP components
- `patterns/` - Block patterns
- `inc/` - Theme includes and utilities
- `assets/` - CSS, JavaScript, images, fonts
- `docs/` - Project documentation

### Technology Stack
I'll identify:
- **PHP Version**: Minimum required version
- **WordPress Version**: Compatible WordPress versions
- **Node.js**: Build tools and dependencies
- **Build Tools**: webpack, Gulp, Parcel, 10up-toolkit, etc.
- **CSS Preprocessors**: Sass, PostCSS, Less
- **JavaScript Framework**: Vanilla JS, React (Gutenberg), Vue
- **Package Managers**: npm, Yarn, Composer
- **Testing Tools**: PHPUnit, Jest, Cypress
- **Code Quality**: PHPCS, ESLint, Stylelint

## Step 2: Discover Documentation

**Note:** For best results, run `/document-project` before this command to ensure documentation exists.

I'll search for existing documentation with a flexible approach:

### Search for Documentation Directories
Look for any of these common patterns:
- `docs/`, `doc/`, `documentation/` - Main documentation directory
- `.github/docs/` - GitHub documentation
- `wiki/` - Wiki-style documentation
- Any directory containing multiple `.md` files

### Discover Documentation Files
**Don't assume specific file names.** Instead:
- Search recursively for all `.md` files
- Read the content to understand what each file documents
- Categorize by actual content, not filename
- Common categories to look for:
  - **Architecture/Overview**: Project structure, components, design decisions
  - **Setup/Installation**: Dependencies, requirements, initial setup
  - **Build/Development**: Build commands, dev tools, local environment
  - **Workflow**: Git process, deployment, testing, code review
  - **Components**: Blocks, post types, taxonomies, utilities, patterns
  - **APIs/Integrations**: REST endpoints, third-party services, data structures
  - **Standards**: Coding conventions, style guides, best practices

### Check for README Files
- Root `README.md` - Often the main entry point
- Subdirectory READMEs (themes, plugins, components, blocks)
- Any markdown files serving as documentation entry points

### Adapt to What Actually Exists
- Use actual file names found, not assumed names
- If a project has `SETUP.md` instead of `installation.md`, use that
- If docs are in `documentation/` instead of `docs/`, use that path
- If no docs directory exists, note it (don't create placeholder links)

### Check for Inline Documentation
- PHP DocBlocks in key files
- JavaScript JSDoc comments  
- Block metadata in `block.json` files
- Inline comments explaining patterns

## Step 3: Identify Patterns and Conventions

I'll analyze your codebase to understand:

### Naming Conventions
- **Functions**: Prefixes, snake_case vs camelCase
- **Classes**: Namespaces, PascalCase patterns
- **Files**: Kebab-case, underscores, organization
- **Constants**: Prefix patterns, naming standards
- **Blocks**: Block naming (e.g., `namespace/block-name`)
- **Post Types**: Prefix patterns (e.g., `prefix-post-type`)
- **Taxonomies**: Taxonomy naming conventions
- **CSS Classes**: BEM, utility-first, custom patterns

### Code Organization
- **File Structure**: How components are organized
- **Includes Pattern**: How utilities are loaded
- **Autoloading**: Composer autoloader usage
- **Module Pattern**: Class-based vs functional approach

### Custom Fields
- **ACF**: Advanced Custom Fields usage
- **Field Manager**: Field Manager implementation
- **Meta Boxes**: Custom meta box patterns
- **Custom Tables**: Database extensions

### Query Patterns
- **WP_Query**: Common query structures
- **Custom Queries**: Specialized data retrieval
- **Caching**: Object cache, transients, fragment caching
- **Performance**: Query optimization patterns

## Step 4: Gather Project-Specific Context

I'll ask you for:

### Project Information
- **Project Name**: Client or theme name
- **Description**: Brief project overview
- **Key Features**: Main functionality and capabilities
- **Target Audience**: Who uses this (editors, visitors, developers)

### Custom Post Types
- List of custom post types and their purpose
- Associated taxonomies
- Custom fields and relationships

### Custom Blocks
- List of custom Gutenberg blocks
- Block categories and organization
- Nested block patterns
- Block variations and styles

### Key Integrations
- Third-party APIs (e.g., Mailchimp, Stripe)
- External services
- CDNs or asset delivery
- Analytics and tracking

### Development Standards
- **Code Style**: Specific style guide being followed
- **Testing Requirements**: Coverage expectations
- **Review Process**: PR requirements and checks
- **Deployment**: How code gets to production

## Step 5: Locate Git Root and Create Rules Directory

I'll find the git root for your project:

### Finding Git Root
- Run `git rev-parse --show-toplevel` to find repository root
- For WordPress projects, typically `wp-content/` directory
- For non-standard projects, use the actual git root
- Verify the location before creating files

### Create Rules Directory
- Create `.cursor/rules/` directory at git root
- Example: `wp-content/.cursor/rules/` for WordPress themes/plugins
- Example: `/project-root/.cursor/rules/` for non-standard structures

## Step 6: Generate Multiple MDC Rules Files

I'll create multiple MDC (Markdown with Cursor metadata) files following a structured approach:

### MDC Files Structure

I'll create the following files in `.cursor/rules/`:

#### File 1: `00-rules-overview.mdc`
```markdown
---
alwaysApply: false
description: Overview of all Cursor rules for [Project Name]
---

# Cursor Rules Overview

This directory contains comprehensive Cursor rules for the [Project Name] project. These rules provide context, standards, and best practices for AI-assisted development.

## Rule Structure

### Always Applied Rules

These rules are automatically applied to every request:

- **01-project-architecture.mdc** - Core project structure and architecture
- **05-development-workflow.mdc** - Git workflow and deployment process

### File-Specific Rules  

These rules apply based on file patterns (globs):

- **02-php-wordpress-standards.mdc** - PHP and WordPress coding standards (`*.php`)
- **03-custom-blocks.mdc** - Custom WordPress blocks development (`blocks/**/*`)
- **04-content-types.mdc** - Post types, taxonomies, custom fields (`content/**/*`)
- **06-theme-build-process.mdc** - Asset building and theme development (`themes/**/*`)
- **07-frontend-standards.mdc** - JavaScript and CSS standards (`*.js,*.scss,*.css`)

### Manual Rules

- **00-rules-overview.mdc** - This overview file (manual reference)

## Quick Reference Links

### Project Documentation

[Only include links to docs that actually exist. Discover actual file names and paths.]

Example (adapt to actual files found):
- [Architecture Overview](mdc:path/to/actual-doc.md) - Brief description of what this doc covers
- [Setup Guide](mdc:path/to/actual-setup.md) - Brief description
- [Development Workflow](mdc:path/to/actual-workflow.md) - Brief description
- [Component Reference](mdc:path/to/actual-components.md) - Brief description

[If no docs exist, omit this section or note: "Documentation to be created"]

### Key Project Components

[Identify and link to main theme/plugin]

- **Main Theme**: [theme-name](mdc:path/to/theme)
- **Custom Blocks**: [blocks](mdc:path/to/blocks)
- **Content Types**: [content](mdc:path/to/content)

### Development Commands

```bash
# Node version (if .nvmrc exists)
nvm use

# PHP linting
composer run lint

# Asset building  
npm run build
npm run watch

# Code quality
npm run lint-js
npm run lint-style
```

## Rule Usage Tips

### For New Developers

1. Start with **01-project-architecture.mdc** for overall understanding
2. Review **05-development-workflow.mdc** for Git and deployment process
3. Reference specific rules based on the type of work you're doing

### For Specific Tasks

- **PHP Development**: Reference rules 01, 02, and 04
- **Block Development**: Reference rules 01, 03, and 07  
- **Frontend Work**: Reference rules 01, 06, and 07
- **Content Types**: Reference rules 01, 02, and 04
- **Deployment**: Reference rule 05

## Project Philosophy

- **WordPress Standards**: Follow WordPress coding standards strictly
- **Code Quality**: Automated linting, testing, and review processes
- **Accessibility**: WCAG 2.1 AA compliance required
- **Performance**: Optimize for Core Web Vitals and user experience
```

#### File 2: `01-project-architecture.mdc`
```markdown
---
alwaysApply: true
description: [Project Name] architecture and structure guide
---

# [Project Name] - Project Architecture

[Brief project description. Link to architecture/overview doc if one exists, using actual file path found.]

## Project Structure

### Core Components

- **Main Theme**: [theme-name](mdc:path/to/theme)
- **Key Directories**:
  - `/blocks/` or `/includes/blocks/` - Custom Gutenberg blocks
  - `/templates/` - Page templates and template parts
  - `/partials/` - Reusable PHP components
  - `/inc/` - Theme functions and utilities
  - `/assets/` - CSS, JavaScript, images, fonts

### Key Technologies

- **Node.js**: [version from .nvmrc]
- **Custom Fields**: [ACF/Field Manager/None]
- **Build Tool**: [webpack/Gulp/10up-toolkit]

### Architecture Patterns

- **Namespace**: [discovered namespace pattern]
- **Constants**: [discovered constant pattern]
- **Autoloading**: [Composer/manual/none]
- **Modular includes**: [pattern description]

### Custom Content Structure

- **Post Types**: [List custom post types]
- **Taxonomies**: [List custom taxonomies]
- **Custom Blocks**: [List custom blocks]

## Key File Locations

[Map out actual directory structure]
```

#### File 3: `02-php-wordpress-standards.mdc`
```markdown
---
globs: *.php
description: PHP and WordPress coding standards for [Project Name]
---

# PHP & WordPress Coding Standards

## WordPress Coding Standards

Follow **WordPress Coding Standards** strictly. The project uses PHP_CodeSniffer with WordPress rules.

### Code Quality Commands

```bash
composer run lint      # Check PHP code style
composer run lint-fix  # Auto-fix PHP code style issues
```

## Project-Specific Naming Conventions

### Namespaces

- **Theme/Plugin**: [discovered namespace pattern, e.g., `VelcroTheme\` or `TenUp\ProjectName\`]
- **Classes**: PascalCase (e.g., `NavigationSupport`, `HatchSupport`)
- **Methods**: camelCase within classes

### Constants

[Show discovered constant patterns, e.g.:]
- **Prefix**: `{PREFIX}_CONSTANT_NAME`
- Example: `VELCRO_THEME_VERSION`, `VELCRO_THEME_PATH`

### Functions

- **Global Functions**: `{prefix}_function_name()` (snake_case with prefix)
- **Class Methods**: `camelCase` or `snake_case` based on project convention

### Custom Post Types & Taxonomies

- **Prefix**: [discovered prefix, e.g., `vel-`, `prefix-`]
- **Post Types**: `{prefix}-post-type` (kebab-case with prefix)
- **Taxonomy**: `{prefix}-taxonomy` (kebab-case with prefix)

## Namespacing

All PHP code outside of theme templates should be properly namespaced:

```php
<?php
namespace [ProjectNamespace]\Feature;

class ExampleClass {
    // ...
}
```

### Importing Classes

Use the `use` statement to import classes from other namespaces:

```php
<?php
namespace [ProjectNamespace]\Feature;

use [ProjectNamespace]\Common\Utility;

class ExampleClass {
    public function method() {
        $utility = new Utility();
    }
}
```

## Object-Oriented Programming

### Class Structure

- One class per file
- Class names should match filenames
- Properties and methods should have appropriate visibility (public, protected, private)
- Use `protected` instead of `private` for better extensibility

```php
<?php
namespace [ProjectNamespace]\Feature;

/**
 * Example class for feature implementation.
 *
 * @package [ProjectNamespace]
 */
class ExampleClass {
    /**
     * Example property documentation.
     *
     * @var string
     */
    protected $property;

    /**
     * Constructor.
     */
    public function __construct() {
        $this->setup_hooks();
    }

    /**
     * Set up hooks for this feature.
     */
    private function setup_hooks() {
        add_action( 'init', [ $this, 'register' ] );
    }

    /**
     * Example method documentation.
     *
     * @param string $param Example parameter.
     * @return string Modified string.
     */
    public function method( $param ) {
        return $param . ' modified';
    }
}
```

## Docblocks and Comments

Every function, class, and method should have appropriate docblocks:

```php
<?php
/**
 * Short description of the function.
 *
 * Longer description of the function if needed,
 * spanning multiple lines.
 *
 * @since 1.0.0
 * @param string $param Description of the parameter.
 * @return string Description of the return value.
 */
function example_function( $param ) {
    // Function code
}
```

## Security Best Practices

### Input Validation and Sanitization

Always validate and sanitize user input:

```php
<?php
// Text field
$title = isset( $_POST['title'] ) ? sanitize_text_field( $_POST['title'] ) : '';

// Email field
$email = isset( $_POST['email'] ) ? sanitize_email( $_POST['email'] ) : '';

// URL field
$website = isset( $_POST['website'] ) ? esc_url_raw( $_POST['website'] ) : '';

// Integer field
$user_id = isset( $_POST['user_id'] ) ? absint( $_POST['user_id'] ) : 0;

// Textarea/HTML content
$content = isset( $_POST['content'] ) ? wp_kses_post( $_POST['content'] ) : '';
```

### Output Escaping

Always escape data when outputting:

```php
<?php
// Basic text
echo esc_html( $title );

// URLs in HTML attributes
echo '<a href="' . esc_url( $url ) . '">' . esc_html( $link_text ) . '</a>';

// HTML attributes
echo '<div class="' . esc_attr( $class_name ) . '">Content</div>';

// Structured HTML (limited tags)
echo wp_kses_post( $content );

// Translated text
echo esc_html__( 'Welcome to our site', 'textdomain' );
```

### Nonces for Form Security

```php
<?php
// Creating a form with a nonce
?>
<form method="post" action="">
    <?php wp_nonce_field( 'prefix_action_name', 'prefix_nonce' ); ?>
    <input type="text" name="data" value="">
    <input type="submit" value="Submit">
</form>
<?php

// Verifying the nonce on submission
if ( 
    isset( $_POST['prefix_nonce'] ) && 
    wp_verify_nonce( $_POST['prefix_nonce'], 'prefix_action_name' ) 
) {
    // Process the form
    $data = sanitize_text_field( $_POST['data'] );
} else {
    wp_die( esc_html__( 'Security check failed.', 'textdomain' ) );
}
```

### User Capability Checks

Always check user capabilities before performing privileged actions:

```php
<?php
// Check if user can edit posts
if ( current_user_can( 'edit_posts' ) ) {
    // Allow editing functionality
} else {
    wp_die( esc_html__( 'You do not have permission.', 'textdomain' ) );
}

// Check if user can edit a specific post
if ( current_user_can( 'edit_post', $post_id ) ) {
    // Allow editing of this specific post
}
```

### Database Query Security

Prevent SQL injection with proper query preparation:

```php
<?php
global $wpdb;

// Basic prepared statement
$results = $wpdb->get_results(
    $wpdb->prepare(
        "SELECT * FROM {$wpdb->posts} WHERE post_type = %s AND post_status = %s",
        'page',
        'publish'
    )
);

// Insert with prepared statement
$wpdb->insert(
    $wpdb->prefix . 'custom_table',
    array(
        'name' => $name,
        'email' => $email,
    ),
    array(
        '%s', // Format for name (string)
        '%s', // Format for email (string)
    )
);
```

## Performance Best Practices

### Database Query Optimization

```php
<?php
// Optimized WP_Query
$args = [
    'post_type'      => 'post',
    'posts_per_page' => 10,
    'no_found_rows'  => true,  // Skip counting total rows for pagination
    'fields'         => 'ids',  // Only get post IDs when that's all you need
    'post_status'    => 'publish',
    'orderby'        => 'date',
    'order'          => 'DESC',
    'cache_results'  => true,
    'update_post_meta_cache' => false,  // Skip post meta cache if not needed
    'update_post_term_cache' => false,  // Skip term cache if not needed
];

$query = new WP_Query( $args );
```

### Object Caching

```php
<?php
function get_expensive_data() {
    // Try to get from cache first
    $cache_key = 'prefix_expensive_data_' . $unique_identifier;
    $data = wp_cache_get( $cache_key, 'prefix_cache_group' );
    
    if ( false === $data ) {
        // Cache miss, generate the data
        $data = calculate_expensive_data();
        
        // Store in cache for later
        wp_cache_set( $cache_key, $data, 'prefix_cache_group', 3600 );
    }
    
    return $data;
}
```

### Transient API

```php
<?php
function get_remote_api_data( $param ) {
    $transient_key = 'prefix_api_data_' . md5( $param );
    $data = get_transient( $transient_key );
    
    if ( false === $data ) {
        // Cache miss, fetch fresh data
        $response = wp_remote_get( 'https://api.example.com/data?param=' . urlencode( $param ) );
        
        if ( ! is_wp_error( $response ) ) {
            $data = wp_remote_retrieve_body( $response );
            set_transient( $transient_key, $data, HOUR_IN_SECONDS );
        }
    }
    
    return $data;
}
```

## Avoid These Common Mistakes

❌ **Don't use PHP shorthand tags**
```php
<? echo $var; ?> // WRONG
<?= $var ?> // WRONG
<?php echo $var; ?> // CORRECT
```

❌ **Don't use non-prefixed global functions**
```php
function get_posts_data() {} // WRONG
function projectname_get_posts_data() {} // CORRECT
```

❌ **Don't use unescaped output**
```php
echo $user_input; // WRONG - Dangerous!
echo esc_html( $user_input ); // CORRECT
```

❌ **Don't skip nonce verification**
```php
// WRONG: No nonce verification
if ( isset( $_POST['delete'] ) ) {
    // Delete something
}

// CORRECT: With nonce verification
if ( 
    isset( $_POST['delete'] ) && 
    isset( $_POST['_wpnonce'] ) && 
    wp_verify_nonce( $_POST['_wpnonce'], 'delete_action' ) 
) {
    // Delete something
}
```

## Project-Specific Patterns

[Include discovered patterns from this codebase:]
- Module pattern examples
- Hook registration patterns
- Custom post type registration examples
- Custom field implementations
- Query patterns commonly used
```

#### File 4: `03-custom-blocks.mdc`
```markdown
---
globs: blocks/**/*,includes/blocks/**/*
description: Custom WordPress blocks development standards
---

# Custom Blocks Development

[Link to blocks documentation if it exists, using actual file path found.]

## Block Structure

### Location

- **Path**: [discovered blocks path]

### File Organization

Each custom block should follow this structure:

```
custom-blocks/{block-name}/
├── index.php          # Block registration
├── block.json         # Block definition
├── edit.js           # Editor component
├── save.js           # Frontend save
├── style.scss        # Block styles
└── editor.scss       # Editor-specific styles
```

## Existing Custom Blocks

[List all discovered custom blocks with descriptions]

### Core Blocks
- **Block Name** - Description (Location: path)

### Nested Block Pattern
[If nested blocks are discovered, show parent/child relationships]

## Block Development Standards

[Show discovered block registration patterns from codebase]
```

#### File 5: `04-content-types.mdc`
```markdown
---
globs: content/**/*,inc/post-types/**/*,inc/taxonomies/**/*,includes/content/**/*
description: Custom post types, taxonomies, and custom fields implementation
---

# Content Types & Custom Fields

[Link to content types documentation if it exists, using actual file path found.]

## Custom Post Types

### Existing Post Types

| Post Type | Slug | Location |
|-----------|------|----------|
[Discovered post types with file paths]

### Custom Post Type Standards

- **Prefix**: Always use `{prefix}-` prefix
- **Location**: [discovered pattern]
- **Registration**: Use `register_post_type()` with proper arguments

## Custom Taxonomies

### Existing Taxonomies

| Taxonomy | Slug | Post Types | Location |
|----------|------|------------|----------|
[Discovered taxonomies with associations]

## Custom Fields Implementation

[Describe ACF/Field Manager/custom implementation discovered]

### Field Pattern

[Show example from codebase]
```

#### File 6: `05-development-workflow.mdc`
```markdown
---
alwaysApply: true
description: Git workflow, deployment process, and development standards
---

# Development Workflow & Deployment

[Link to workflow/deployment documentation if it exists, using actual file path found.]

## Repository & Branches

### Repository

- **URL**: [if discoverable from git remote]
- **Primary Branches**:
  - `main` or `master` - Production deployments
  - [other branches if discovered]

## Code Quality Standards

### Automated Checks

```bash
# PHP linting
composer run lint

# JavaScript linting  
npm run lint-js

# CSS linting
npm run lint-style

# Build assets
npm run build
```

[Include actual commands discovered from package.json and composer.json]
```

#### File 7: `06-theme-build-process.mdc`
```markdown
---
globs: themes/**/*,*.scss,*.js,*.css
description: Theme development, asset building, and frontend workflow
---

# Theme Development & Build Process

[Link to build/development documentation if it exists, using actual file path found.]

## Node Version Requirements

### Version Management

```bash
# Use correct Node version
nvm use
```

**Requirements**:
- Node.js: [version from .nvmrc]

## Build Commands

### Development Workflow

```bash
npm run start      # Start development watch
npm run watch      # Watch files and rebuild
npm run build      # Build production assets
```

[Include actual commands from package.json]

## Asset Output Structure

[Describe discovered asset structure]
```

#### File 8: `07-frontend-standards.mdc`
```markdown
---
globs: *.js,*.ts,*.jsx,*.tsx,*.scss,*.css
description: JavaScript, TypeScript, and CSS coding standards
---

# Frontend Coding Standards

## JavaScript Standards

**Do not write jQuery.** Use modern vanilla JavaScript or React (for Gutenberg blocks).

### ESLint Configuration

```bash
npm run lint-js    # Check JavaScript
npm run format-js  # Auto-format with Prettier
```

### Code Style

- **ES6+ Features**: Use modern JavaScript syntax
- **Const/Let**: Prefer `const`, use `let` when reassignment needed
- **Arrow Functions**: Use arrow functions for callbacks and short functions
- **Template Literals**: Use backticks for string interpolation
- **Destructuring**: Use object/array destructuring where appropriate

```javascript
// GOOD: Modern JavaScript
const clickHandler = (e) => {
  console.log('Clicked', e.target);
};

const message = `Welcome to ${siteName}!`;

const { id, title } = post;

const newArray = [...oldArray, newItem];
```

### Modules and Imports

Use ES6 module syntax:

```javascript
// GOOD: ES6 modules
import { addClass, removeClass } from './utils/dom';

// Named export
export const init = () => {
  // Function implementation
};

// Default export
export default class FeatureComponent {
  // Class implementation
}
```

### Component-Based Architecture

```javascript
// GOOD: Component-based approach
class TabComponent {
  constructor(element) {
    this.element = element;
    this.tabs = element.querySelectorAll('.tab');
    this.panels = element.querySelectorAll('.tab-panel');
    this.bindEvents();
  }
  
  bindEvents() {
    this.tabs.forEach(tab => {
      tab.addEventListener('click', () => this.activateTab(tab));
    });
  }
  
  activateTab(tab) {
    // Implementation
  }
}

// Initialize
document.querySelectorAll('.tab-container').forEach(el => {
  new TabComponent(el);
});
```

### WordPress Block Editor (Gutenberg)

When developing custom blocks:

```javascript
// GOOD: Block registration
import { registerBlockType } from '@wordpress/blocks';
import { useBlockProps } from '@wordpress/block-editor';

registerBlockType('namespace/block-name', {
  edit: ({ attributes, setAttributes }) => {
    const blockProps = useBlockProps();
    
    return (
      <div {...blockProps}>
        {/* Block editor UI */}
      </div>
    );
  },
  
  save: ({ attributes }) => {
    const blockProps = useBlockProps.save();
    
    return (
      <div {...blockProps}>
        {/* Saved content */}
      </div>
    );
  },
});
```

### Performance Best Practices

```javascript
// GOOD: Event delegation
document.querySelector('.menu').addEventListener('click', (e) => {
  if (e.target.matches('.menu-item')) {
    handleMenuItemClick(e.target);
  }
});

// GOOD: Debounce for expensive operations
const debounce = (fn, delay) => {
  let timer;
  return function() {
    clearTimeout(timer);
    timer = setTimeout(() => fn.apply(this, arguments), delay);
  };
};

window.addEventListener('resize', debounce(() => {
  recalculateLayout();
}, 150));

// GOOD: DOM caching
const header = document.querySelector('.site-header');
const toggleBtn = document.querySelector('.toggle-button');
const menuItems = document.querySelectorAll('.menu-item');

toggleBtn.addEventListener('click', () => {
  header.classList.toggle('menu-open');
});
```

### Avoid These JavaScript Mistakes

❌ **Don't use global variables**
```javascript
// WRONG
var globalCounter = 0;
function incrementCounter() {
  globalCounter++;
}

// CORRECT
const counter = (function() {
  let count = 0;
  return {
    increment: () => ++count,
    getCount: () => count
  };
})();
```

❌ **Don't use jQuery when vanilla JS will do**
```javascript
// WRONG
$('.element').addClass('active');

// CORRECT
document.querySelector('.element').classList.add('active');
```

❌ **Don't use document.write()**
```javascript
// WRONG
document.write('<script src="example.js"></script>');

// CORRECT
const script = document.createElement('script');
script.src = 'example.js';
document.head.appendChild(script);
```

## CSS/SCSS Standards

### Stylelint Configuration

```bash
npm run lint-style # Check CSS/SCSS
```

### Project-Specific CSS Methodology

[Discovered methodology: BEM / utility-first / custom approach]

### BEM Naming Convention

If using BEM methodology:

```css
/* Block */
.card {
  background: #fff;
  border-radius: 2px;
}

/* Element */
.card__title {
  font-size: 1.5rem;
}

/* Modifier */
.card--featured {
  border-left: 5px solid #2271b1;
}
```

### SCSS Organization

```scss
// 1. Variables and mixins at top
$color-primary: #0073aa;
$breakpoint-tablet: 768px;

// 2. Mixins
@mixin button-style {
  padding: 10px 20px;
  border-radius: 4px;
}

// 3. Block styles
.component-name {
  @include button-style;
  color: $color-primary;
  
  // 4. Nested elements
  &__element {
    font-weight: bold;
  }
  
  // 5. Modifiers
  &--modifier {
    background-color: $color-primary;
  }
  
  // 6. Media queries at end
  @media (min-width: $breakpoint-tablet) {
    padding: 15px 30px;
  }
}
```

### Responsive Design Standards

Mobile-first approach:

```scss
// GOOD: Mobile-first
.component {
  // Mobile styles (default)
  padding: 1rem;
  
  // Tablet up
  @media (min-width: 768px) {
    padding: 1.5rem;
  }
  
  // Desktop up  
  @media (min-width: 1024px) {
    padding: 2rem;
  }
  
  // Large desktop up
  @media (min-width: 1200px) {
    padding: 2.5rem;
  }
}
```

### CSS Custom Properties

Use CSS custom properties for theme consistency:

```scss
:root {
  --color-primary: #0073aa;
  --color-secondary: #005a87;
  --font-size-base: 1rem;
  --spacing-unit: 1rem;
}

.component {
  color: var(--color-primary);
  font-size: var(--font-size-base);
  margin-bottom: var(--spacing-unit);
}
```

### Block Editor Styles

Separate styles for block editor:

```scss
// style.scss - Frontend styles
.wp-block-namespace-custom-block {
  // Frontend appearance
}

// editor.scss - Backend editor styles  
.wp-block-namespace-custom-block {
  // Editor-specific styling
  border: 1px dashed #ddd;
  
  .block-editor-inner-blocks & {
    // Nested block styling
  }
}
```

## Accessibility Standards

### JavaScript Accessibility

- **Keyboard Navigation**: Support tab navigation
- **ARIA Labels**: Add appropriate ARIA attributes
- **Screen Readers**: Test with screen reader tools
- **Focus Management**: Handle focus for dynamic content

```javascript
// GOOD: Accessibility patterns
const button = document.querySelector('.toggle-button');
button.setAttribute('aria-expanded', 'false');

button.addEventListener('click', function() {
  const expanded = this.getAttribute('aria-expanded') === 'true';
  this.setAttribute('aria-expanded', !expanded);
});
```

### CSS Accessibility

- **Focus States**: Always provide visible focus indicators
- **Color Contrast**: Meet WCAG 2.1 AA standards (4.5:1 ratio)
- **Reduced Motion**: Respect `prefers-reduced-motion`
- **High Contrast**: Support high contrast mode

```scss
.button {
  // Default styles
  
  &:focus {
    outline: 2px solid var(--color-primary);
    outline-offset: 2px;
  }
  
  @media (prefers-reduced-motion: reduce) {
    animation: none;
    transition: none;
  }
}
```

## Performance Guidelines

### CSS Performance

- **Critical CSS**: Inline critical above-the-fold styles
- **Unused CSS**: Remove unused styles regularly
- **Minification**: Ensure assets are minified in production
- **Concatenation**: Combine related stylesheets when possible

### JavaScript Performance  

- **Tree Shaking**: Remove unused JavaScript code
- **Code Splitting**: Load JavaScript when needed
- **Async Loading**: Use async/defer for non-critical scripts
- **Web Vitals**: Monitor Core Web Vitals metrics

## Project-Specific Patterns

[Include discovered patterns from this codebase:]
- Component initialization patterns
- Event handling patterns
- Block editor integration examples
- CSS utility classes used
- Animation/transition patterns
```

## Output Location

All rules will be created in `.cursor/rules/` directory at the git root:

- **WordPress Projects**: Typically `wp-content/.cursor/rules/`
- **Non-standard Projects**: `[git-root]/.cursor/rules/`

The command will create 8 MDC files:
1. `00-rules-overview.mdc` - Overview and quick reference
2. `01-project-architecture.mdc` - Core structure (alwaysApply: true)
3. `02-php-wordpress-standards.mdc` - PHP rules (globs: *.php)
4. `03-custom-blocks.mdc` - Block rules (globs: blocks/**/*)
5. `04-content-types.mdc` - Content rules (globs: content/**/*)
6. `05-development-workflow.mdc` - Workflow (alwaysApply: true)
7. `06-theme-build-process.mdc` - Build rules (globs: themes/**/*)
8. `07-frontend-standards.mdc` - Frontend rules (globs: *.js,*.scss,*.css)

## Best Practices

### What Makes Good Cursor Rules

✅ **DO:**
- Reference actual project files and directories
- Discover and link to existing documentation (use actual file paths found)
- Include concrete examples from the codebase
- Be specific about naming conventions actually used
- List actual custom post types, blocks, and components
- Include common development commands
- Reference technology versions from package.json/composer.json
- Keep rules updated as project evolves
- Search flexibly for documentation (any directory, any filename)
- Read doc content to understand purpose, not just filenames

❌ **DON'T:**
- Create generic rules that don't match the project
- Link to docs that don't exist (discover actual files first)
- Assume specific doc filenames (like "project-overview.md")
- Copy rules from other projects without verification
- Include outdated technology references
- Forget to update rules after major refactors
- Over-complicate with unnecessary detail
- Ignore existing coding standards in the codebase
- Assume docs are in a specific directory structure

### Rules Quality Checklist

Before finalizing, verify:
- [ ] All file paths reference actual directories
- [ ] Documentation links point to existing files
- [ ] Naming conventions match actual usage in code
- [ ] Custom post types list is complete and accurate
- [ ] Custom blocks list includes all blocks
- [ ] Technology versions match package.json/composer.json
- [ ] Development commands work and are up-to-date
- [ ] Security and performance guidelines are relevant
- [ ] Code examples are from the actual codebase
- [ ] Rules don't contradict existing patterns

## Implementation Notes

When executing this command:

1. **Explore First**: Read through key files to understand actual patterns
2. **Discover Documentation Flexibly**: 
   - Search recursively for `.md` files in common locations
   - Read file content to understand what it documents (don't rely on filenames)
   - Use actual file paths found, not assumed paths
   - If docs exist but in unexpected locations, use those paths
   - If no docs exist, note it (don't create placeholder links to non-existent files)
3. **Be Accurate**: Don't assume conventions, discover them from the code
4. **Use Examples**: Pull real code examples from the codebase
5. **Stay Current**: Check package.json, composer.json for versions
6. **Test Links**: Verify mdc: links point to actual files that exist
7. **Get Confirmation**: Ask user to verify discovered patterns
8. **Offer Updates**: Suggest updating rules when project changes

### Documentation Discovery Strategy

- Start broad: Search for any `.md` files recursively
- Read first few lines of each file to understand its purpose
- Categorize by content, not filename
- Examples of flexible linking:
  - If found: `docs/setup.md` → link as `[Setup Guide](mdc:docs/setup.md)`
  - If found: `README-DEVELOPMENT.md` → link as `[Development Guide](mdc:README-DEVELOPMENT.md)`
  - If found: `.github/CONTRIBUTING.md` → link as `[Contributing](.github/CONTRIBUTING.md)`
  - If not found: Don't include placeholder links

## Example Usage Session

```
User: /document-project

[AI generates/updates project documentation in docs/ directory]

✅ Documentation created/updated in docs/ directory

User: /generate-cursor-rules

AI: I'll analyze your project structure and generate Cursor AI rules. Let me start by finding the git root and exploring your WordPress project.

[AI runs: git rev-parse --show-toplevel]

AI: Found git root at: /path/to/wp-content

[AI explores directories, reads key files, checks for documentation]

AI: I've discovered:
- WordPress Theme Project (velcro-theme)
- Git root: wp-content/
- Node.js v20 with webpack build process
- Custom blocks in themes/velcro-theme/includes/blocks/custom-blocks/
- Custom post types: vel-product, vel-bus-industry, vel-bus-product
- Field Manager for custom fields (not ACF)
- Documentation found:
  - docs/project-overview.md (architecture)
  - docs/build-and-development.md (build commands)
  - docs/development-workflow.md (Git/deployment)
  - docs/content-types.md (post types/taxonomies)
  - docs/block-editor.md (custom blocks)
  - docs/themes.md (theme structure)
- PHPCS + ESLint configured

Before I finalize, please confirm these discoveries:
- Main theme prefix: vel-
- Build commands: npm run build, npm run watch
- Field Manager (not ACF) for custom fields
- PHP namespace: VelcroTheme\
- Rules location: wp-content/.cursor/rules/

User: Confirmed

AI: Perfect! I'll generate multiple MDC rules files in wp-content/.cursor/rules/

[Generates 8 MDC files with all project-specific rules]

✅ Generated Cursor rules in wp-content/.cursor/rules/

Files created:
1. 00-rules-overview.mdc - Overview and quick reference
2. 01-project-architecture.mdc - Project structure (always applied)
3. 02-php-wordpress-standards.mdc - PHP coding standards (*.php)
4. 03-custom-blocks.mdc - 15 custom blocks documented (blocks/**/*)
5. 04-content-types.mdc - 3 custom post types with Field Manager (content/**/*)
6. 05-development-workflow.mdc - Git and deployment (always applied)
7. 06-theme-build-process.mdc - Build commands and assets (themes/**/*,*.scss,*.js)
8. 07-frontend-standards.mdc - JS/CSS standards (*.js,*.scss,*.css)

Summary of included rules:
- Project architecture and structure
- 15 custom blocks documented with locations
- 3 custom post types with Field Manager fields
- Build commands and development workflow
- Links to 6 documentation files found (using actual file paths)
- PHP/JS/CSS naming conventions and patterns discovered from codebase
- Security and performance best practices
- File-specific rules using glob patterns
- Always-applied rules for architecture and workflow

Next steps:
1. Review the generated .cursor/rules/ directory
2. Commit to version control: git add wp-content/.cursor
3. Share with team members using Cursor
4. Update rules when project structure changes
5. Re-run this command to refresh rules after major updates
```

## Related Commands

**Before generating cursor rules:**
- **Run `/document-project` FIRST** - Creates/updates documentation that rules will reference

**After generating cursor rules:**
- Use `/estimate-ticket` with better AI context from rules
- Use `/plan-feature` with improved understanding of codebase
- Re-run `/generate-cursor-rules` after running `/document-project` to refresh doc links

---

## ✨ Tips for Using Generated Rules

### Share with Your Team
Generated rules can be committed to version control and shared:

```bash
# For WordPress projects (typical)
git add wp-content/.cursor
git commit -m "Add Cursor AI rules for better code assistance"
git push origin main

# For non-standard projects
git add .cursor
git commit -m "Add Cursor AI rules for better code assistance"
git push origin main
```

### Update Regularly
Re-run this command when:
- Adding new custom blocks
- Creating new post types or taxonomies
- Changing build tools or processes
- Updating coding standards
- Adding new documentation
- Major refactors that change project structure

The command will regenerate all 8 MDC files with updated information.

### Combine with Global Rules
The generated project-specific rules work alongside your global Cursor rules (from this repo). Project-specific rules in `.cursor/rules/` provide context about your codebase while global rules provide general development best practices.

### Understanding the File Structure
- **00-rules-overview.mdc**: Manual reference, start here to understand the rules structure
- **01-project-architecture.mdc**: Always applied, provides project structure context
- **02-07 files**: Applied based on file type (globs), provide specific guidance for PHP, blocks, content types, build, and frontend
- **05-development-workflow.mdc**: Always applied, provides Git and deployment context

### Test the Rules
After generating, test that the AI understands your project better by asking:
- "What custom blocks are available in this project?"
- "How do I register a new post type following this project's patterns?"
- "What's the naming convention for functions in this project?"
- "Where is the documentation for custom blocks?"
- "What build commands are available?"
- "Show me an example of a custom block registration in this project"

---

## ✨ Command Workflow

### Before This Command: `/document-project`

**You should run `/document-project` BEFORE running this command.**

```bash
# Step 1: Create/update documentation
/document-project
```

**What it does:** Generates comprehensive project documentation that `/generate-cursor-rules` will discover and link to.

### This Command: `/generate-cursor-rules`

```bash
# Step 2: Generate rules that reference the documentation
/generate-cursor-rules
```

**What it does:** Creates 8 MDC files with project-specific rules that include `mdc:` links to the documentation created by `/document-project`.

### After This Command

Use your new rules to get better AI assistance:

```bash
# Benefit from improved AI context
/estimate-ticket
/plan-feature
/execute-plan
```

**Maintenance:** When you update your project documentation with `/document-project`, re-run `/generate-cursor-rules` to refresh the rules with updated doc links.

---

**Command Version**: 1.0.0  
**Last Updated**: 2025-11-11  
**Compatible With**: Cursor AI Editor


