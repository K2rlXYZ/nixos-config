cd ~/nixos-config
sudo cp /etc/nixos/hardware-configuration.nix ./
sudo rm -r /etc/nixos/*
sudo cp -r ./* /etc/nixos/
sudo nix flake update
sudo nixos-rebuild switch --show-trace

/etc/nixos/packages/gnome/dash_to_panel/load_dash_to_panel_conf.sh
