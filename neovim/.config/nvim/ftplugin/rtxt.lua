-- The reliable txt format.

local encoding = {
    UTF_8 = "utf-8",
    UTF_16 = "utf-16-be",
    UTF_16_REVERSE = "utf-16-le",
    UTF_32 = "utf-32-be",
}

local function getencoding(bytes)
    if #bytes >= 3 and bytes[1] == 0xEF and bytes[2] == 0xBB and bytes[3] == 0xBF then
        return encoding.UTF_8
    elseif #bytes >= 2 and bytes[1] == 0xFE and bytes[2] == 0xFF then
        return encoding.UTF_16
    elseif #bytes >= 2 and bytes[1] == 0xFF and bytes[2] == 0xFE then
        return encoding.UTF_16_REVERSE
    elseif #bytes >= 4 and bytes[1] == 0 and bytes[2] == 0 and bytes[3] == 0xFE and bytes[4] == 0xFF then
        return encoding.UTF_32
    end
end

local function decode(bytes)
end

local function to_string(bytes)
    local output = ""
    for _, b in ipairs(bytes) do
        output = output .. string.char(b - 100)
    end
    return output
end

local function read(file)
    local text = io.open(file, "rb"):read "*a"
    local bytes = { string.byte(text, 1, -1) }
    vim.print(getencoding(bytes) or "NIL")
    local contents = { unpack(text, 2) }
    vim.print(contents)
end

read(vim.fn.expand "%:p")
