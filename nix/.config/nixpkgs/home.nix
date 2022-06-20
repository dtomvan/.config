{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tomvd";
  home.homeDirectory = "/home/tomvd";
  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    bat
    gnupg
  ];

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
    settings = {
      git_protocol = "https";
      editor = "nvim";
      prompt = "enabled";
      pager = "bat";
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    delta = { enable = true; };
    signing = {
       key = "7A984C8207ADBA51";
       signByDefault = true;
    };
    userEmail = "18gatenmaker6@gmail.com";
    userName = "Tom van Dijk";
    extraConfig = {
      diff = {
        tool = "nvimdiff";
      };
      merge = {
        conflictStyle = "diff3";
        tool = "nvimdiff";
      };
      diff = {
        colorMoved = "default";
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autosquash = true;
      };
      format = {
        pretty = "fuller";
      };
      sendemail = {
        smtpserver = "smtp-mail.outlook.com";
        smtpuser = "129102@dr.nassaucollege.nl";
        smtpencryption = "tls";
        smtpserverport = "587";
      };
      commit = {
        template = "~/.gitmessage";
      };
      advice = {
        detachedHead = false;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      let g:did_load_filetypes=1
      lua << EOF
      package.loaded.globals = nil
      require 'dtomvan.globals'
      R 'dtomvan.plugins'
      R 'dtomvan.opts'
      R 'dtomvan.lsp'
      R 'dtomvan.keymaps'
      R 'dtomvan.au'
      R 'dtomvan.cmd'

      -- abbreviations
      EX.noreabbrev('fcd', 'cd %:p:h')
      EX.noreabbrev('help', 'Telescope help_tags')
      require('Comment').setup {}
      EOF
    '';
    package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [
      pkgs.tree-sitter
      pkgs.gccStdenv
    ];
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      packer-nvim
      nvim-lspconfig
      lsp_extensions-nvim
      impatient-nvim
      popup-nvim
      plenary-nvim
      vim-surround
      vim-git
      vim-fugitive
      vim-eunuch
      vim-unimpaired
      vim-repeat
      vim-vinegar
      vim-sleuth
      comment-nvim
      presence-nvim
    ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

# vim:shiftwidth=4
