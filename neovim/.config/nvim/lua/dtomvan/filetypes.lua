vim.filetype.add {
    extension = {
        jq = 'jq',
    },
    pattern = {
        [".*"] = function(_, bufnr)
            local content = vim.filetype.getlines(bufnr, 1)
            if content[1] == "# jq script" then
                return 'jq'
            end
        end,
    }
}
