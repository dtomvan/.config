local function run() end

local function setup(ev)
    local bufnr = ev.buf
    vim.keymap.set('v', '<leader>mte', function()
        local fst = vim.fn.line 'v'
        local snd = vim.fn.line '.'
        if fst > snd then
            local temp = snd
            snd = fst
            fst = temp
        end

        local scratch_buf = vim.api.nvim_create_buf(false, true)
        local wid = vim.api.nvim_open_win(
            scratch_buf,
            true,
            { relative = 'editor', width = vim.o.columns, height = vim.o.lines, row = 0, col = 0 }
        )
        local selected_lines = vim.api.nvim_buf_get_lines(bufnr, fst - 1, snd, false)
        vim.api.nvim_buf_set_lines(bufnr, fst - 1, snd, false, {})
        local jobid = vim.fn.termopen('vd -f markdown', {
            stdout_buffered = true,
            on_stdout = function(data)
                if not data then
                    return
                end
                vim.api.nvim_buf_set_lines(bufnr, fst - 1, fst - 1, false, data)
            end,
        })
        vim.fn.chansend(jobid, selected_lines)
    end, { buffer = bufnr })
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    group = vim.api.nvim_create_augroup('VisiDataMarkdown', { clear = true }),
    callback = setup,
})
