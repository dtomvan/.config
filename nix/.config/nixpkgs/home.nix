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

    home.packages = [
        pkgs.tree-sitter
        pkgs.gcc
    ];

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
        plugins = with pkgs; [
            vimPlugins.packer-nvim
            vimPlugins.nvim-lspconfig
            vimPlugins.lsp_extensions-nvim
            vimPlugins.nvim-treesitter
            vimPlugins.impatient-nvim
            vimPlugins.popup-nvim
            vimPlugins.plenary-nvim
            vimPlugins.vim-surround
            vimPlugins.vim-git
            vimPlugins.vim-fugitive
            vimPlugins.vim-eunuch
            vimPlugins.vim-unimpaired
            vimPlugins.vim-repeat
            vimPlugins.vim-vinegar
            vimPlugins.vim-sleuth
            vimPlugins.comment-nvim
            vimPlugins.presence-nvim
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
