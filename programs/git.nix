{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Guotao He";
	email = "guotao.he.0000@outlook.com";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
    };
  };
}
