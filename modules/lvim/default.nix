{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.lvim;
in
{

  options = {
    modules.lvim.enable = mkEnableOption "lvim";
  };

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs; [
      python # python39Packages.pip
      gnumake # for the installer
      gcc # for treesitter
      git
      nodejs
      rustup # cargo 

      # since nvim-lsp-installer LSP binaries don't work on nixos
      rust-analyzer
      sumneko-lua-language-server

      black # python formater
    ];

    hm.xdg.configFile."lvim/config.lua" = {
      source = ./../../config/lvim/config.lua;
    };
  };

}
