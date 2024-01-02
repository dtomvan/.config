local function firenvim_ft(ft)
    return function()
        if vim.g.started_by_firenvim then
            return ft
        end
    end
end

vim.filetype.add {
    extension = {
        jq = 'jq',
        bf = 'brainfuck',
        fen = 'fen',
    },
    pattern = {
        ['web.whatsapp.com_.*.txt'] = firenvim_ft 'messaging',
        ['web.telegram.org.*.txt'] = firenvim_ft 'messaging',
        ['github.com_.*.txt'] = firenvim_ft 'markdown',
        ['reddit.com_.*.txt'] = firenvim_ft 'markdown',
        ['stackexchange.com_.*.txt'] = firenvim_ft 'markdown',
        ['stackoverflow.com_.*.txt'] = firenvim_ft 'markdown',
        ['www.shadertoy.com_.*.txt'] = firenvim_ft 'c',
        ['.*'] = function(_, bufnr)
            local content = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false) or {}
            if content[1] == '# jq script' then
                return 'jq'
            end
        end,
    },
}
