local stdin = assert(io.open("/dev/stdin", "r"), "stdin must be a pipe")

for line in stdin:lines() do
    print(vim.fn.fnamemodify(line, ":~:.:s?/$??"))
end

