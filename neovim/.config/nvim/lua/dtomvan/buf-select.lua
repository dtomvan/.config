--- [[
---     Cheesy dressing.nvim remake
---     By Tom van Dijk
--- ]]
local ok, float = pcall(require, 'plenary.window.float')

local M = {}

---@enum BufSelect.SplitType
M.split_types = {
    VERTICAL = 0,
    HORIZONTAL = 1,
}

---@enum BufSelect.BufType
M.buf_types = {
    SPLIT = 2,
    FLOATING = 3,
}

---@class BufSelect.Config
---@field buf_type BufSelect.BufType
---@field floating nil | BufSelect.FloatConfig
---@field split nil | BufSelect.SplitConfig
M.default_config = {
    buf_type = M.buf_types.FLOATING,
    floating = {
        winblend = 30,
        width = 50,
        height = 30,
    },
    split = {
        type = M.split_types.HORIZONTAL,
        percentage = 10,
    },
}

---@class BufSelect.FloatConfig
---@field winblend integer
---@field width integer percentage
---@field height integer percentage

---@class BufSelect.SplitConfig
---@field type BufSelect.SplitType
---@field percentage integer

---@param bufnr integer
---@param config BufSelect.FloatConfig
local function make_float(bufnr, config)
    local height = config.height / 1000
    local width = config.width / 1000
    float.percentage_range_window(
        height,
        width,
        { bufnr = bufnr, winblend = config.winblend },
        {}
    )
end

---@param bufnr integer
---@param config BufSelect.SplitConfig
local function make_split(bufnr, config)
    local prefix
    local max
    if config.type == M.split_types.VERTICAL then
        prefix = 'vertical '
        max = vim.o.lines
    else
        prefix = ''
        max = vim.o.columns
    end
    vim.cmd(prefix .. 'split')
    vim.cmd(
        prefix
            .. 'resize '
            .. tostring(math.floor(max * (config.percentage / 1000)))
    )
    vim.cmd.buffer(bufnr)
end

M.select = function(items, opts, on_choice)
    local config = _G.BufSelectConfig
    opts = opts or {}

    if type(opts.format_item) ~= 'function' then
        opts.format_item = function(a)
            return a
        end
    end

    local bufnr = vim.api.nvim_create_buf(false, true)
    if config.buf_type == M.buf_types.SPLIT then
        make_split(bufnr, config.split)
    elseif config.buf_type == M.buf_types.FLOATING then
        make_float(bufnr, config.floating)
    else
        vim.notify_once(
            'BufSelect: Invalid config. Expected either buf_types.SPLIT or buf_types.FLOATING.',
            vim.log.levels.ERROR
        )
    end

    for _, item in ipairs(items) do
        local lines = { tostring(opts.format_item(item)) }
        if vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)[1] == '' then
            vim.api.nvim_buf_set_lines(bufnr, 0, 1, true, lines)
        else
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, lines)
        end
    end

    vim.keymap.set('n', '<enter>', function()
        local choice = vim.api.nvim_win_get_cursor(0)
        vim.cmd.bd()
        on_choice(items[choice[1]])
    end, { buffer = bufnr })
end

---@param config BufSelect.Config
---@return nil
M.setup = function(config)
    config = vim.tbl_deep_extend('force', M.default_config, config or {})

    vim.validate {
        buf_type = {
            config.buf_type,
            function(a)
                return a == M.buf_types.FLOATING or a == M.buf_types.SPLIT
            end,
            'buf_select.buf_types',
        },
        floating = {
            config.floating,
            't',
            config.buf_type ~= M.buf_types.FLOATING,
        },
        split = { config.split, 't', config.buf_type ~= M.buf_types.SPLIT },
    }

    if float and not split and not ok then
        vim.notify_once(
            'BufSelect: plenary.nvim not found. Cannot use floating windows.\nPlease install it or use a split config.',
            vim.log.levels.ERROR
        )
        return
    end

    _G.BufSelectConfig = config
    vim.ui.select = M.select
end

return M
