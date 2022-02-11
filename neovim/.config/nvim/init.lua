--     _   ____________ _    ________  ___
--    / | / / ____/ __ \ |  / /  _/  |/  /
--   /  |/ / __/ / / / / | / // // /|_/ /
--  / /|  / /___/ /_/ /| |/ // // /  / /
-- /_/ |_/_____/\____/ |___/___/_/  /_/

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
    execute 'packadd packer.nvim'
end

package.loaded.globals = nil
require 'globals'
R 'plugins'
R 'config-xplr'
vim.cmd [[source ~/.config/nvim/autoload/vimscriptstuff.vim]]
R 'opts'
R 'lsp'
vim.cmd [[ au! VimEnter *.rs ]]
R 'keymaps'
R('gitsigns').setup {}
R('telescope').setup {}
require('telescope').setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}
require('telescope').load_extension 'fzy_native'

-- Joke snips
local ls = require 'luasnip'
ls.snippets = {
    all = {
        ls.parser.parse_snippet("IUSEARCHBTW",
        [[One time I was ordering coffee and suddenly realised the barista didn't
know I use Arch. Needless to say, I stopped mid-order to inform her that
I do indeed use Arch. I must have spoken louder than I intended because
the whole café instantly erupted into a prolonged applause. I walked
outside with my head held high. I never did finish my order that day,
but just knowing that everyone around me was aware that I use Arch was
more energising than a simple cup of coffee could ever be.]]),

        ls.parser.parse_snippet("LINUX",
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
really distributions of GNU/Linux.]])
    }
}
