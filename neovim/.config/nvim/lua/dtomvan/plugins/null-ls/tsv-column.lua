local null_ls = require 'null-ls'
local helpers = require 'null-ls.helpers'

local M = {}

M.method = null_ls.methods.FORMATTING
M.file_types = { 'tsv' }
M.generator = helpers.generator_factory {
    command = 'column',
    args = {
        '-t',
        '-s',
        '\t',
        '-o',
        '\t',
    },
    on_output = function(params, done)
        return done {
            {
                text = params.output,
            },
        }
    end,
    format = nil,
    to_stdin = true,
    use_cache = true,
    timeout = 500,
    ignore_stderr = false,
}

null_ls.register {
    name = 'tsv-column',
    filetypes = { 'tsv' },
    sources = { M },
}

return M
