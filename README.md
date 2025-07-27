### Neovim config based on NvChad
NeoVim config based on NvChad for JavaScript/TypeScript and Rust development.
## Installation
- Download neovim using package manager
- Install NvChad v2.0 (be careful main NvChad version v2.5 now is incompatable)
  ```git clone -b "v2.0" git@github.com:NvChad/NvChad.git ~/.config/nvim --depth 1```
- Clone repo
- Install configs using linux `cp` command
  ```cp -rf /dist/to/nvim-config/* ~/.config/nvim```
- Run `:MasonInstallAll`
- Enjoy!!!
### Known issues
- Issue with `vscode-eslint-language-server`
  Just install vscode-eslint-language-server using
    - Arch: `yay -S vscode-langservers-extracted`
    - Other: `npm i -g vscode-langservers-extracted`
### TODO
- Make migration to v2.5 NvChad
