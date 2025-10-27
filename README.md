# Cursor Configuration Repository

A centralized repository for custom Cursor AI commands and rules that can be symlinked into your global `.cursor` directory.

## What This Is

This repository contains reusable Cursor AI configurations including:

- **Custom Commands** - Slash commands for documentation generation and code analysis
- **AI Rules** - Development guidelines and coding standards for AI assistance
- **Configuration** - Shared settings for consistent AI behavior across projects

By symlinking this repository into your global `.cursor` directory, you get instant access to all custom commands and rules without duplicating files across multiple projects.

## Setup Instructions

### 1. Clone the Repository

Clone this repository to your preferred location:

```bash
git clone git@github.com:claytoncollie/cursor-for-clayton.git
```

### 2. Create Symlinks

Navigate to your global `.cursor` directory and create symlinks for the `commands` and `rules` directories:

```bash
cd ~/.cursor
ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands
ln -s ~/www/cursor-for-clayton/rules ~/.cursor/rules
```

**Note:** If you cloned the repository to a different location, adjust the paths accordingly in the symlink commands.

### 3. Verify Setup

Check that the symlinks were created successfully:

```bash
ls -la ~/.cursor
```

### 4. Restart Cursor

Restart the Cursor editor to load the new commands and rules.

## Updating

To get the latest commands and rules:

```bash
cd ~/www/cursor-for-clayton
git pull origin trunk
```

Changes will be immediately available in Cursor since the symlinks point to the repository.

## Troubleshooting

**If symlinks already exist:**

Remove the existing symlinks before creating new ones:

```bash
cd ~/.cursor
rm -rf commands rules
ln -s ~/www/cursor-for-clayton/commands ~/.cursor/commands
ln -s ~/www/cursor-for-clayton/rules ~/.cursor/rules
```
