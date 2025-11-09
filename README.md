# Dot-files

Personal configuration files for Zsh, Neovim, and Hyper terminal on Linux.

## What's Included

This repository contains configurations for:

- **Zsh** with [Prezto](https://github.com/sorin-ionescu/prezto) framework
- **Zplug** plugin manager with useful plugins
- **Neovim** text editor setup
- **Hyper** terminal emulator with custom theme

## Features

### Shell (Zsh + Prezto)
- Emacs key bindings
- Cloud prompt theme with custom orange color
- 10,000 command history
- Syntax highlighting with safety warnings for dangerous commands
- Safe operations (prompts before overwriting files)
- Git integration
- History substring search
- Directory navigation enhancements

### Terminal (Hyper)
- FiraCode Nerd Font with ligatures enabled
- Dark mode theme (hyper-hypest)
- Custom color scheme with magenta accents
- WebGL rendering for better performance
- System clipboard integration

### Editor (Neovim)
- Line numbers and syntax highlighting
- Mouse support
- 2-space indentation
- Case-insensitive search
- System clipboard integration
- Current line highlighting
- Bash-like tab completion

### Plugins (Zplug)
- **zsh-autopair**: Auto-pairing of brackets and quotes
- **zsh-autosuggestions**: Fish-like command suggestions
- **zsh-completions**: Additional completion definitions

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

- **Prezto**: Zsh configuration framework
  ```bash
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  ```

- **Zplug**: Plugin manager (auto-installed by install.sh if missing)
  ```bash
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  ```

### Optional
- **Neovim**: Modern Vim fork
  ```bash
  # Arch Linux
  sudo pacman -S neovim

  # Ubuntu/Debian
  sudo apt install neovim
  ```

- **Hyper**: Terminal emulator
  - Download from [hyper.is](https://hyper.is/)

- **FiraCode Nerd Font**: Font with programming ligatures and icons
  - Download from [Nerd Fonts](https://www.nerdfonts.com/font-downloads)

## Installation

### Automated Installation (Recommended)

1. Clone this repository:
   ```bash
   cd ~/code  # or your preferred location
   git clone https://github.com/elizeusdsantos/dot-files.git
   cd dot-files
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Change your default shell to Zsh (if not already):
   ```bash
   chsh -s $(which zsh)
   ```

4. Restart your terminal or source the configuration:
   ```bash
   source ~/.zshrc
   ```

5. Install zplug plugins:
   ```bash
   zplug install
   ```

### Manual Installation

If you prefer to set up manually:

1. **Prezto configuration:**
   ```bash
   ln -sf ~/code/dot-files/zpreztorc ~/.zpreztorc
   ```

2. **Zsh configuration:**
   ```bash
   cp ~/code/dot-files/zshrc.template ~/.zshrc
   # Edit ~/.zshrc and customize as needed
   ```

3. **Neovim configuration:**
   ```bash
   mkdir -p ~/.config/nvim
   ln -sf ~/code/dot-files/nvim/init.vim ~/.config/nvim/init.vim
   ```

4. **Hyper configuration:**
   ```bash
   ln -sf ~/code/dot-files/hyper.js ~/.hyper.js
   ```

5. **Zplug plugins:**
   ```bash
   mkdir -p ~/.zplug/config
   ln -sf ~/code/dot-files/zplug/plugins.zsh ~/.zplug/config/plugins.zsh
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

### Changing the Prompt Color

Edit `zpreztorc` line 150:
```bash
zstyle ':prezto:module:prompt' theme 'cloud' '>' '#FFA500' 'blue'
#                                              ^    ^         ^
#                                              |    |         └─ root user color
#                                              |    └─────────── normal user color (hex)
#                                              └──────────────── prompt symbol
```

### Adding More Zplug Plugins

Edit `zplug/plugins.zsh` and add your plugins:
```bash
zplug "author/plugin-name"
```

Then run:
```bash
zplug install
zplug load
```

## File Structure

```
dot-files/
├── .claude/                 # Claude Code configuration
├── .git/                    # Git repository data
├── nvim/
│   └── init.vim            # Neovim configuration
├── zplug/
│   └── plugins.zsh         # Zplug plugin definitions
├── .gitignore              # Git ignore patterns
├── hyper.js                # Hyper terminal configuration
├── install.sh              # Automated installation script
├── LICENSE                 # MIT License
├── README.md               # This file
├── zpreztorc               # Prezto configuration
└── zshrc.template          # Zsh configuration template
```

## Troubleshooting

### Prezto not loading

Make sure Prezto is installed and sourced in your `~/.zshrc`:
```bash
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
```

### Zplug plugins not working

1. Ensure zplug is installed: `test -d ~/.zplug && echo "Installed" || echo "Not installed"`
2. Install plugins: `zplug install`
3. Check if plugins are loaded: `zplug list`

### Hyper not using FiraCode font

1. Ensure FiraCode Nerd Font is installed
2. Check font name: `fc-list | grep -i fira`
3. Update `hyper.js` line 16 with the correct font name

### Neovim configuration not loading

1. Check file location: `ls -la ~/.config/nvim/init.vim`
2. Check for syntax errors: `nvim --noplugin -c 'source ~/.config/nvim/init.vim' -c 'q'`

## Backup

The installation script automatically creates backups of existing files:
```
~/.zpreztorc.backup.YYYYMMDD_HHMMSS
~/.zshrc.backup.YYYYMMDD_HHMMSS
# etc.
```

## Uninstallation

To remove the symlinks and restore backups:

```bash
# Remove symlinks
rm ~/.zpreztorc ~/.hyper.js ~/.config/nvim/init.vim

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

- [Prezto](https://github.com/sorin-ionescu/prezto) - Zsh configuration framework
- [Zplug](https://github.com/zplug/zplug) - Plugin manager for Zsh
- [Neovim](https://neovim.io/) - Hyperextensible Vim-based text editor
- [Hyper](https://hyper.is/) - Electron-based terminal emulator
- [FiraCode](https://github.com/tonsky/FiraCode) - Monospaced font with programming ligatures
