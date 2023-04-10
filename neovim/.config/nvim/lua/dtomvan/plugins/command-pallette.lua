return {
    {
        'LinArcX/telescope-command-palette.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Telescope command_palette',
        keys = { { '<leader>pc', '<cmd>Telescope command_palette<cr>' } },
        config = function(_, opts)
            require 'command_palette'.CpMenu = opts
            require('telescope').load_extension('command_palette')
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        opts = function(_, opts)
            local f = vim.fn.stdpath 'config' .. '/palette.toml'
            -- TOML because why not
            if not vim.fn.filereadable(f) then
                return {}
            end
            f = assert(io.open(f))
            local ok, res = pcall(require 'toml'.parse, f:read '*a', { strict = false })
            if not ok then
                error('Invalid pallette.toml: ' .. res)
            end
            local palette = {}
            local key_idx = {}
            for k, v in pairs(res) do
                local key
                if not key_idx[k] then
                    key = #palette + 1
                    key_idx[k] = key
                    palette[key] = { k }
                end
                key = key or key_idx[k]
                for l, u in pairs(v) do
                    table.insert(palette[key], { l, u })
                end
            end

            opts.extensions = opts.extensions or {}
            opts.extensions.command_palette = palette
            return opts
        end
    }
}
