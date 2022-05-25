{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.xmonad;
in
{

  options = {
    modules.xmonad.enable = mkEnableOption "xmonad";
  };

  config = mkIf cfg.enable {
    modules.pipewire.enable = true;
    hardware.opengl.enable = true;
    services.xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        enableConfiguredRecompile = true;
        #config = builtins.readFile ./../../config/xmonad/xmonad.hs;
      };
      displayManager.defaultSession = "none+xmonad";
      displayManager.lightdm.enable = true;
      layout = "us";
      xkbVariant = "colemak";
      xkbOptions = "grp:win_space_toggle";
    };

    environment.systemPackages = with pkgs; [
      haskellPackages.xmobar
      bemenu
      pstree # for xmonad swallowing
      trayer # tray icons
      feh # wallpaper
      imv # or sxiv
      cmus # music player
      betterlockscreen 
      xclip 
      maim
      firefox
      alacritty
      pulsemixer
      mpv 
      zathura
      bashmount
    ];

    hm.xdg.configFile."xmonad/xmonad.hs".source = ./../../config/xmonad/xmonad.hs;
    hm.xdg.configFile."xmobar/xmobarrc".source = ./../../config/xmobar/xmobarrc;
    # wallpaper todo

  };

}