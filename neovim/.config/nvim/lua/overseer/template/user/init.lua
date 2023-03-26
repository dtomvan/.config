local h = vim.fn.stdpath 'config'
return vim.tbl_filter(function(x)
    return h
            and vim.startswith(x, h or '')
            and (not vim.endswith(x, 'init.lua'))
        or false
end, vim.api.nvim_get_runtime_file('lua/overseer/templates/user/*.lua', true))
