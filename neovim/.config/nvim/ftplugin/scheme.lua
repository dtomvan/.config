local modname = 'nvim_treesitter_playground_query_omnifunc'
local ok, mod = pcall(require, modname)
if ok and type(mod.omnifunc) == 'function' then
    vim.bo.ofu = string.format("v:lua.require'%s'.omnifunc", modname)
end
