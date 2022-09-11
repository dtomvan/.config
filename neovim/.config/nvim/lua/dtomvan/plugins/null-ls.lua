local ok, null_ls = pcall(require, 'null-ls')
if not ok then
    return
end

local formatting = null_ls.builtins.formatting

null_ls.setup {
    sources = {
        formatting.stylua,
        formatting.taplo,
        formatting.black,
    },
    on_attach = R('dtomvan.lsp.attach'),
}

for _, source in ipairs(vim.api.nvim_get_runtime_file('lua/dtomvan/plugins/null-ls/*.lua', true)) do
    loadfile(source)()
end
