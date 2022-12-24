local null_ls = require 'null-ls'

local M = {}

M.method = null_ls.methods.COMPLETION
M.file_types = { 'tsv', 'markdown', 'text' }
M.generator = {
    async = true,
    fn = function(params, done)
        local split = vim.split(string.sub(params.content[params.row], 0, params.col + 1), '%s')
        local word_before_cursor = split[#split]
        if
            vim.api.nvim_buf_call(params.bufnr, function()
                return #vim.spell.check(word_before_cursor) == 0
            end) or #word_before_cursor < 4
        then
            return done { { items = {}, isIncomplete = true } }
        end
        local jobs = 0
        local dym = {}

        local function dym_lang(lang)
            jobs = jobs + 1
            vim.fn.jobstart({ 'dym', '-l', lang, '-n', '10', '-v', '-c', word_before_cursor }, {
                on_stdout = function(_, data, _)
                    if data then
                        for _, word in ipairs(data) do
                            if #string.gsub(word, '%s', '') < 1 then
                                goto continue
                            end
                            local part = vim.split(word, ' ')[1]
                            table.insert(dym, {
                                detail = 'dym',
                                label = part,
                                documentation = string.format('DidYouMean?\n%s', word),
                            })
                            ::continue::
                        end
                    end
                end,
                on_exit = function(_, _)
                    jobs = jobs - 1
                    if jobs == 0 then
                        done { { items = dym, isIncomplete = true } }
                    end
                end,
            })
        end

        dym_lang 'en'
        dym_lang 'nl'
    end,
}

null_ls.register {
    name = 'dym',
    filetypes = M.file_types,
    sources = { M },
}

return M
