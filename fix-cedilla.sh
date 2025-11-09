#!/usr/bin/env bash

set -euo pipefail

# Modern Cedilla Fix Script (2025)
# Supports: X11, Wayland, GTK2/3/4, Qt/Plasma

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
    log_error "Please run with sudo"
    exit 1
fi

backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        if [ ! -f "${file}.bak" ]; then
            cp "$file" "${file}.bak"
            log_info "Backed up: $file"
        else
            log_warn "Backup already exists: ${file}.bak"
        fi
        return 0
    fi
    return 1
}

# ============================================================================
# X11 Compose File Configuration
# ============================================================================
fix_x11_compose() {
    log_info "Fixing X11 Compose files..."

    local compose_file='/usr/share/X11/locale/en_US.UTF-8/Compose'

    if [ -f "$compose_file" ]; then
        backup_file "$compose_file"
        sed -i 's/ć/ç/g; s/Ć/Ç/g' "$compose_file"
        log_info "X11 Compose file updated"
    else
        log_warn "X11 Compose file not found: $compose_file"
    fi
}

# ============================================================================
# GTK Input Module Configuration (GTK2/3/4)
# ============================================================================
find_gtk_immodules() {
    local gtk_version="$1"
    # Search in common locations for different distributions
    find /usr/lib* /usr/local/lib* -path "*/gtk-${gtk_version}.0/*/immodules.cache" 2>/dev/null | head -1
}

fix_gtk_immodules() {
    log_info "Fixing GTK input modules..."

    local search_pattern='^"cedilla".*:en'
    local sed_expression='s/^\("cedilla".*:wa\)/\1:en/g'

    for gtk_ver in 2 3 4; do
        local gtk_file=$(find_gtk_immodules "$gtk_ver")

        if [ -n "$gtk_file" ] && [ -f "$gtk_file" ]; then
            backup_file "$gtk_file"

            if ! grep -q "$search_pattern" "$gtk_file"; then
                sed -i "$sed_expression" "$gtk_file"
                log_info "GTK${gtk_ver} immodules updated: $gtk_file"
            else
                log_info "GTK${gtk_ver} already configured: $gtk_file"
            fi
        else
            log_warn "GTK${gtk_ver} immodules.cache not found"
        fi
    done
}

# ============================================================================
# Environment Variables Configuration
# ============================================================================
fix_environment() {
    log_info "Configuring environment variables..."

    local env_file='/etc/environment'
    local vars=(
        'GTK_IM_MODULE=cedilla'
        'QT_IM_MODULE=cedilla'
        'XMODIFIERS=@im=cedilla'
    )

    if [ -f "$env_file" ]; then
        backup_file "$env_file"

        for var in "${vars[@]}"; do
            if ! grep -q "^${var}$" "$env_file"; then
                echo "$var" >> "$env_file"
                log_info "Added to $env_file: $var"
            else
                log_info "Already set: $var"
            fi
        done
    else
        log_error "Environment file not found: $env_file"
    fi
}

# ============================================================================
# Qt/Plasma Configuration
# ============================================================================
fix_qt_plasma() {
    log_info "Configuring Qt/Plasma..."

    # Create Qt configuration directory if it doesn't exist
    local qt_config_dir="/etc/xdg"
    local qt_env_file="${qt_config_dir}/plasma-workspace/env/cedilla.sh"

    mkdir -p "$(dirname "$qt_env_file")"

    cat > "$qt_env_file" <<'EOF'
#!/bin/sh
# Cedilla input configuration for Plasma
export GTK_IM_MODULE=cedilla
export QT_IM_MODULE=cedilla
export XMODIFIERS=@im=cedilla
EOF

    chmod +x "$qt_env_file"
    log_info "Created Plasma startup script: $qt_env_file"

    # Also create for Qt5/Qt6 separately if needed
    for qt_ver in qt5ct qt6ct; do
        local qt_conf="/etc/xdg/${qt_ver}/${qt_ver}.conf"
        if [ -d "/etc/xdg/${qt_ver}" ]; then
            log_info "Qt configuration found for ${qt_ver}"
        fi
    done
}

# ============================================================================
# Wayland Input Method Configuration
# ============================================================================
fix_wayland() {
    log_info "Configuring Wayland input methods..."

    # For Wayland compositors (especially GNOME/Mutter)
    local wayland_env="/etc/profile.d/cedilla-wayland.sh"

    cat > "$wayland_env" <<'EOF'
#!/bin/sh
# Cedilla configuration for Wayland
export GTK_IM_MODULE=cedilla
export QT_IM_MODULE=cedilla
# For Wayland compositors
export WAYLAND_IM_MODULE=cedilla
EOF

    chmod +x "$wayland_env"
    log_info "Created Wayland configuration: $wayland_env"
}

# ============================================================================
# IBus Configuration (if used)
# ============================================================================
fix_ibus() {
    if command -v ibus &> /dev/null; then
        log_info "Configuring IBus for cedilla..."

        # Check if user wants IBus or cedilla module
        local ibus_env="/etc/profile.d/cedilla-ibus.sh"
        cat > "$ibus_env" <<'EOF'
#!/bin/sh
# Prefer cedilla over IBus for cedilla character
export GTK_IM_MODULE=cedilla
export QT_IM_MODULE=cedilla
EOF
        chmod +x "$ibus_env"
        log_info "IBus override created"
    fi
}

# ============================================================================
# Main Execution
# ============================================================================
main() {
    log_info "Starting cedilla fix for modern Linux (2025)"
    log_info "System: Wayland/X11 | GTK2/3/4 | Qt/Plasma"
    echo

    fix_x11_compose
    fix_gtk_immodules
    fix_environment
    fix_qt_plasma
    fix_wayland
    fix_ibus

    echo
    log_info "Configuration complete!"
    log_info "Please log out and log back in for changes to take effect"
    log_info "Or run: source /etc/environment"
    echo
    log_warn "If using GNOME, you may also need to run:"
    log_warn "  gsettings set org.gnome.desktop.input-sources sources \"[('xkb', 'us+intl')]\""
}

main "$@"
