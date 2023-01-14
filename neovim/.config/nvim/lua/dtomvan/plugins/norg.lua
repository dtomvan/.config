return {
    'nvim-neorg/neorg',
    enabled = false,
    build = ':Neorg sync-parsers',
    opts = {
        load = {
            ['core.defaults'] = {},
            ['core.norg.dirman'] = {
                config = {
                    workspaces = {
                        work = '~/norg/school',
                        home = '~/norg/code',
                    },
                },
            },
            ['core.norg.concealer'] = {},
            ['core.norg.completion'] = {
                config = {
                    engine = 'nvim-cmp',
                },
            },
            ['core.integrations.nvim-cmp'] = {
                config = {},
            },
        },
    },
}
