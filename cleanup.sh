#!/usr/bin/env zsh

#
# Dot-files Cleanup Script
#
# This script removes backup files created by install.sh
# Backup files follow the pattern: *.backup.YYYYMMDD_HHMMSS
#
# Run with: ./cleanup.sh
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Dot-files Backup Cleanup ===${NC}"
echo ""

# Find all backup files in home directory
# Pattern: *.backup.YYYYMMDD_HHMMSS
BACKUP_FILES=$(find "$HOME" -maxdepth 1 -type f -name "*.backup.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" 2>/dev/null)

if [ -z "$BACKUP_FILES" ]; then
    echo -e "${GREEN}No backup files found!${NC}"
    echo "Your home directory is clean."
    exit 0
fi

# Count backup files
BACKUP_COUNT=$(echo "$BACKUP_FILES" | wc -l)

echo -e "${YELLOW}Found $BACKUP_COUNT backup file(s):${NC}"
echo ""

# List all backup files
echo "$BACKUP_FILES" | while read -r file; do
    FILE_SIZE=$(du -h "$file" | cut -f1)
    FILE_NAME=$(basename "$file")
    echo -e "  ${BLUE}•${NC} $FILE_NAME (${FILE_SIZE})"
done

echo ""
echo -e "${YELLOW}These files will be permanently deleted.${NC}"
echo -n "Do you want to continue? [y/N]: "
read -r RESPONSE

if [[ ! "$RESPONSE" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Cleanup cancelled.${NC}"
    exit 0
fi

# Delete backup files
echo ""
echo -e "${BLUE}Removing backup files...${NC}"

DELETED=0
echo "$BACKUP_FILES" | while read -r file; do
    if rm "$file"; then
        echo -e "${GREEN}✓${NC} Removed: $(basename "$file")"
        DELETED=$((DELETED + 1))
    else
        echo -e "${RED}✗${NC} Failed to remove: $(basename "$file")"
    fi
done

echo ""
echo -e "${GREEN}=== Cleanup Complete! ===${NC}"
echo -e "Removed $BACKUP_COUNT backup file(s)."
echo ""
