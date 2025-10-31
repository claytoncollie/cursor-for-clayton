# Cursor Configuration Repository

A centralized repository for custom Cursor AI commands and rules that can be symlinked into your global `.cursor` directory.

## What This Is

This repository contains reusable Cursor AI configurations including:

- **Custom Commands** - Slash commands for documentation generation and code analysis
- **AI Rules** - Development guidelines and coding standards for AI assistance
- **Configuration** - Shared settings for consistent AI behavior across projects

By symlinking this repository into your global `.cursor` directory, you get instant access to all custom commands and rules without duplicating files across multiple projects.

## What's Included

### Commands

Custom slash commands for documentation and code analysis tasks.

### Rules

Global development guidelines in `rules/cursor-global-rules.md` covering:
- Development approach and methodology
- Code quality standards
- Backend, frontend, database, and DevOps best practices

**To use:** Copy the contents of `cursor-global-rules.md` and paste into Cursor Settings → General → Rules for AI.

## Setup Instructions

### 1. Clone the Repository

Clone this repository to your preferred location:

```bash
git clone git@github.com:claytoncollie/cursor-for-clayton.git
```

### 2. Setup Commands (Symlink)

Create a symlink for the `commands` directory:

```bash
cd ~/.cursor
ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands
```

**Note:** If you cloned the repository to a different location, adjust the path accordingly.

### 3. Setup Rules (Manual Copy)

Copy the rules content into Cursor Settings:

1. Open `rules/cursor-global-rules.md` from this repository
2. Copy the entire contents
3. Open Cursor Settings → General → Rules for AI
4. Paste the contents and save

### 4. Verify Setup

Check that the commands symlink was created successfully:

```bash
ls -la ~/.cursor/commands
```

### 5. Restart Cursor

Restart the Cursor editor to load the new commands.

## Updating

**Commands:** Changes are immediately available since the symlink points to the repository.

**Rules:** After pulling updates, manually copy the updated `cursor-global-rules.md` content into Cursor Settings → General → Rules for AI.

```bash
cd ~/www/cursor-for-clayton
git pull origin trunk
```

## Troubleshooting

**If commands symlink already exists:**

Remove and recreate the symlink:

```bash
cd ~/.cursor
rm -rf commands
ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands
```
