# dotfiles

Meus arquivos de configuração, mantenho o projeto aqui para sincronização entre os computadores que utilizo.

## Linux e macOS

Abra o bash e execute o script `install.sh` para realizar a instalação inicial do ZSH e outros utilitários. Depois, pode fechar o terminal bash e executar novamente o `install.sh` no ZSH. Se quiser pode já informar o email que será utilizado para commits no git.

```shell
install.sh andres@company.com
```

## Windows

Abra o PowerShell como administrador na pasta do projeto. Se a política de execução bloquear o script, libere a execução somente para a sessão atual e execute-o:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\windows.ps1
```

O script instala via winget os aplicativos que ainda não estão instalados, configura o Git, instala as fontes Powerline e configura o WSL com Ubuntu. Alguns instaladores podem solicitar confirmação do UAC; o script aguarda a conclusão antes de continuar. A instalação do WSL pode exigir a reinicialização do Windows.

Programas para instalação manual no Windows:

- https://conemu.github.io/en/Downloads.html
- https://winmerge.org/downloads/?lang=en
- https://www.logitech.com/pt-br/software/logi-options-plus#blade-quick-links
- https://www.jetbrains.com/idea/download/
- https://notepad-plus-plus.org/downloads/
- https://www.postman.com/downloads/
- https://dbeaver.io/download/
