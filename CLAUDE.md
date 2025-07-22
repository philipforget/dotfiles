# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for various development tools. The configurations are designed to work cross-platform (Linux/macOS) with platform-specific adaptations.

## Installation & Setup

The repository includes a comprehensive setup script:

```bash
# Install dotfiles (runs init.sh)
./init.sh

# Or install remotely with optional GitHub username for public key sync
curl -sfL init.chevalierforget.com | bash -s -- $YOUR_GITHUB_USERNAME

# Test in Docker container
docker build . -t dotfiles
docker run --rm -it dotfiles bash -c './init.sh; bash'
```

The `init.sh` script handles:
- Installing system packages (via apt/brew)
- Setting up symlinks for all configuration files
- Installing mise for tool version management
- Configuring Neovim with lazy.nvim
- Installing tmux plugins via tpm

## Architecture & Structure

### Shell Configuration
- `bash_custom`: Main bash configuration, sources platform-specific files
- `bash_linux`/`bash_mac`: Platform-specific bash configurations
- `aliases`/`aliases_linux`/`aliases_mac`: Command aliases and functions
- Environment variables and PATH management through mise

### Neovim Configuration
- **Base**: `nvim/init.lua` - Entry point, sets leader key to `<space>`
- **Core**: `nvim/lua/options.lua` - Vim options and settings
- **Keymaps**: `nvim/lua/keymaps.lua` - Custom key bindings
- **Plugin Management**: lazy.nvim with modular plugin structure
- **Plugin Structure**:
  - `kickstart/plugins/` - Core plugins (LSP, treesitter, etc.)
  - `custom/plugins/` - Personal customizations and additional plugins
- **Notable Features**:
  - LSP configuration with language servers
  - Treesitter for syntax highlighting
  - Telescope for fuzzy finding
  - Which-key for key binding discovery

### Terminal & Multiplexing
- **tmux**: Custom prefix `C-g`, vim-like bindings, catppuccin theme
- **wezterm**: GPU-accelerated terminal with catppuccin theme
- **Theme**: Consistent catppuccin latte theme across tools

### Development Tools
- **mise**: Version management for node, python, and other tools
- **Git**: Custom aliases (`hist`, `lg`) and configuration
- **Docker**: Pre-configured for development workflows

## Key Files & Locations

- Configuration files are symlinked from repository to expected locations
- Scripts and binaries placed in `~/.local/bin`
- Neovim plugins managed in `~/.config/nvim/` (symlinked from `nvim/`)
- tmux configuration in `~/.config/tmux/` (symlinked from `tmux/`)

## Platform Differences

The setup automatically detects and configures platform-specific settings:
- **Linux**: Uses apt packages, includes SSH agent setup
- **macOS**: Uses Homebrew, includes Rectangle window manager, specific Docker config

## Common Operations

### Updating Configurations
```bash
# Navigate to dotfiles directory
cd ~/workspace/dotfiles

# Make changes to configuration files
# Changes are immediately active due to symlinks

# Update remote repository
git add . && git commit -m "Update config" && git push
```

### Neovim Plugin Management
```bash
# Update plugins
nvim +Lazy

# Install new plugins by adding to custom/plugins/
```

### tmux Plugin Management
```bash
# Install/update tmux plugins
<prefix>I  # Install new plugins
<prefix>U  # Update plugins
```

## Development Workflow

The dotfiles are designed for a development workflow that emphasizes:
- Cross-platform compatibility
- Consistent theming (catppuccin)
- Keyboard-driven workflows
- Terminal-based development
- Version management through mise
- Docker-based testing and development

## Notes

- The repository contains sensitive files in `secret/` directory (excluded from this analysis)
- Configuration changes are immediately active due to symlink setup
- The setup script is idempotent and safe to run multiple times
- All tools are configured to use consistent key bindings and themes where possible