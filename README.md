### Neovim config based on NvChad
NeoVim config based on NvChad for JS/TS and Rust development.
## Installation
- Download neovim using package manager
- Install last NvChad version
- Clone repo
- Install configs using linux `cp` command
  ```cp -rf /dist/to/nvim-config ~/.config/nvim```
- Run `:MasonInstallAll`
- Enjoy!!!
### Known issues
- Issue with `vscode-eslint-language-server`
  Just install vscode-eslint-language-server using
    - Arch: `yay -S vscode-langservers-extracted`
    - Other: `npm i -g vscode-langservers-extracted`
### TODO
- fix gruvbox compatibility
- add textobjects keymaps like zed does (keymaps.lua)
