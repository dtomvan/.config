local on_attach = require 'dtomvan.lsp.attach_handler'
local ok_stat, lsp_status = pcall(require, 'lsp-status')
local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok_cmp then
    cmp_nvim_lsp = {}
    cmp_nvim_lsp.default_capabilities = function(input)
        return input
    end
end
if not ok_stat then
    lsp_status = {}
    lsp_status.capabilities = {}
end

local capabilities = vim.tbl_extend(
    'keep',
    cmp_nvim_lsp.default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    ),
    lsp_status.capabilities
)

capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

return {
    on_attach = on_attach,
    capabilities = capabilities,
}
