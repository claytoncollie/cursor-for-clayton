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

```bash
git clone https://github.com/claytoncollie/cursor-for-clayton.git ~/cursor-config
```

### 2. Symlink to Your Project

Navigate to your global directory and create a symlink from this repository to your global `.cursor` directory:

```bash
ln -s ~/cursor-config .cursor
```

### 3. Verify Setup

Check that the symlink was created successfully:

```bash
ls -la .cursor
```

You should see a symlink pointing to your cloned repository.

### 4. Restart Cursor

Restart the Cursor editor to load the new commands and rules.

## Updating

To get the latest commands and rules:

```bash
cd ~/cursor-config
git pull origin trunk
```

Changes will be immediately available in all projects using the symlink.
