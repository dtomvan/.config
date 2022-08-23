-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

require('nvim-treesitter.configs').setup {
    --    ensure_installed = {
    --        -- If you want an easy overview, select all of them and
    --        -- type :!column -t -s' '<cr>
    --        'bash',
    --        'c',
    --        'cmake',
    --        'comment',
    --        'cpp',
    --        'c_sharp',
    --        'css',
    --        'dart',
    --        'dockerfile',
    --        'fennel',
    --        'fish',
    --        'gdscript',
    --        'go',
    --        'gomod',
    --        'graphql',
    --        'haskell',
    --        'help',
    --        'hjson',
    --        'hocon',
    --        'html',
    --        'java',
    --        'javascript',
    --        'jsdoc',
    --        'json',
    --        'kotlin',
    --        'latex',
    --        'lua',
    --        'make',
    --        'markdown',
    --        'nix',
    --        'python',
    --        'rasi',
    --        'regex',
    --        'rust',
    --        'scss',
    --        'svelte',
    --        'toml',
    --        'tsx',
    --        'typescript',
    --        'vue',
    --        'yaml',
    --    },
    sync_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = { 'vim' },
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { 'org' },
    },
}