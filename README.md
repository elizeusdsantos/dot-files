# Dot-files

Personal configuration files for Zsh, Neovim, and Ghostty terminal on Linux.

## What's Included

This repository contains configurations for:

- **Zsh** with [Antidote](https://github.com/mattmc3/antidote) plugin manager
- **Neovim** text editor setup
- **Ghostty** terminal emulator with custom theme
- **Git** configuration
- **XCompose** for Portuguese language support

## Features

### Shell (Zsh + Antidote)
- Fast, declarative plugin management with Antidote
- Auto-installation of plugins on first launch
- Zsh plugins for autosuggestions, completions, and auto-pairing
- Clean and simple configuration
- Git integration
- History management

### Terminal (Ghostty)
- Victor Mono font, size 10
- Darkside theme (dark theme with vibrant colors)
- Underline cursor style
- Custom keybindings for enhanced workflow
- Fast, native performance

### Editor (Neovim)
- Line numbers and syntax highlighting
- Mouse support
- 2-space indentation
- Case-insensitive search
- System clipboard integration
- Current line highlighting
- Bash-like tab completion

### Zsh Plugins (via Antidote)
Plugins are defined in `zsh_plugins.txt` and auto-installed:
- **zsh-autosuggestions**: Fish-like command suggestions
- **zsh-completions**: Additional completion definitions
- **zsh-autopair**: Auto-pairing of brackets and quotes
- **Pure prompt**: Minimal, fast Zsh prompt

### Portuguese Language Support
- **XCompose**: Custom compose file for proper cedilla (ç/Ç) input
- Works with US International keyboard layout
- User-level configuration, no sudo required
- Compatible with X11 applications

## Prerequisites

Before installation, ensure you have the following:

### Required
- **Zsh**: Your shell
  ```bash
  # Arch Linux
  sudo pacman -S zsh

  # Ubuntu/Debian
  sudo apt install zsh
  ```

- **Git**: Version control
  ```bash
  # Arch Linux
  sudo pacman -S git

  # Ubuntu/Debian
  sudo apt install git
  ```

### Optional
- **Neovim**: Modern Vim fork
  ```bash
  # Arch Linux
  sudo pacman -S neovim

  # Ubuntu/Debian
  sudo apt install neovim
  ```

- **Ghostty**: Modern terminal emulator
  - Download from [ghostty.org](https://ghostty.org/)
  - Arch Linux: Available in AUR

- **Victor Mono Font**: Programming font with ligatures
  - Download from [rubjo.github.io/victor-mono](https://rubjo.github.io/victor-mono/)

## Installation

### Automated Installation (Recommended)

1. Clone this repository:
   ```bash
   cd ~/Code  # or your preferred location
   git clone https://github.com/elizeusdsantos/dot-files.git
   cd dot-files
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

   The script will:
   - Check for required dependencies
   - Create timestamped backups of existing config files
   - Create symlinks to your home directory
   - Set up Zsh configuration

3. Change your default shell to Zsh (if not already):
   ```bash
   chsh -s $(which zsh)
   ```

4. Restart your terminal or source the configuration:
   ```bash
   source ~/.zshrc
   ```

5. Antidote and plugins will auto-install on first Zsh launch!

### Manual Installation

If you prefer to set up manually:

1. **Zsh configuration:**
   ```bash
   cp ~/Code/dot-files/zshrc.template ~/.zshrc
   ```

2. **Antidote plugins:**
   ```bash
   ln -sf ~/Code/dot-files/zsh_plugins.txt ~/.zsh_plugins.txt
   ```

3. **Git configuration:**
   ```bash
   ln -sf ~/Code/dot-files/gitconfig ~/.gitconfig
   ```

4. **Ghostty configuration:**
   ```bash
   mkdir -p ~/.config/ghostty
   ln -sf ~/Code/dot-files/ghostty/config ~/.config/ghostty/config
   ```

5. **Neovim configuration:**
   ```bash
   mkdir -p ~/.config/nvim
   ln -sf ~/Code/dot-files/nvim/init.vim ~/.config/nvim/init.vim
   ```

6. **XCompose (cedilla support):**
   ```bash
   ln -sf ~/Code/dot-files/XCompose ~/.XCompose
   ```

## Customization

### Adding Your Own Aliases and Functions

Edit `~/.zshrc` and add your customizations at the bottom:

```bash
# Custom aliases
alias ll='ls -lah'
alias gs='git status'

# Custom functions
mcd() {
  mkdir -p "$1" && cd "$1"
}
```

### Adding More Zsh Plugins

Edit `zsh_plugins.txt` in this repository:
```bash
# Add a new plugin (GitHub repo format)
echo "username/repo-name" >> ~/Code/dot-files/zsh_plugins.txt
```

Then reload your shell:
```bash
source ~/.zshrc
```

Antidote will automatically install the new plugin.

### Changing Ghostty Theme

Edit `ghostty/config` and change the theme line:
```bash
theme = <theme-name>
```

List available themes:
```bash
ghostty +list-themes
```

Then reload Ghostty config with `Ctrl+Shift+Comma` or restart Ghostty.

## File Structure

```
dot-files/
├── .claude/                 # Claude Code configuration
├── .git/                    # Git repository data
├── ghostty/
│   └── config              # Ghostty terminal configuration
├── nvim/
│   └── init.vim            # Neovim configuration
├── .gitignore              # Git ignore patterns
├── cleanup.sh              # Script to remove backup files
├── CLAUDE.md               # Claude Code instructions
├── gitconfig               # Git configuration
├── hyper.js                # Legacy Hyper config (deprecated)
├── install.sh              # Automated installation script
├── LICENSE                 # MIT License
├── README.md               # This file
├── XCompose                # X11 compose configuration for cedilla support
├── zpreztorc               # Legacy Prezto config (deprecated)
├── zsh_plugins.txt         # Antidote plugin list
└── zshrc.template          # Zsh configuration template
```

## Troubleshooting

### Antidote not loading

Make sure Antidote is sourced in your `~/.zshrc`:
```bash
# Load antidote
source ~/.antidote/antidote.zsh

# Initialize plugins
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
```

If Antidote isn't installed, it will auto-install on first Zsh launch.

### Zsh plugins not working

1. Check if plugins file exists: `ls -la ~/.zsh_plugins.txt`
2. Reload shell: `source ~/.zshrc`
3. Check Antidote status: `antidote list`

### Ghostty theme not applying

1. Verify config is symlinked: `ls -la ~/.config/ghostty/config`
2. Reload config: Press `Ctrl+Shift+Comma` in Ghostty
3. Or restart Ghostty completely
4. Check theme name is correct: `ghostty +list-themes`

### Neovim configuration not loading

1. Check file location: `ls -la ~/.config/nvim/init.vim`
2. Check for syntax errors: `nvim --noplugin -c 'source ~/.config/nvim/init.vim' -c 'q'`

## Backup & Cleanup

### Automatic Backups

The installation script automatically creates backups of existing files:
```
~/.zshrc.backup.20251115_113045
~/.gitconfig.backup.20251115_113045
# etc.
```

### Cleaning Up Backup Files

If you run `install.sh` multiple times, backup files will accumulate. To remove them all at once:

```bash
./cleanup.sh
```

The cleanup script will:
- Find all backup files matching the `*.backup.YYYYMMDD_HHMMSS` pattern
- Show you a list of files with their sizes
- Ask for confirmation before deleting
- Safely remove all backup files from your home directory

## Uninstallation

To remove the symlinks and restore backups:

```bash
# Remove symlinks
rm ~/.zsh_plugins.txt ~/.gitconfig ~/.config/ghostty/config ~/.config/nvim/init.vim ~/.XCompose

# Restore from backup (find the latest backup)
ls -la ~/*.backup.*
mv ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc
# etc.
```

## Contributing

Feel free to fork this repository and customize it for your own use. If you find bugs or have suggestions, please open an issue or submit a pull request.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Antidote](https://github.com/mattmc3/antidote) - Fast Zsh plugin manager
- [Neovim](https://neovim.io/) - Hyperextensible Vim-based text editor
- [Ghostty](https://ghostty.org/) - Fast, native terminal emulator
- [Victor Mono](https://rubjo.github.io/victor-mono/) - Programming font with cursive italics
- [Pure](https://github.com/sindresorhus/pure) - Minimal Zsh prompt
