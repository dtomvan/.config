local opts = { remap = false, silent = true }

local function map(a)
    vim.keymap.set({ 'n', 'v', 'x', 's' }, a[1], a[2], opts)
end

map { 'α', 'a' }
map { 'β', 'b' }
map { 'ψ', 'c' }
map { 'δ', 'd' }
map { 'ε', 'e' }
map { 'φ', 'f' }
map { 'γ', 'g' }
map { 'η', 'h' }
map { 'ι', 'i' }
map { 'ξ', 'j' }
map { 'κ', 'k' }
map { 'λ', 'l' }
map { 'μ', 'm' }
map { 'ν', 'n' }
map { 'ο', 'o' }
map { 'π', 'p' }
map { 'ρ', 'r' }
map { 'σ', 's' }
map { 'τ', 't' }
map { 'θ', 'u' }
map { 'ω', 'v' }
map { 'ς', 'w' }
map { 'χ', 'x' }
map { 'υ', 'y' }
map { 'ζ', 'z' }
map { 'ζζ', 'zz' }

map { 'Α', 'A' }
map { 'Β', 'B' }
map { 'Ψ', 'C' }
map { 'Δ', 'D' }
map { 'Ε', 'E' }
map { 'Φ', 'F' }
map { 'Γ', 'G' }
map { 'Η', 'H' }
map { 'Ι', 'I' }
map { 'Ξ', 'J' }
map { 'Κ', 'K' }
map { 'Λ', 'L' }
map { 'Μ', 'M' }
map { 'Ν', 'N' }
map { 'Ο', 'O' }
map { 'Π', 'P' }
map { 'Ρ', 'R' }
map { 'Σ', 'S' }
map { 'Τ', 'T' }
map { 'Θ', 'U' }
map { 'Ω', 'V' }
map { 'Σ', 'W' }
map { 'Χ', 'X' }
map { 'Υ', 'Y' }
map { 'Ζ', 'Z' }
