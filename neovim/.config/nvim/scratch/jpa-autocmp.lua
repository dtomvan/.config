local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
    return
end

local parser_cache = {}

---@param bufnr integer
---@return vim.treesitter.languagetree | nil
local function get_parser(bufnr)
    if not parser_cache[bufnr] then
        parser_cache[bufnr] = vim.treesitter.get_parser(bufnr)
    end
    return parser_cache[bufnr]
end

---@param lang string
---@param query string
local function parse(is_ok, lang, query, ...)
    local new_ok, parsed = pcall(vim.treesitter.parse_query, lang, query, ...)
    return is_ok and new_ok, parsed
end

local parse_ok, entity_q = parse(
    true,
    'kotlin',
    [[
(class_declaration
  (modifiers (annotation (user_type (type_identifier) @_name (#eq? @_name "Entity")) @annotation))
  (type_identifier) @entity
  (class_body (property_declaration (variable_declaration (simple_identifier) @field))*))
]]
)

local parse_ok, query_q = parse(
    parse_ok,
    'kotlin',
    [[
(annotation
  (constructor_invocation
    (user_type
      (type_identifier) @_ident)
    (value_arguments
      (value_argument [
                       ((line_string_literal) @sql (#offset! @sql 1 0 -1 0))
                       ((multi_line_string_literal) @sql (#offset! @sql 3 0 -3 0))
                       ]))))
]]
)

---Get the current query
---@param bufnr integer
---@param cursor lsp.Position | vim.Position
---@return vim.Range | nil
local function get_cur_query(bufnr, cursor)
    if not parser then
        return
    end
    local tree = parser:parse()
    if not tree then
        return
    end
    for id, node, _ in query_q:iter_captures(tree:root(), bufnr, cursor.row, cursor.row) do
        if query_q.captures[id] == 'sql' then
            local row1, col1, row2, col2 = node:range()
            return { start = { row = row1, col = col1 }, ['end'] = { row = row2, col = col2 } }
        end
    end
end

local source = {}

source.new = function()
    return setmetatable({}, { __index = source })
end

source.get_debug_name = function()
    return 'java_persistence'
end

source.is_available = function()
    return cmp_ok and parse_ok
end

---@param self cmp.Source
---@param callback function
---@return boolean Return true if not trigger completion.
source.complete = function(self, request, callback)
    ---@type cmp.Context
    local context = request.context

    local cursor = context.cursor
    local ok, query = pcall(get_cur_query, context.bufnr, cursor)
    if not query or not ok then
        return true
    end
    print(query)

    -- local cursor_line = context.cursor_line
    local cursor_before_line = context.cursor_before_line
    local input = string.sub(cursor_before_line, request.offset - 1)
    local prefix = string.sub(cursor_before_line, 1, request.offset - 1)
    local start_select, end_select = string.find(prefix, 'SELECT ')
    local after_fields = start_select < cursor and end_select <= cursor and start_select

    return true
end

cmp.register_source('jpa', source.new())

local sources = R 'dtomvan.plugins.cmp'
cmp.setup.filetype('kotlin', {
    sources = cmp.config.sources(vim.tbl_deep_extend('force', sources, {
        { name = 'jpa' },
    }, { name = 'buffer' })),
})
