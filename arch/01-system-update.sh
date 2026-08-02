#!/usr/bin/env bash
# Rodar como usuario normal (com sudo ja funcionando).
set -euo pipefail

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel git curl wget unzip zsh openssh which man-db

echo "==> Sistema atualizado e pacotes base instalados."
