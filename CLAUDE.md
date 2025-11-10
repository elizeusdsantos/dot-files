# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dot-files repository for configuring Zsh, Neovim, and Hyper terminal on Linux. The repository uses **symlinks** to connect configuration files from the repository to their expected locations in the home directory, allowing version control of configurations while keeping them in their standard locations.

## Installation and Setup

### Initial Installation
```bash
./install.sh
```

The installation script:
- Creates backups of existing files with timestamps (e.g., `.zpreztorc.backup.YYYYMMDD_HHMMSS`)
- Creates symlinks from `$HOME` to files in this repository
- Checks for required dependencies (Zsh, Prezto)
- Installs Zplug if missing
- Handles `.zshrc` carefully (prompts user if exists, otherwise copies from template)

### Post-Installation
```bash
source ~/.zshrc
zplug install
```

### Manual Symlink Creation
If modifying the installer or testing specific configurations:
```bash
ln -sf ~/code/dot-files/zpreztorc ~/.zpreztorc
ln -sf ~/code/dot-files/hyper.js ~/.hyper.js
ln -sf ~/code/dot-files/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/code/dot-files/zplug/plugins.zsh ~/.zplug/config/plugins.zsh
```

## Key Configuration Details

### Prezto Configuration (zpreztorc)
- **Prompt theme**: Cloud theme with custom orange color (`#FFA500`) configured on line 150
- **Modules loaded** (in order): environment, terminal, editor, history, directory, spectrum, utility, completion, history-substring-search, prompt, syntax-highlighting, git
- Module order matters for Prezto; don't reorder without reason

### Zsh Configuration (zshrc.template)
- Sources Prezto from `~/.zprezto/init.zsh`
- Sources Zplug from `~/.zplug/init.zsh`
- Loads plugin configuration from `~/code/dot-files/zplug/plugins.zsh`
- User customizations should be added at the bottom of `~/.zshrc`

### Zplug Plugins (zplug/plugins.zsh)
Current plugins:
- `hlissner/zsh-autopair` (defer:2) - auto-pairing brackets/quotes
- `zsh-users/zsh-autosuggestions` - fish-like command suggestions
- `zsh-users/zsh-completions` - additional completions

### Neovim Configuration (nvim/init.vim)
- **Indentation**: 2 spaces (expandtab, tabstop=2, shiftwidth=2)
- **Features**: line numbers, mouse support, system clipboard integration, current line highlighting
- **Search**: case-insensitive, incremental, with highlighting
- **Completion**: bash-like tab completion (`wildmode=longest,list`)

### Hyper Terminal (hyper.js)
- **Font**: FiraCode Nerd Font (line 16)
- **Theme**: hyper-hypest with dark mode enabled
- **Colors**: Magenta accents (cursor: `rgba(248,28,229,0.8)`, selection: `rgba(248,28,229,0.3)`)
- Cursor shape: UNDERLINE, non-blinking
- Font size: 12px

## Important Implementation Notes

### When Modifying install.sh
- Always create backups before overwriting files using the `create_symlink()` function
- Use `ln -sf` for symlinks (force overwrite)
- Check for command existence with `command -v <cmd> &> /dev/null`
- Use color codes: GREEN for success, YELLOW for warnings, RED for errors, BLUE for info
- Exit with status 1 if critical dependencies are missing

### When Adding Zplug Plugins
Add to `zplug/plugins.zsh`, then run:
```bash
zplug install
zplug load
```

### When Modifying Prompt Color
Edit `zpreztorc` line 150:
```bash
zstyle ':prezto:module:prompt' theme 'cloud' '>' '#FFA500' 'blue'
```
Format: `theme-name symbol user-color root-color`

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
2. Symlinks are created in standard config locations (`~/.zpreztorc`, `~/.hyper.js`, etc.)
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
- Prezto (installed at `~/.zprezto`)

**Optional:**
- Neovim
- Hyper terminal
- FiraCode Nerd Font
- Zplug (auto-installed by `install.sh`)
