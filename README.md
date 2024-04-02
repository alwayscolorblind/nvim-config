### Neovim config based on NvChad
NeoVim congig based on NvChad for JavaScript/TypeScript and Rust development.
## Installation
- Download neovim using package manager
- Install NvChad v2.0 (be careful main NvChad version is v2.5 now is incompatable)
  ```git clone -b "v2.0" git@github.com:NvChad/NvChad.git ~/.config/nvim --depth 1```
- Clone repo
- Install configs using linux `cp` command
  ```cp /dist/to/nvim-config ~/.config/nvim```
- Install Mason dependencies:
  ```
  clang-format
  clangd
  css-lsp
  css-variables-language-server
  deno
  emmet-language-server
  emmt-ls
  eslint-lsp
  html-lsp
  lua-language-server
  prettier
  rstcheck
  rust-analyzer
  stylua
  tailwindcss-language-server
  typescript-language-server
  ```
  - Run `:MasonInstallAll`
  - Enjoy!!!
