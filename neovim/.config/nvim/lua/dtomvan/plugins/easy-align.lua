return {
    'junegunn/vim-easy-align',
    keys = {
        { 'ga', '<plug>(EasyAlign)', mode = { 'n', 'x' }, remap = true },
        {
            'gA',
            '<plug>(LiveEasyAlign)',
            mode = { 'n', 'x' },
            remap = true,
        },
    },
}
