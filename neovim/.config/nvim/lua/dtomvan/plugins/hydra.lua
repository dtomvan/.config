return {
    'anuvyklack/hydra.nvim',
    lazy = true,
    init = function()
        local hydra = require 'dtomvan.config.hydra'
        for _, source in
        ipairs(
            vim.api.nvim_get_runtime_file(
                'lua/dtomvan/config/hydra/*.lua',
                true
            )
        )
        do
            local ok, err = pcall(hydra.setup, loadfile(source)())
            if not ok then
                vim.notify(
                    ('Invalid hydra in file `%s`: %s'):format(
                        vim.fn.fnamemodify(source, ':~:.'),
                        err
                    )
                )
            end
        end
    end,
}
