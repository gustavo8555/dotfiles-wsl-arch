# Rodar no PowerShell como Administrador, na maquina Windows (nova)
# Fase 1: prepara o WSL2 e instala o Arch Linux oficial

wsl --update
wsl --set-default-version 2
wsl --install archlinux

Write-Host "Abra o Arch (menu Iniciar > Arch Linux) e crie seu usuario quando for solicitado."
Write-Host "Depois disso, va para arch/00-root-setup.sh"
