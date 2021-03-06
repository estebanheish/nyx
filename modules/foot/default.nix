{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.foot;
in
{

  options = {
    modules.foot.enable = mkEnableOption "foot";
  };

  config = mkIf cfg.enable {
    hm.xdg.configFile."foot/foot.ini".source = ./../../config/foot/foot.ini;
    hm.home.packages = [ pkgs.foot pkgs.ubuntu_font_family ];
  };

}
