local silent_cmd = xplr.fn.custom.command_mode.silent_cmd
local home = os.getenv 'HOME'

-- local cmd = xplr.fn.custom.command_mode.cmd
-- local map = xplr.fn.custom.command_mode.map
silent_cmd('pwd', 'Current PWD')(function(app)
    return {
        { LogSuccess = app.pwd },
    }
end)

-- Lua ahead
local dirs = {
    { '.config', 'c' },
    { 'DotFiles', 'conf' },
    { '.local', 'local' },
    { '.config/nvim', 'nv' },
    { '.config/xplr', 'xplr' },
    { '.config/zellij', 'zellij' },
    { '.config/awesome', 'wm' },
    { '.config/fish', 'fish' },
    { '', 'cd' },
    { '', 'h' },
}
for _, x in ipairs(dirs) do
    silent_cmd(x[2], 'Go to ' .. x[1] .. ' .')(function(_)
        return {
            { ChangeDirectory = home .. '/' .. x[1] .. '/' },
        }
    end)
end

silent_cmd('e', 'Edit $PWD')(function(_)
    return {
        {
            BashExec = [==[
            ${EDITOR:-vi} $PWD
            ]==],
        },
    }
end)
