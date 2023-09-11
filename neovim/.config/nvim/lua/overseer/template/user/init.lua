-- FIXME: This could probably be easier/more efficient
local h = vim.fn.stdpath 'config'
return vim.tbl_map(function(x)
    return 'user.' .. string.gsub(vim.fs.basename(x), '.lua$', '')
end, vim.tbl_filter(function(x)
    return h
        and vim.startswith(x, h or '')
        and (not vim.endswith(x, 'init.lua'))
        or false
end, vim.api.nvim_get_runtime_file('lua/overseer/template/user/*.lua', true)))
