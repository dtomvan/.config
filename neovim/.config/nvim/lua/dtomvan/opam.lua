local tables = require 'dtomvan.utils.tables'

local opam_share_dir = vim.trim(
    vim.system(
        { 'opam', 'var', 'share' },
        { text = true, timeout = 500 }
    ):wait().stdout
)

local opam_packages = {
    'merlin',
    'ocp-indent',
    'ocp-index',
}

local opam_command = {
    "opam", "list", "--installed", "--short", "--safe", "--color=never"
}
for _, i in ipairs(opam_packages) do
    opam_command[#opam_command + 1] = i
end

local opam_configuration = setmetatable(opam_packages, {
    __index = function(_, k)
        return function()
            vim.schedule_wrap(function()
                vim.opt.rtp:prepend(("%s/%s/vim"):format(opam_share_dir, k))
            end)
        end
    end
})

local function exec_config(out)
    local opam_available_tools = vim.split(out.stdout, "\n")
    for _, tool in ipairs(opam_packages) do
        if #tables.filter_eq(opam_available_tools, tool) > 0 then
            opam_configuration[tool]()
        end
    end

    if #tables.filter_eq(opam_available_tools, "ocp-indent") == 0 then
        vim.schedule(function()
            vim.fn.source "/home/tomvd/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
        end)
    end
end

vim.system(opam_command, { text = true }, exec_config)
