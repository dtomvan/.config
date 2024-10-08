return {
    'saecki/crates.nvim',
    ft = 'toml',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {},
    init = function()
        vim.api.nvim_create_autocmd("BufRead", {
            group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
            pattern = "Cargo.toml",
            callback = function(...) CONF.crates().cb(...) end,
        })
    end,
}
