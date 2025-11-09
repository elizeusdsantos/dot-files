#!/bin/bash

#
# Dot-files Installation Script
#
# This script creates symlinks from your home directory to the dot-files in this repository.
# Run with: ./install.sh
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}=== Dot-files Installation ===${NC}"
echo -e "Installing from: ${DOTFILES_DIR}\n"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # Backup existing file/symlink
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo -e "${YELLOW}Backing up existing file: $target${NC}"
        mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Create symlink
    ln -sf "$source" "$target"
    echo -e "${GREEN}✓${NC} Linked: $target -> $source"
}

# Check prerequisites
echo -e "${BLUE}Checking prerequisites...${NC}"
MISSING_DEPS=0

if ! command -v zsh &> /dev/null; then
    echo -e "${RED}✗${NC} Zsh is not installed"
    MISSING_DEPS=1
fi

if ! command -v nvim &> /dev/null; then
    echo -e "${YELLOW}!${NC} Neovim is not installed (optional)"
fi

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    echo -e "${RED}✗${NC} Prezto is not installed"
    echo -e "  Install with: git clone --recursive https://github.com/sorin-ionescu/prezto.git \"\${ZDOTDIR:-\$HOME}/.zprezto\""
    MISSING_DEPS=1
fi

if [ ! -d "$HOME/.zplug" ]; then
    echo -e "${YELLOW}!${NC} Zplug is not installed (will be installed)"
    echo -e "  Installing zplug..."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [ $MISSING_DEPS -eq 1 ]; then
    echo -e "\n${RED}Please install missing dependencies before continuing.${NC}"
    exit 1
fi

echo -e "${GREEN}All critical prerequisites met!${NC}\n"

# Install configurations
echo -e "${BLUE}Installing configuration files...${NC}"

# Zsh configuration
create_symlink "$DOTFILES_DIR/zpreztorc" "$HOME/.zpreztorc"

# Hyper terminal configuration
if command -v hyper &> /dev/null; then
    create_symlink "$DOTFILES_DIR/hyper.js" "$HOME/.hyper.js"
else
    echo -e "${YELLOW}!${NC} Hyper terminal not found, skipping hyper.js"
fi

# Neovim configuration
if command -v nvim &> /dev/null; then
    create_symlink "$DOTFILES_DIR/nvim/init.vim" "$HOME/.config/nvim/init.vim"
else
    echo -e "${YELLOW}!${NC} Neovim not found, skipping nvim/init.vim"
fi

# Zplug plugins configuration
if [ -d "$HOME/.zplug" ]; then
    mkdir -p "$HOME/.zplug/config"
    create_symlink "$DOTFILES_DIR/zplug/plugins.zsh" "$HOME/.zplug/config/plugins.zsh"
fi

# .zshrc file
echo ""
if [ -f "$HOME/.zshrc" ]; then
    echo -e "${YELLOW}~/.zshrc already exists.${NC}"
    echo -e "You can either:"
    echo -e "  1. Backup and use the template: mv ~/.zshrc ~/.zshrc.backup && cp $DOTFILES_DIR/zshrc.template ~/.zshrc"
    echo -e "  2. Manually merge the contents of zshrc.template into your existing .zshrc"
else
    cp "$DOTFILES_DIR/zshrc.template" "$HOME/.zshrc"
    echo -e "${GREEN}✓${NC} Created ~/.zshrc from template"
fi

# Summary
echo ""
echo -e "${GREEN}=== Installation Complete! ===${NC}"
echo ""
echo -e "Next steps:"
echo -e "  1. ${BLUE}Review and customize ~/.zshrc if needed${NC}"
echo -e "  2. ${BLUE}Restart your terminal or run: source ~/.zshrc${NC}"
echo -e "  3. ${BLUE}Install zplug plugins: zplug install${NC}"
echo ""
echo -e "Optional installations:"
echo -e "  • FiraCode Nerd Font: https://www.nerdfonts.com/font-downloads"
echo -e "  • Hyper Terminal: https://hyper.is/"
echo ""
echo -e "Configuration files have been symlinked. Any changes you make in"
echo -e "this repository will automatically be reflected in your environment."
echo ""
