{
  pkgs,
  lib,
  ...
}: let
  wallpaperEngineIcon = pkgs.fetchurl {
    url = "https://shared.fastly.steamstatic.com/community_assets/images/apps/431960/72edaed9d748c6cf7397ffb1c83f0b837b9ebd9d.jpg";
    sha256 = "sha256-LRklvkyi6Wgi6W3US/zG6tgZD8Ocf7LOrFHais6kXBc=";
  };
in {
  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    protontricks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprpaper 
    (makeDesktopItem {
      name = "Wallpaper-Engine";
      desktopName = "WallpaperEngine";
      exec = "steam steam://rungameid/431960";
      icon = "${wallpaperEngineIcon}";
      categories = ["Game"];
    })
  ];
}
