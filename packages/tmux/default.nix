{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      resurrect
    ];
    extraConfig = ''
      resurrect_dir="$HOME/.tmux/resurrect"

      set -g @resurrect-strategy-vim 'session'
      set -g @resurrect-strategy-nvim 'session'
      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-processes 'vim nvim hx cat less more tail watch'

      set -g @resurrect-dir $resurrect_dir
      set -g @resurrect-hook-post-save-all "sed 's/--cmd[^ ]* [^ ]* [^ ]*//g' $resurrect_dir/last | sponge $resurrect_dir/last"

      new-session -n $HOST
      run-shell "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh"
    '';
  };
}
