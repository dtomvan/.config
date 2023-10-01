-- FIXME: This could probably be easier/more efficient
return vim.iter(vim.loader.find(
    'overseer.template.user.*',
    { all = true, patterns = { '.lua' }, }
)):map(function(v)
    return string.gsub(x, '^overseer.template.', '')
end)
