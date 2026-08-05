# dotfiles-wsl-arch

Setup do meu ambiente de desenvolvimento: **WSL2 + Arch Linux + zsh**, com Node
(nvm), Python (pyenv) e Salesforce CLI. Feito pra reproduzir em qualquer PC
Windows novo em poucos passos.

> ⚠️ `config/zshrc` é uma reconstrução baseada nos comandos rodados durante o
> setup original — confira com o `~/.zshrc` real da sua máquina de origem
> antes de confiar 100% nele numa reinstalação.

## Uso numa máquina nova

### 1. Windows — instalar o WSL2 e o Arch

No PowerShell **como Administrador**:
```powershell
.\windows\bootstrap.ps1
```
(ou rode os 3 comandos de dentro do arquivo manualmente)

Isso instala o Arch Linux oficial via `wsl --install archlinux`. Na primeira
abertura, ele pede para criar um usuário e senha Linux — anote o nome de
usuário, você vai precisar dele no próximo passo.

### 2. Arch — configurar o sudo

A imagem oficial do Arch **não vem com `sudo` pronto**. Do PowerShell:
```powershell
wsl -d archlinux -u root
```
Dentro do Arch, como root:
```bash
bash arch/00-root-setup.sh <seu-usuario>
```
Saia (`exit`) e reabra normal (`wsl -d archlinux`).

### 3. Arch — sistema, shell e ferramentas de dev

Já como seu usuário normal:
```bash
./install.sh
```
Isso roda em sequência: atualização do sistema, zsh + Starship como shell
padrão, e Node/Python/Salesforce CLI.

(Ou rode cada script separado: `arch/01-system-update.sh`,
`arch/02-shell-setup.sh`, `arch/03-dev-tools.sh` — e `arch/04-docker-setup.sh`
se quiser Docker Engine nativo em vez do Docker Desktop.)

### 4. Aplicar as configs

```bash
cp config/zshrc ~/.zshrc
source ~/.zshrc
```

Para o `wsl.conf` (evita que binários do Windows, tipo um Salesforce CLI
instalado no Windows, vazem pro PATH do Linux):
```bash
sudo cp config/wsl.conf /etc/wsl.conf
```
Depois, do **PowerShell**:
```powershell
wsl --shutdown
```

## Estrutura

```
windows/bootstrap.ps1      # instala WSL2 + Arch (roda no Windows)
arch/00-root-setup.sh      # sudo + grupo wheel (roda como root)
arch/01-system-update.sh   # pacman -Syu + pacotes base
arch/02-shell-setup.sh     # Starship + zsh como shell padrão
arch/03-dev-tools.sh       # nvm/Node, pyenv/Python, Salesforce CLI
arch/04-docker-setup.sh    # opcional: Docker Engine nativo
config/zshrc               # ~/.zshrc de referência
config/wsl.conf            # /etc/wsl.conf (desliga appendWindowsPath)
config/sudoers-wheel       # /etc/sudoers.d/wheel
install.sh                 # roda 01, 02 e 03 em sequência
```

## Problemas conhecidos (e por que as configs daqui existem)

- **`sudo: command not found`** logo de cara → a imagem oficial do Arch não
  vem com sudo. Resolvido pelo `00-root-setup.sh`.
- **`chsh: "..." is not listed in /etc/shells`** → `02-shell-setup.sh` já
  adiciona o caminho do zsh em `/etc/shells` antes de trocar o shell.
- **`sf` executando um `.cmd` do Windows dentro do bash** (erros tipo
  `@echo: command not found`) → binário do Salesforce CLI instalado no
  Windows aparecendo no PATH do Linux via interop do WSL. Resolvido
  desabilitando `appendWindowsPath` no `wsl.conf`.
