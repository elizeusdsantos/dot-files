# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dot-files repository for configuring Zsh, Neovim, and Ghostty terminal on Linux. The repository uses **symlinks** to connect configuration files from the repository to their expected locations in the home directory, allowing version control of configurations while keeping them in their standard locations.

## Installation and Setup

### Initial Installation
```bash
./install.sh
```

The installation script:
- Creates backups of existing files with timestamps (e.g., `.gitconfig.backup.YYYYMMDD_HHMMSS`)
- Creates symlinks from `$HOME` to files in this repository
- Checks for required dependencies (Zsh)
- Handles `.zshrc` carefully (prompts user if exists, otherwise copies from template)
- Symlinks `zsh_plugins.txt` to `~/.zsh_plugins.txt` for Antidote plugin management

### Post-Installation
```bash
source ~/.zshrc
# Antidote will automatically clone itself and install plugins on first launch
```

### Cleanup Backup Files
Running `install.sh` multiple times creates timestamped backups. To remove them:
```bash
./cleanup.sh
```

The cleanup script:
- Finds all backup files matching `*.backup.YYYYMMDD_HHMMSS` pattern
- Lists files with sizes for review
- Asks for confirmation before deletion
- Safely removes all backup files from `$HOME`

### Manual Symlink Creation
If modifying the installer or testing specific configurations:
```bash
ln -sf ~/code/dot-files/zsh_plugins.txt ~/.zsh_plugins.txt
ln -sf ~/code/dot-files/gitconfig ~/.gitconfig
ln -sf ~/code/dot-files/ghostty/config ~/.config/ghostty/config
ln -sf ~/code/dot-files/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/code/dot-files/XCompose ~/.XCompose
```

## Key Configuration Details

### Zsh Configuration (zshrc.template)
- Auto-clones Antidote plugin manager if not present
- Sources Antidote from `~/.antidote/antidote.zsh`
- Initializes completion system with `compinit` (required before loading plugins)
- Enables prompt substitution with `setopt PROMPT_SUBST` (required for themes with command substitution)
- Loads plugins from `~/.zsh_plugins.txt` (symlinked to `~/code/dot-files/zsh_plugins.txt`)
- User customizations should be added at the bottom of `~/.zshrc`

### Antidote Plugins (zsh_plugins.txt)
Current plugins configured:
```
zsh-users/zsh-syntax-highlighting          # Real-time syntax highlighting
zsh-users/zsh-autosuggestions              # Fish-like autosuggestions
ohmyzsh/ohmyzsh path:lib/async_prompt.zsh  # Oh-My-Zsh async prompt support
ohmyzsh/ohmyzsh path:lib/git.zsh           # Oh-My-Zsh git helper functions
ohmyzsh/ohmyzsh path:plugins/git           # Oh-My-Zsh git aliases
ohmyzsh/ohmyzsh path:themes/robbyrussell.zsh-theme  # Robbyrussell prompt theme
```

To add more plugins, edit `zsh_plugins.txt` and add GitHub repo paths:
```bash
echo "owner/repo-name" >> ~/code/dot-files/zsh_plugins.txt
source ~/.zshrc  # Reload to install new plugins
```

**Important**: When loading oh-my-zsh themes or plugins:
- Load required libraries BEFORE the theme/plugin that depends on them
- `async_prompt.zsh` must be loaded before `git.zsh`
- `git.zsh` must be loaded before themes using `git_prompt_info`
- Always enable `setopt PROMPT_SUBST` before loading themes with command substitution

### Neovim Configuration (nvim/init.vim)
- **Indentation**: 2 spaces (expandtab, tabstop=2, shiftwidth=2)
- **Features**: line numbers, mouse support, system clipboard integration, current line highlighting
- **Search**: case-insensitive, incremental, with highlighting
- **Completion**: bash-like tab completion (`wildmode=longest,list`)

### Ghostty Terminal (ghostty/config)
- **Font**: Victor Mono, size 10
- **Theme**: Darkside (dark theme with vibrant colors)
- **Cursor**: Underline style
- **Keybindings**: Custom shift+enter binding for line breaks

### Git Configuration (gitconfig)
- **User info**: Name and email configured for commits
- **Editor**: Neovim (nvim)
- **Default branch**: main (for new repositories)

## Important Implementation Notes

### When Modifying install.sh
- Always create backups before overwriting files using the `create_symlink()` function
- Use `ln -sf` for symlinks (force overwrite)
- Check for command existence with `command -v <cmd> &> /dev/null`
- Use color codes: GREEN for success, YELLOW for warnings, RED for errors, BLUE for info
- Exit with status 1 if critical dependencies are missing

### When Adding Antidote Plugins
Add plugin repository to `zsh_plugins.txt`:
```bash
# Add a line with the GitHub repository path
echo "owner/repo-name" >> ~/code/dot-files/zsh_plugins.txt

# Reload shell or run:
source ~/.zshrc
```
Antidote will automatically install new plugins on next shell startup.

### Git Workflow
- When making changes, Claude should create commits as requested
- **IMPORTANT**: User handles `git push` themselves - never push to remote unless explicitly requested
- Follow standard commit message conventions
- Include context in commit messages about what changed and why

## Special Configurations

### XCompose (Cedilla Support)
The repository includes an XCompose file for proper cedilla character input (ç/Ç) on Linux:
- User-level configuration (no sudo required)
- Symlinked to `~/.XCompose` by the install script
- Includes default US compose sequences
- Overrides `<dead_acute> + c/C` to produce ç/Ç instead of ć/Ć
- Works across X11 applications automatically
- No logout required - takes effect in new applications after symlink creation

## Architecture

This is a **symlink-based configuration system**:
1. Repository files remain in `~/code/dot-files/`
2. Symlinks are created in standard config locations (`~/.zsh_plugins.txt`, `~/.config/ghostty/config`, etc.)
3. Changes to repository files immediately affect the active configuration
4. Git tracks the actual config files, not the symlinks

This design allows:
- Version control of configurations
- Easy synchronization across machines
- Ability to test changes before committing
- Rollback via git

## Dependencies

**Required:**
- Zsh
- Git

**Auto-installed:**
- Antidote (auto-cloned to `~/.antidote` on first shell launch)

**Optional:**
- Neovim (configured as git editor)
- Ghostty terminal
- Victor Mono font
