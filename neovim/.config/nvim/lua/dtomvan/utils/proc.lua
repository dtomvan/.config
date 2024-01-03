local fs = vim.fs
local j = fs.joinpath
local uv = vim.uv

local M = {}

---@param pid integer
---@return string
M.procpath = function(pid)
    return ('/proc/%d/'):format(pid)
end

M.readlinkfield = function(field, default)
    ---@param res dtomvan.ProcessInit
    ---@return string
    return function(res)
        return uv.fs_readlink(j(res.path, field)) or default
    end
end

---@param sep string
---@param plain boolean
---@return function(res: dtomvan.ProcessInit, field: string): string[]
M.separray = function(sep, plain)
    return function(res, field)
        local ok, f = pcall(io.open, j(res.path, field))
        if not ok or not f then error(('no access to field %s on PID %d'):format(field, res.pid)) end
        return vim.split(
            f:read('*a'),
            sep,
            { plain = plain, trimempty = true }
        )
    end
end

M.zeroseparray = M.separray('\0', true)
M.wsseparray = M.separray('%s', false)

---@alias dtomvan.ProcessInit { pid:integer, path: string }
---@class dtomvan.Process
---@field cmdline string[] commandline parameters
---@field cwd string $CWD for ex. in bash
---@field environ table<string,string>? envvars
---@field exe string path to the executable of the process
---@field path string path to /proc/pid
---@field pid integer the actual PID
---@field ppid integer? parent PID
M.Process = {}

---creates a new process by pid
---@param pid integer
---@return dtomvan.Process?
function M.Process:new(pid)
    local p = tonumber(pid)
    if not p then return end
    ---@cast p integer
    pid = p
    local res = {}
    res.pid = pid
    res.path = M.procpath(pid)

    for _, field in ipairs { 'cwd', 'exe' } do
        res[field] = M.readlinkfield(field)(res)
    end
    res.cmdline = M.zeroseparray(res, 'cmdline')
    local ok, environ = pcall(M.zeroseparray, res, 'environ')
    if ok then
        res.environ = {}
        for _, kv in ipairs(environ) do
            local firsteq = string.find(kv, '=')
            res.environ[string.sub(kv, 1, firsteq - 1)] = string.sub(kv, firsteq + 1)
        end
    end
    if pid > 1 then
        local stat = M.wsseparray(res, 'stat')
        -- FIXME: Properly handle parsing this as fourth field, not len-48'th
        res.ppid = stat[#stat - 48] or 0
    end

    ---@cast res dtomvan.Process
    setmetatable(res, self)
    self.__index = self
    return res
end

function M.Process:resolved_cmdline()
    local res = vim.list_slice(self.cmdline)
    res[1] = self.exe
    return res
end

---returns parent process if applicable
---@return dtomvan.Process?
function M.Process:parent()
    if self.pid == 1 then return end
    return M.Process:new(self.ppid)
end

function M.Process:parents()
    ---@type dtomvan.Process?
    local current = self
    return function()
        if not current then return end
        current = current:parent()
        return current
    end
end

M.pidof = function(proc)
end

return M
