{pkgs, lib, config, ... }:
{

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    gnome-extension-manager

    gnomeExtensions.todotxt
    gnomeExtensions.cmud
    gnomeExtensions.timer
    gnomeExtensions.gtile
    gnomeExtensions.unblank
    gnomeExtensions.dash-to-panel
    gnomeExtensions.appindicator

    lm_sensors
    gnomeExtensions.freon
  ];
  services.udev.packages = [ pkgs.gnome-settings-daemon ];

  programs.dconf.profiles.user.databases = [
    {
      settings = {
         "org/gnome/desktop/wm/preferences".button-layout = "minimize,maximize,close";
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            pkgs.gnomeExtensions.todotxt.extensionUuid
            pkgs.gnomeExtensions.cmud.extensionUuid
            pkgs.gnomeExtensions.timer.extensionUuid
            pkgs.gnomeExtensions.gtile.extensionUuid
            pkgs.gnomeExtensions.freon.extensionUuid
            pkgs.gnomeExtensions.ip-finder.extensionUuid
            pkgs.gnomeExtensions.unblank.extensionUuid
            pkgs.gnomeExtensions.dash-to-panel.extensionUuid
            pkgs.gnomeExtensions.appindicator.extensionUuid
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/tmux-terminal/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/brave/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/tmux-terminal" = {
          binding = "<Super>g";
          command = ''kgx -e "tmux attach"'';
          name = "open-terminal";      
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/brave" = {
          binding = "<Super>b";
          command = ''brave %u'';
          name = "open-brave";      
        };
      };
    }
  ];
}


