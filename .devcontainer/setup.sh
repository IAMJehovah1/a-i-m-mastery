#!/usr/bin/env bash
# A-I-M Mastery Sandbox — automated setup script
# Runs once when the Codespace/devcontainer is first created.
set -euo pipefail

RESET='\033[0m'
BOLD='\033[1m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

info()    { echo -e "${CYAN}[sandbox]${RESET} $*"; }
success() { echo -e "${GREEN}[sandbox] ✔${RESET} $*"; }
warn()    { echo -e "${YELLOW}[sandbox] ⚠${RESET} $*"; }

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}║        A-I-M Mastery Sandbox — Setup             ║${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════════════════╝${RESET}"
echo ""

# ── Node.js tooling ──────────────────────────────────────────────────────────
info "Installing global Node.js utilities..."
npm install -g \
  wrangler \
  http-server \
  prettier \
  markdownlint-cli2 \
  2>/dev/null
success "Node.js utilities installed"

# ── Python tooling ───────────────────────────────────────────────────────────
info "Installing Python utilities..."
pip install --quiet --upgrade \
  requests \
  httpx \
  rich \
  openai
success "Python utilities installed"

# ── Oh-My-Zsh plugins ────────────────────────────────────────────────────────
if [ -d "${HOME}/.oh-my-zsh" ]; then
  info "Configuring Zsh plugins..."
  ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

  if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
    git clone --quiet https://github.com/zsh-users/zsh-autosuggestions \
      "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
  fi

  if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
    git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting \
      "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
  fi

  # Enable plugins in .zshrc
  sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting gh node npm python)/' \
    "${HOME}/.zshrc" 2>/dev/null || true

  success "Zsh plugins configured"
fi

# ── Sandbox aliases ──────────────────────────────────────────────────────────
info "Adding sandbox shell aliases..."
cat >> "${HOME}/.zshrc" << 'ALIASES'

# ── A-I-M Mastery Sandbox ──────────────────────────────────────────────────
alias aim-serve='http-server sandbox/ -p 3000 -c-1 --cors'
alias aim-fmt='prettier --write "**/*.{js,ts,json,md,html,css}" 2>/dev/null'
alias aim-lint='markdownlint-cli2 "**/*.md" 2>/dev/null'
alias aim-status='echo "📦 Sandbox: $(pwd)" && git status --short'
ALIASES

cat >> "${HOME}/.bashrc" << 'ALIASES'
alias aim-serve='http-server sandbox/ -p 3000 -c-1 --cors'
alias aim-fmt='prettier --write "**/*.{js,ts,json,md,html,css}" 2>/dev/null'
alias aim-lint='markdownlint-cli2 "**/*.md" 2>/dev/null'
alias aim-status='echo "📦 Sandbox: $(pwd)" && git status --short'
ALIASES

success "Aliases added (aim-serve, aim-fmt, aim-lint, aim-status)"

# ── Welcome message ──────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}✅ Sandbox ready!${RESET}"
echo ""
echo "  Quick commands:"
echo "    aim-serve   — serve the sandbox dashboard on port 3000"
echo "    aim-fmt     — format all files with Prettier"
echo "    aim-lint    — lint Markdown files"
echo "    aim-status  — git status shorthand"
echo ""
echo "  Open sandbox/index.html in Live Server for a gorgeous view."
echo ""
