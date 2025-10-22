{pkgs, lib, ...}:
{
  environment.shellAliases = {
    v = "nvim";
    tmuxa = "tmux attach";
    ggarbage = "sudo nix-collect-garbage -d";
  };
}
