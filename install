#!/bin/bash
set -e

echo "======================================================"
echo "🚀 Installing Agintes R (Multi-Agent Swarm Orchestrator)"
echo "======================================================"

# 1. Install Bun if it's not installed (Required for Agintes R)
if ! command -v bun &> /dev/null; then
    echo "📦 Installing Bun (Fast JavaScript Runtime)..."
    curl -fsSL https://bun.sh/install | bash
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
else
    echo "✅ Bun is already installed."
fi

# 2. Clone or pull the repository
INSTALL_DIR="$HOME/.agintes-r"
if [ -d "$INSTALL_DIR" ]; then
    echo "🔄 Updating existing Agintes R installation..."
    cd "$INSTALL_DIR"
    git pull origin main
else
    echo "📥 Downloading Agintes R source code..."
    git clone https://github.com/tjarb8521-ux/Agintes-R.git "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

# 3. Install dependencies
echo "⚙️  Installing system dependencies (this may take a moment)..."
bun install

# 4. Create the 'agintes' global command
echo "🔗 Setting up 'agintes' command-line interface..."
mkdir -p "$HOME/.local/bin"

cat << 'EOF' > "$HOME/.local/bin/agintes"
#!/bin/bash
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
bun run "$HOME/.agintes-r/packages/cli/src/index.ts" "$@"
EOF

chmod +x "$HOME/.local/bin/agintes"

# Add to path temporarily for this session
export PATH="$HOME/.local/bin:$PATH"

echo "======================================================"
echo "🎉 Installation Complete!"
echo ""
echo "To start using Agintes R, make sure your local bin is in your PATH."
echo "Run this command now to activate it in your current terminal:"
echo 'export PATH="$HOME/.local/bin:$PATH"'
echo ""
echo "Then simply type:"
echo "👉 agintes --help"
echo "======================================================"
