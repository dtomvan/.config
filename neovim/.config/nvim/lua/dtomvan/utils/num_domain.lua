local func = require 'dtomvan.utils.func'

local M = {}

function M.nonzero(x) return x ~= 0 end

function M.whole(x) return math.floor(x) == x end

function M.notbelowzero(x) return not (x < 0) end

M.unsigned = M.notbelowzero
M.abovezero = func.andd(M.nonzero, M.notbelowzero)
M.natural = func.andd(M.whole, M.abovezero)
M.zeroindexed = func.andd(M.whole, M.notbelowzero)

return M
