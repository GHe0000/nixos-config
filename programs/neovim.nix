{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # plenary-nvim
      # telescope-nvim
      # nvim-lspconfig
      # cmp-nvim-lsp
      # fidget-nvim
      # neodev-nvim
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.cpp
        p.python
        p.lua
        p.nix
        p.markdown
        p.markdown_inline
        p.vim
        p.vimdoc
        p.bash
        p.json
      ]))
    ];

    extraPackages = with pkgs; [
      nil
    ];
  };
}
