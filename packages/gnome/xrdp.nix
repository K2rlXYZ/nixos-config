{pkgs, lib, ...}:
{
  services.xrdp = {
    enable = true;
    defaultWindowManager = "${pkgs.writeScript "xrdp-gnome-start" ''
      #!/bin/sh
      export XDG_SESSION_TYPE=x11
      export GDK_BACKEND=x11
      export XDG_CURRENT_DESKTOP=GNOME
      export XDG_SESSION_DESKTOP=gnome
      export GNOME_SHELL_SESSION_MODE=classic
      
      ${pkgs.dbus}/bin/dbus-run-session ${pkgs.gnome-session}/bin/gnome-session --session=gnome-classic
    ''}";
    openFirewall = true;
  };
  
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };
  
  security.polkit.enable = true;
  
  # Disable sleep/suspend
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
