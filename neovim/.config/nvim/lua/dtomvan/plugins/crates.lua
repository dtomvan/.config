return {
    'saecki/crates.nvim',
    event = "BufRead Cargo.toml",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {},
    init = function()
        vim.api.nvim_create_autocmd("BufRead", {
            group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
            pattern = "Cargo.toml",
            callback = CONF.crates().cb,
        })
    end,
}
