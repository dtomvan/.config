local ls = require 'luasnip'

vim.o.runtimepath = vim.o.runtimepath
    .. ','
    .. os.getenv 'HOME'
    .. '/.local/share/nvim/site/pack/packer/start/friendly-snippets/'
require('luasnip/loaders/from_vscode').load()

-- THANKS TJ
vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
]]

-- vim.keymap.set('i', '<c-k>', function()
--     if ls.expand_or_jumpable then
--         return '<Plug>luasnip-expand-or-jump'
--     else
--         return '<c-k>'
--     end
-- end, require('keymaps').expr)

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    require('luasnip').jump(-1)
end, require('keymaps').silent)

vim.keymap.set('s', '<c-k>', function()
    require('luasnip').jump(1)
end, require('keymaps').silent)

ls.snippets = {
    lua = {
        ls.parser.parse_snippet('mf', [[function $1.$2($3)
    $4
end]]),
    },
    -- Jokes
    all = {
        ls.parser.parse_snippet(
            'IUSEARCHBTW',
            [[One time I was ordering coffee and suddenly realised the barista didn't
know I use Arch. Needless to say, I stopped mid-order to inform her that
I do indeed use Arch. I must have spoken louder than I intended because
the whole café instantly erupted into a prolonged applause. I walked
outside with my head held high. I never did finish my order that day,
but just knowing that everyone around me was aware that I use Arch was
more energising than a simple cup of coffee could ever be.]]
        ),

        ls.parser.parse_snippet(
            'LINUX',
            [[I'd just like to interject for a moment. What you're referring to as
Linux, is in fact, GNU/Linux, or as I've recently taken to calling it,
GNU plus Linux. Linux is not an operating system unto itself, but rather
another free component of a fully functioning GNU system made useful by
the GNU corelibs, shell utilities and vital system components comprising
a full OS as defined by POSIX.

Many computer users run a modified version of the GNU system every day, without
realizing it. Through a peculiar turn of events, the version of GNU which is
widely used today is often called "Linux", and many of its users are not aware
that it is basically the GNU system, developed by the GNU Project.

There really is a Linux, and these people are using it, but it is just a part of
the system they use. Linux is the kernel: the program in the system that
allocates the machine's resources to the other programs that you run. The kernel
is an essential part of an operating system, but useless by itself; it can only
function in the context of a complete operating system. Linux is normally used
in combination with the GNU operating system: the whole system is basically GNU
with Linux added, or GNU/Linux. All the so-called "Linux" distributions are
really distributions of GNU/Linux.]]
        ),
    },
}
