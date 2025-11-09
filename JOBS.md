# Jobs to be Done

This document outlines the "jobs" this dot-files repository is designed to accomplish, using the Jobs to be Done framework.

## Primary Jobs

### 1. Establish a Consistent Development Environment Across Machines
**When** setting up a new machine or reinstalling Linux
**I want to** quickly replicate my preferred terminal, editor, and shell configuration
**So that** I can be productive immediately without manual configuration or remembering settings

**Success criteria:**
- Single command installation (`./install.sh`)
- All configurations applied via symlinks
- Configurations work identically across machines

### 2. Version Control My Environment Configurations
**When** I make changes to my shell, editor, or terminal settings
**I want to** track those changes in Git
**So that** I can review history, rollback mistakes, and never lose my preferred setup

**Success criteria:**
- All configuration files tracked in repository
- Commit history shows evolution of setup
- Easy rollback via `git checkout`

### 3. Type Portuguese Characters Correctly on Linux
**When** typing in Portuguese (or other languages with cedilla)
**I want to** input ç and Ç correctly using the international keyboard
**So that** I can write naturally without character input issues

**Success criteria:**
- `fix-cedilla.sh` script configures system-wide cedilla support
- Works across X11, Wayland, GTK, Qt applications
- Configuration persists across sessions

### 4. Maintain a Personalized, Efficient Terminal Workflow
**When** working in the terminal daily
**I want to** have smart completions, syntax highlighting, history search, and visual clarity
**So that** I can work faster and make fewer mistakes

**Success criteria:**
- Auto-suggestions from command history
- Syntax highlighting warns about dangerous commands
- History substring search finds previous commands quickly
- Visual prompt shows git status and context

## Secondary Jobs

### 5. Share and Document Configuration Knowledge
**When** others ask about my setup or when I return after time away
**I want to** clear documentation of what's configured and why
**So that** others can learn from it and I can remember my own choices

**Success criteria:**
- Comprehensive README with features and installation
- Clear comments in configuration files
- Structure is understandable to others

### 6. Experiment Safely With New Tools and Plugins
**When** trying new shell plugins or configuration changes
**I want to** test changes without breaking my working environment
**So that** I can explore improvements without risk

**Success criteria:**
- Backup system creates timestamped backups
- Git allows reverting to known-good states
- Modular plugin system (Zplug) allows easy add/remove

### 7. Quickly Onboard New Machines for Development
**When** getting a new computer, VM, or container for development
**I want to** run one script and have my entire environment ready
**So that** I don't waste time on manual configuration

**Success criteria:**
- Prerequisites check prevents partial installations
- Single `./install.sh` command handles everything
- Clear post-installation instructions

### 8. Have an Aesthetically Pleasing Workspace
**When** spending hours in the terminal
**I want to** a visually appealing color scheme, font ligatures, and clean UI
**So that** my workspace is comfortable and reduces eye strain

**Success criteria:**
- Custom color scheme with magenta accents
- FiraCode Nerd Font with programming ligatures
- Dark mode across all tools
- Consistent theming (Hyper terminal + Cloud prompt)

## Contextual Jobs

### 9. Avoid Accidental Data Loss From Shell Operations
**When** running file operations in the shell
**I want to** be warned before overwriting or deleting files
**So that** I don't accidentally destroy important data

**Success criteria:**
- Prezto configured with safe operations
- Syntax highlighting shows dangerous commands in red
- Interactive prompts before destructive operations

### 10. Navigate and Edit Code Efficiently
**When** editing files in the terminal
**I want to** familiar keybindings, syntax highlighting, and clipboard integration
**So that** I can edit quickly without reaching for a GUI editor

**Success criteria:**
- Neovim configured with sane defaults
- System clipboard integration
- Line numbers and current line highlighting
- Bash-like tab completion

## Non-Jobs (What This Repository Doesn't Do)

- **Doesn't** manage application installations (use package managers)
- **Doesn't** configure GUI applications beyond terminal emulator
- **Doesn't** include language-specific development tools
- **Doesn't** manage secrets or credentials
- **Doesn't** provide cloud synchronization (use Git manually)
- **Doesn't** include Vim plugins or extensive IDE configuration

## Job Performance Metrics

**Setup Speed:** < 5 minutes from clone to working environment
**Portability:** Works on any Linux distribution with Zsh
**Maintenance:** Changes require only `git pull` and restart terminal
**Learning Curve:** Works immediately for Zsh users, <30 min for newcomers
**Reliability:** Backup system prevents configuration loss

## Evolution of Jobs

The repository has evolved to address:
1. **Originally:** Basic Zsh configuration
2. **Added:** Prezto framework for richer features
3. **Added:** Zplug for modern plugin management
4. **Added:** Hyper terminal configuration for consistent UI
5. **Added:** Cedilla fix for Portuguese language support
6. **Added:** Automated installation script for ease of use

Future jobs might include:
- SSH/Git configuration management
- Development tool version management (Node, Python, etc.)
- Custom scripts and utilities
- Additional language support configurations
