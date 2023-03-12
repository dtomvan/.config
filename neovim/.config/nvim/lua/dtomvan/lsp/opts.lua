local on_attach = require 'dtomvan.lsp.attach'
local lsp_status = require 'lsp-status'
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
    cmp_nvim_lsp = {}
    cmp_nvim_lsp.default_capabilities = function(input)
        return input
    end
end

local capabilities = vim.tbl_extend(
    'keep',
    cmp_nvim_lsp.default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    ),
    lsp_status.capabilities
)

return {
    on_attach = on_attach,
    capabilities = capabilities,
}
