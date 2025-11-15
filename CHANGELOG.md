# Changelog

All notable changes to this dot-files repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- zsh-syntax-highlighting plugin for real-time command syntax highlighting
- zsh-autosuggestions plugin for Fish-like autosuggestions based on history
- ohmyzsh git plugin for Git aliases and helper functions

### Changed
- Updated README.md to reflect current tech stack (Ghostty + Antidote)
- Updated CLAUDE.md documentation for Ghostty terminal configuration

## [2.0.0] - 2025-11-15

### Added
- Ghostty terminal configuration with Darkside theme
- Automated cleanup script (`cleanup.sh`) to remove backup files
- Git configuration file with user info and editor settings
- CHANGELOG.md to track repository changes
- XCompose configuration for Portuguese cedilla support (ç/Ç)

### Changed
- **BREAKING**: Migrated from Prezto framework to Antidote plugin manager
  - Simpler, faster plugin management
  - Declarative plugin configuration via `zsh_plugins.txt`
  - Auto-installation on first shell launch
- **BREAKING**: Replaced Hyper terminal with Ghostty
  - Better performance with native GTK runtime
  - Simpler configuration format
  - Victor Mono font with Darkside theme
- Switched from FiraCode Nerd Font to Victor Mono
- Updated installation script to support new configuration structure
- Improved backup system with timestamped files

### Deprecated
- `hyper.js` - Hyper terminal configuration (kept for reference)
- `zpreztorc` - Prezto configuration (kept for reference)
- Hyper terminal installation section in `install.sh` (commented out)

### Removed
- Zplug plugin manager and related configurations
- Manual plugin installation steps (now auto-installed)
- Prezto-specific configuration and setup steps

## [1.0.0] - Initial Release

### Added
- Initial dot-files repository setup
- Zsh configuration with Prezto framework
- Zplug plugin manager integration
- Hyper terminal configuration with hyper-hypest theme
- Neovim configuration with sensible defaults
- Automated installation script
- MIT License
- Basic README with installation instructions

### Plugins (Zplug)
- zsh-autopair: Auto-pairing of brackets and quotes
- zsh-autosuggestions: Fish-like command suggestions
- zsh-completions: Additional completion definitions

### Features
- FiraCode Nerd Font with ligatures
- Cloud prompt theme with custom orange color
- 10,000 command history
- Syntax highlighting with safety warnings
- Git integration
- System clipboard integration across tools

---

## Migration Guide: v1.x to v2.0

### Prerequisites
Before migrating, ensure you have:
- Zsh installed
- Git installed
- Backup of your current `~/.zshrc` if customized

### Migration Steps

1. **Pull latest changes:**
   ```bash
   cd ~/Code/dot-files
   git pull origin main
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```
   This will backup existing files and create new symlinks.

3. **Optional: Install Ghostty**
   ```bash
   # Arch Linux (AUR)
   yay -S ghostty

   # Or download from https://ghostty.org/
   ```

4. **Restart your terminal:**
   ```bash
   source ~/.zshrc
   ```
   Antidote will auto-install on first launch.

5. **Clean up old backups (optional):**
   ```bash
   ./cleanup.sh
   ```

### What Changed

| Old (v1.x) | New (v2.0) | Impact |
|------------|------------|--------|
| Prezto | Antidote | Faster startup, simpler config |
| Zplug | Antidote | Auto-installation, no manual plugin install |
| Hyper | Ghostty | Better performance, native feel |
| FiraCode | Victor Mono | Different aesthetic, still has ligatures |
| Manual setup | Auto-install | Easier onboarding |

### Rollback

If you need to rollback to v1.x configuration:

```bash
# Restore from backups
mv ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc

# Or checkout v1.x (if tagged)
cd ~/Code/dot-files
git checkout v1.0.0
./install.sh
```

---

## Notes

- All dates use YYYY-MM-DD format
- Version numbers follow [Semantic Versioning](https://semver.org/)
- Breaking changes are marked with **BREAKING** prefix
- Legacy files are kept in repository but marked as deprecated
