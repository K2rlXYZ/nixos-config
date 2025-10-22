{ config, pkgs, lib, ... }:
{
				programs.chromium = {
								enable = true;
								extensions = [
												"cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock origin
												"nngceckbapebfimnlniiiahkandclblb" # Bitwarden
								];
				};
				environment.systemPackages = with pkgs; [
								brave
				];

# System-wide MIME associations
				xdg.mime = {
								enable = true;
								defaultApplications = {
												"text/html" = "brave-browser.desktop";
												"x-scheme-handler/http" = "brave-browser.desktop";
												"x-scheme-handler/https" = "brave-browser.desktop";
												"x-scheme-handler/about" = "brave-browser.desktop";
												"x-scheme-handler/unknown" = "brave-browser.desktop";
								};
				};

# Set default browser environment variable
				environment.sessionVariables = {
								BROWSER = "brave %u";
				};
}
