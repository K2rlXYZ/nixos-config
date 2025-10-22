{pkgs, lib, ...}:
let
winboat = import ./winboat { inherit pkgs; };
in
{
				environment.systemPackages = with pkgs; [
								gitFull
												wget
												discord
												wireshark-qt
												wireguard-tools
												perl540Packages.AppClusterSSH
												telegram-desktop
												signal-desktop
												easyeffects
												nmap
												obsidian
												qbittorrent-enhanced
												stremio
												youtube-music
												qdirstat
												bitwarden
												qdigidoc

												jetbrains.datagrip
												stdenv.cc.cc.lib
												zlib
												go

												winboat
												freerdp
												];

				nixpkgs.config.allowUnfreePredicate = pkg:
								builtins.elem (lib.getName pkg) [
								"discord"
												"datagrip"
												"vscode"
												"steam"
												"steam-unwrapped"
												"obsidian"
												"stremio-shell"
												"stremio-server"
								];

#Tailscale
				services.tailscale.enable = true;

#Steam
				programs.steam = {
								enable = true;
								remotePlay.openFirewall = true; 
								dedicatedServer.openFirewall = true;
								localNetworkGameTransfers.openFirewall = true;
								protontricks.enable = true;
				};
}
