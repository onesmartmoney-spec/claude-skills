#!/bin/bash
# Setup Script for Claude Skills Library
# Installiert Bash-Aliases und bereitet Umgebung vor

set -e

echo "🚀 Claude Skills Setup"
echo "====================="

SKILLS_DIR="$HOME/.claude/skills"
ALIASES_FILE="$HOME/.claude-skills-aliases"

# Check if skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
    echo "❌ Skills directory not found at $SKILLS_DIR"
    exit 1
fi

echo "✅ Skills directory found: $SKILLS_DIR"

# Create aliases file
cat > "$ALIASES_FILE" << 'EOF'
# Claude Skills Aliases
# Source this file in your shell config (~/.bashrc, ~/.zshrc, etc.)

alias find-skill='npx skills find'
alias list-skills='npx skills list'
alias skills-help='cat ~/.claude/skills/README.md | less'

# Search skills in REGISTRY.json
find-skill-local() {
    if [ -z "$1" ]; then
        echo "Usage: find-skill-local <query>"
        echo ""
        echo "Available skills:"
        cat ~/.claude/skills/REGISTRY.json | jq -r '.skills[] | .name'
        return 0
    fi

    echo "Searching for: $1"
    cat ~/.claude/skills/REGISTRY.json | jq ".skills[] | select(.name | contains(\"$1\") or .description | contains(\"$1\"))"
}

# List all skills with commands
list-skills-all() {
    echo "📚 Claude Skills Library"
    echo "========================"
    cat ~/.claude/skills/REGISTRY.json | jq -r '.skills[] | "\(.name) (\(.commands) commands): \(.description)"'
}

# Show skill details
skill-details() {
    if [ -z "$1" ]; then
        echo "Usage: skill-details <skill-name>"
        return 1
    fi

    cat ~/.claude/skills/REGISTRY.json | jq ".skills[] | select(.name == \"$1\")"
}

# Open skill in editor
edit-skill() {
    if [ -z "$1" ]; then
        echo "Usage: edit-skill <skill-name>"
        return 1
    fi

    SKILL_PATH="$HOME/.claude/skills/$1/SKILL.md"
    if [ ! -f "$SKILL_PATH" ]; then
        echo "❌ Skill not found: $1"
        return 1
    fi

    ${EDITOR:-nano} "$SKILL_PATH"
}

# Export functions
export -f find-skill-local
export -f list-skills-all
export -f skill-details
export -f edit-skill
EOF

echo "✅ Created: $ALIASES_FILE"
echo ""
echo "📋 Next steps:"
echo ""
echo "1. Add to your ~/.bashrc or ~/.zshrc:"
echo "   source $ALIASES_FILE"
echo ""
echo "2. Reload shell:"
echo "   source ~/.bashrc   # or ~/.zshrc"
echo ""
echo "3. Test aliases:"
echo "   find-skill-local email       # Search locally"
echo "   list-skills-all              # Show all skills"
echo "   skill-details email-messages # Show skill details"
echo "   edit-skill email-messages    # Edit skill"
echo ""
echo "✨ Setup complete!"
