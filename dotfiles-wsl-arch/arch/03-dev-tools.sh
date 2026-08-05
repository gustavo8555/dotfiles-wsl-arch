#!/usr/bin/env bash
# Instala Node (via nvm), Python (via pyenv) e Salesforce CLI.
set -euo pipefail

export NVM_DIR="$HOME/.nvm"
if [[ ! -d "$NVM_DIR" ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi
# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"
nvm install --lts

sudo pacman -S --noconfirm python python-pip pyenv

npm install --global @salesforce/cli

echo "==> Node: $(node -v 2>/dev/null || echo '?')"
echo "==> Python: $(python --version 2>/dev/null || echo '?')"
echo "==> sf: $(sf --version 2>/dev/null || echo 'confira o PATH, veja o README')"
