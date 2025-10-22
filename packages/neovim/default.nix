{pkgs, ...}: let
  # List of custom packages
  easygrep = pkgs.vimUtils.buildVimPlugin {
    name = "vim-easygrep";
    src = pkgs.fetchFromGitHub {
      owner = "dkprice";
      repo = "vim-easygrep";
      rev = "d0c36a77cc63c22648e792796b1815b44164653a";
      sha256 = "0y2p5mz0d5fhg6n68lhfhl8p4mlwkb82q337c22djs4w5zyzggbc";
    };
  };

  conformConfig = pkgs.vimUtils.buildVimPlugin {
    name = "conform-config";
    src = pkgs.writeTextDir "plugin/conform-config.lua" ''
            require("conform").setup({
              formatters_by_ft = {
                markdown = { "injected" },
                rust = { "rustfmt", "injected" },
                nix = { "alejandra", "injected" },
                typst = { "typstyle", "injected" },
                sh = { "shfmt" },
                sql = { "sql-formatter" },
                kdl = { "kdlfmt" },
                json = { "jq" },
              },
            })
            vim.api.nvim_create_user_command("Format", function()
              require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format buffer with conform.nvim" })
    '';
  };

  # Use customRC for simple config but if you want your configuration to be in multiple files, you
  # can just package them as a plugin as plugins respect the hierarchie of .config/nvim file
  # as presented for instance here.
  # https://github.com/nanotee/nvim-lua-guide
  myConfig = pkgs.vimUtils.buildVimPlugin {
    name = "my-config";
    # Create in this directory a file like my-neovim-config/lua/init.lua, to load as below in customRC using
    # lua require("init")
    src = ./nvim-conf-folder;
  };

  # The neovim package with your configuration
  myNeovim = pkgs.neovim.override {
    configure = {
      customRC = ''
            :colorscheme evening
            lua require("init")
        :autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          # vim-go # already packaged plugin
          easygrep # custom package not packaged in nixpkgs
          fzf-vim
          conform-nvim
          myConfig # my own configuration
          conformConfig
        ];
        opt = [];
      };
    };
  };
in {
  environment.systemPackages = with pkgs; [
    alejandra
    typstyle
    shfmt
    sql-formatter
    kdlfmt
    jq

    myNeovim
    wl-clipboard
  ];
}
