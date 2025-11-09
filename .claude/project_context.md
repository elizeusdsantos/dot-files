# Dot-files Project Context

## Project Overview

This is a personal dot-files repository for managing shell, terminal, and editor configurations. The repository follows standard dot-files conventions with symlink-based installation.

## Architecture

### Technology Stack
- **Shell**: Zsh with Prezto framework
- **Plugin Manager**: Zplug
- **Terminal**: Hyper (Electron-based)
- **Editor**: Neovim
- **Font**: FiraCode Nerd Font

### File Organization
- Root level: Framework configs (zpreztorc, hyper.js)
- `nvim/`: Neovim-specific configuration
- `zplug/`: Plugin manager configuration
- `.claude/`: Claude Code settings and documentation

## Key Design Decisions

### 1. Prezto over Oh-My-Zsh
Prezto was chosen for being lighter and faster while providing similar functionality.

### 2. Zplug for Plugin Management
Zplug provides declarative plugin management with deferred loading capabilities.

### 3. Minimal Neovim Config
The Neovim configuration is intentionally minimal, focusing on essential settings without heavy plugin dependencies.

### 4. Symlink-Based Installation
Configuration files are symlinked rather than copied, allowing changes in the repository to immediately reflect in the environment.

## Configuration Highlights

### Safety Features
- **Safe operations enabled** (`zpreztorc:258`): Prompts before overwriting files
- **Dangerous command warning** (`zpreztorc:216-217`): `rm -rf` commands highlighted in red

### Color Scheme
- **Primary**: Orange (#FFA500) - used for prompt and accents
- **Secondary**: Magenta - used in terminal cursor and selections
- **Theme**: Dark mode throughout

### Key Bindings
- **Shell**: Emacs mode (not vi mode)
- **Editor**: Standard Vim bindings with mouse support

## File Mapping

When installed, files are symlinked to these locations:
- `zpreztorc` → `~/.zpreztorc`
- `hyper.js` → `~/.hyper.js`
- `nvim/init.vim` → `~/.config/nvim/init.vim`
- `zplug/plugins.zsh` → `~/.zplug/config/plugins.zsh`
- `zshrc.template` → `~/.zshrc` (copied, not symlinked)

## Development Workflow

### Making Changes
1. Edit files in the repository
2. Changes are immediately active (due to symlinks)
3. Test in terminal
4. Commit if working correctly

### Testing
Before committing changes:
- Test shell configuration: `zsh -c 'source ~/.zshrc && echo "OK"'`
- Test Neovim: `nvim -c 'checkhealth' -c 'q'`
- Verify no syntax errors in configs

### Adding New Configurations
1. Add new config file to appropriate directory
2. Update `install.sh` to symlink the file
3. Document in `README.md`
4. Test installation on clean environment if possible

## Common Tasks

### Adding a Zplug Plugin
1. Edit `zplug/plugins.zsh`
2. Add line: `zplug "author/plugin-name"`
3. Run: `zplug install && zplug load`

### Changing Prompt Theme
Edit `zpreztorc:150`:
```bash
zstyle ':prezto:module:prompt' theme 'cloud' '>' '#FFA500' 'blue'
```

### Modifying Hyper Colors
Edit `hyper.js:60-79` colors object

## Dependencies

### Required
- Zsh (shell)
- Prezto (framework)
- Git (for installation)

### Optional
- Zplug (auto-installed)
- Neovim (text editor)
- Hyper (terminal)
- FiraCode Nerd Font (typography)

## Known Issues

None currently. Previous issues have been resolved:
- ✓ Mouse configuration conflict in nvim (fixed)
- ✓ Ligatures disabled for FiraCode (fixed)
- ✓ Empty configuration values in Hyper (fixed)
- ✓ Missing documentation (fixed)
- ✓ No installation script (fixed)

## Best Practices

### When Modifying Configurations
1. Keep comments clear and concise
2. Maintain consistent formatting
3. Test changes before committing
4. Update README.md if adding new features
5. Keep safety features enabled

### When Adding Files
1. Use appropriate directory structure
2. Update `.gitignore` if necessary
3. Update installation script
4. Document in README.md

## Future Enhancements

Potential improvements to consider:
- [ ] Add tmux configuration
- [ ] Add gitconfig
- [ ] Create separate branch for macOS-specific configs
- [ ] Add plugin manager for Neovim (vim-plug or lazy.nvim)
- [ ] Add color schemes for Neovim
- [ ] Consider adding LSP configuration for Neovim
- [ ] Add more Zsh plugins based on workflow needs

## Support & Troubleshooting

See `README.md` Troubleshooting section for common issues and solutions.

## License

MIT License - This is standard for dot-files repositories to allow easy forking and customization.
