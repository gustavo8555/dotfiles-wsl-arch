#!/usr/bin/env bash
# Orquestra os passos que assumem que sudo ja esta configurado
# (ou seja: depois de rodar arch/00-root-setup.sh como root).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Isso vai rodar: 01-system-update, 02-shell-setup, 03-dev-tools."
read -r -p "Continuar? [s/N] " confirm
[[ "$confirm" == "s" || "$confirm" == "S" ]] || exit 0

bash "$SCRIPT_DIR/arch/01-system-update.sh"
bash "$SCRIPT_DIR/arch/02-shell-setup.sh"
bash "$SCRIPT_DIR/arch/03-dev-tools.sh"

echo ""
echo "==> Falta: copiar config/.zshrc para ~/.zshrc e config/wsl.conf para /etc/wsl.conf"
echo "==> (esse ultimo precisa de sudo e de 'wsl --shutdown' no PowerShell depois)"
echo "==> Veja o README.md para o passo a passo completo."
