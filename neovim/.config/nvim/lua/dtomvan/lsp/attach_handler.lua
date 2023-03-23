return function(...)
    if not _G.__dtomvan_attach_handler then
        _G.__dtomvan__attach_handler = require 'dtomvan.lsp.attach'
    end
    return _G.__dtomvan__attach_handler(...)
end
