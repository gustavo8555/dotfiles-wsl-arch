#!/usr/bin/env bash
# Opcional: Docker Engine nativo dentro do Arch (alternativa ao Docker Desktop).
set -euo pipefail

sudo pacman -S --noconfirm docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

echo "==> Feche e reabra o terminal para o grupo docker valer."
