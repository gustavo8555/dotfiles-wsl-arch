#!/usr/bin/env bash
# Instala o Starship e define zsh como shell padrao.
set -euo pipefail

curl -sS https://starship.rs/install.sh | sh -s -- --yes

ZSH_PATH="$(command -v zsh)"
grep -qxF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells
[[ "${SHELL:-}" == "$ZSH_PATH" ]] || chsh -s "$ZSH_PATH"

echo "==> zsh definido como shell padrao (feche e reabra o terminal para aplicar)."
echo "==> Copie config/.zshrc para ~/.zshrc (ou mescle com o seu)."
