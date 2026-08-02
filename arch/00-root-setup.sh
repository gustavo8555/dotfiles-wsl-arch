#!/usr/bin/env bash
# Rodar como ROOT, logo apos criar o usuario na primeira execucao do Arch.
# A imagem oficial do Arch para WSL nao vem com sudo pronto.
#
# Do PowerShell: wsl -d archlinux -u root
# Dentro do Arch, como root: bash 00-root-setup.sh <seu-usuario>

set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Rode este script como root (wsl -d archlinux -u root)." >&2
  exit 1
fi

TARGET_USER="${1:?Uso: 00-root-setup.sh <usuario>}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pacman -Syu --noconfirm
pacman -S --noconfirm sudo

install -Dm440 "$SCRIPT_DIR/../config/sudoers-wheel" /etc/sudoers.d/wheel
usermod -aG wheel "$TARGET_USER"

echo "==> sudo configurado. Usuario '$TARGET_USER' adicionado ao grupo wheel."
echo "==> Saia (exit) e reabra como esse usuario: wsl -d archlinux"
