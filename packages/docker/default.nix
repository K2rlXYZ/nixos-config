{pkgs, lib, ...}:
{
				virtualisation.docker = {
								enable = true;
				};

				users.users.nix.extraGroups = [ "docker" ];
}
