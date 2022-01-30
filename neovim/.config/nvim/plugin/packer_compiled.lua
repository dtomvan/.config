-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/tomvd/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/tomvd/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/tomvd/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/tomvd/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/tomvd/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["auto.pairs"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/auto.pairs",
    url = "https://github.com/Krasjet/auto.pairs"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["feline.nvim"] = {
    config = { "\27LJ\1\2O\0\0\2\0\3\0\f4\0\0\0007\0\1\0007\0\2\0>\0\1\2\19\0\0\0'\1\0\0\0\1\0\0T\0\2€)\0\1\0T\1\1€)\0\2\0H\0\2\0\20buf_get_clients\blsp\bvimŽ\1\0\0\5\0\t\0\0214\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\0024\1\3\0\16\2\0\0>\1\2\2\a\1\4\0T\1\b€4\1\4\0007\1\5\1\16\2\0\0%\3\6\0%\4\a\0>\1\4\3H\1\2\0T\1\2€%\1\b\0H\1\2\0G\0\1\0\6 \5\tðŸ‡»\tgsub\vstring\ttype\vstatus\15lsp-status\frequire¼\3\1\0\5\0\26\1-4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\4\0%\1\5\0>\0\2\0014\0\0\0007\0\4\0%\1\6\0>\0\2\0014\0\0\0007\0\a\0007\0\b\0\b\0\0\0T\0\23€4\0\t\0%\1\n\0>\0\2\0027\0\v\0004\1\f\0007\1\r\0017\2\14\0008\2\2\0023\3\15\0001\4\16\0:\4\17\3>\1\3\0014\1\t\0%\2\18\0>\1\2\0027\1\19\0013\2\20\0:\0\21\0023\3\23\0001\4\22\0:\4\24\3:\3\25\2>\1\2\0014\0\0\0007\0\a\0'\1\1\0:\1\b\0G\0\1\0\21custom_providers\23lsp_current_status\1\0\0\0\15components\1\0\0\nsetup\vfeline\fenabled\0\1\0\1\rprovider\23lsp_current_status\vactive\vinsert\ntable\vnoicon\19feline.presets\frequire\20feline_has_init\6g&hi Normal guibg=NONE ctermbg=NONE\25colorscheme kanagawa\bcmd\tdark\15background\6o\bvim\2\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/feline.nvim",
    url = "https://github.com/feline-nvim/feline.nvim"
  },
  firenvim = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/firenvim",
    url = "https://github.com/glacambre/firenvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["kotlin-vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/kotlin-vim",
    url = "https://github.com/udalov/kotlin-vim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["mapx.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/mapx.nvim",
    url = "https://github.com/b0o/mapx.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nlua.nvim",
    url = "https://github.com/tjdevries/nlua.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\1\2¥\1\0\0\5\0\t\0\0234\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\a\0002\2\3\0004\3\0\0%\4\1\0>\3\2\0027\3\3\0037\3\4\0037\3\5\3;\3\1\0024\3\0\0%\4\1\0>\3\2\0027\3\3\0037\3\4\0037\3\6\3;\3\2\2:\2\b\1>\0\2\1G\0\1\0\fsources\1\0\0\ntaplo\vstylua\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\1\2—\2\0\2\6\0\v\0.4\2\0\0%\3\1\0>\2\2\2\16\3\0\0\16\4\1\0>\2\3\0014\2\2\0007\2\3\0027\2\4\0027\2\5\2\5\1\2\0T\2\6€4\2\2\0007\2\6\0027\2\a\2\16\3\0\0>\2\2\1T\2\27€4\2\2\0007\2\3\0027\2\4\0027\2\b\2\5\1\2\0T\2\v€4\2\2\0007\2\6\0027\2\t\0022\3\3\0003\4\n\0;\0\1\4;\4\1\3)\4\2\0002\5\0\0>\2\4\1T\2\n€4\2\2\0007\2\6\0027\2\t\0022\3\3\0002\4\3\0;\0\1\4;\4\1\3)\4\2\0002\5\0\0>\2\4\1G\0\1\0\1\3\0\0\0\15WarningMsg\14nvim_echo\tWARN\21nvim_err_writeln\bapi\nERROR\vlevels\blog\bvim\vnotify\frequire™\1\1\0\2\0\6\0\n4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\0014\0\4\0001\1\5\0:\1\1\0G\0\1\0\0\bvim\1\0\4\22background_colour\f#000000\vrender\fdefault\ftimeout\3ˆ'\vstages\22fade_in_slide_out\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["presence.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/presence.nvim",
    url = "https://github.com/andweeb/presence.nvim"
  },
  ["quickfix-reflector.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/quickfix-reflector.vim",
    url = "https://github.com/stefandtw/quickfix-reflector.vim"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  ["registers.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/registers.nvim",
    url = "https://github.com/tversteeg/registers.nvim"
  },
  ["ron.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/ron.vim",
    url = "https://github.com/ron-rs/ron.vim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\1\2?\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\1\0029\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-be-good"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-be-good",
    url = "https://github.com/ThePrimeagen/vim-be-good"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-closer",
    url = "https://github.com/rstacruz/vim-closer"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-git"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-git",
    url = "https://github.com/tpope/vim-git"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-transpose-words"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-transpose-words",
    url = "https://github.com/Raimondi/vim-transpose-words"
  },
  ["xplr.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/xplr.nvim",
    url = "https://github.com/fhill2/xplr.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\1\0029\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\1\2?\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: feline.nvim
time([[Config for feline.nvim]], true)
try_loadstring("\27LJ\1\2O\0\0\2\0\3\0\f4\0\0\0007\0\1\0007\0\2\0>\0\1\2\19\0\0\0'\1\0\0\0\1\0\0T\0\2€)\0\1\0T\1\1€)\0\2\0H\0\2\0\20buf_get_clients\blsp\bvimŽ\1\0\0\5\0\t\0\0214\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\0024\1\3\0\16\2\0\0>\1\2\2\a\1\4\0T\1\b€4\1\4\0007\1\5\1\16\2\0\0%\3\6\0%\4\a\0>\1\4\3H\1\2\0T\1\2€%\1\b\0H\1\2\0G\0\1\0\6 \5\tðŸ‡»\tgsub\vstring\ttype\vstatus\15lsp-status\frequire¼\3\1\0\5\0\26\1-4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\4\0%\1\5\0>\0\2\0014\0\0\0007\0\4\0%\1\6\0>\0\2\0014\0\0\0007\0\a\0007\0\b\0\b\0\0\0T\0\23€4\0\t\0%\1\n\0>\0\2\0027\0\v\0004\1\f\0007\1\r\0017\2\14\0008\2\2\0023\3\15\0001\4\16\0:\4\17\3>\1\3\0014\1\t\0%\2\18\0>\1\2\0027\1\19\0013\2\20\0:\0\21\0023\3\23\0001\4\22\0:\4\24\3:\3\25\2>\1\2\0014\0\0\0007\0\a\0'\1\1\0:\1\b\0G\0\1\0\21custom_providers\23lsp_current_status\1\0\0\0\15components\1\0\0\nsetup\vfeline\fenabled\0\1\0\1\rprovider\23lsp_current_status\vactive\vinsert\ntable\vnoicon\19feline.presets\frequire\20feline_has_init\6g&hi Normal guibg=NONE ctermbg=NONE\25colorscheme kanagawa\bcmd\tdark\15background\6o\bvim\2\0", "config", "feline.nvim")
time([[Config for feline.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\1\2¥\1\0\0\5\0\t\0\0234\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\a\0002\2\3\0004\3\0\0%\4\1\0>\3\2\0027\3\3\0037\3\4\0037\3\5\3;\3\1\0024\3\0\0%\4\1\0>\3\2\0027\3\3\0037\3\4\0037\3\6\3;\3\2\2:\2\b\1>\0\2\1G\0\1\0\fsources\1\0\0\ntaplo\vstylua\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\1\2—\2\0\2\6\0\v\0.4\2\0\0%\3\1\0>\2\2\2\16\3\0\0\16\4\1\0>\2\3\0014\2\2\0007\2\3\0027\2\4\0027\2\5\2\5\1\2\0T\2\6€4\2\2\0007\2\6\0027\2\a\2\16\3\0\0>\2\2\1T\2\27€4\2\2\0007\2\3\0027\2\4\0027\2\b\2\5\1\2\0T\2\v€4\2\2\0007\2\6\0027\2\t\0022\3\3\0003\4\n\0;\0\1\4;\4\1\3)\4\2\0002\5\0\0>\2\4\1T\2\n€4\2\2\0007\2\6\0027\2\t\0022\3\3\0002\4\3\0;\0\1\4;\4\1\3)\4\2\0002\5\0\0>\2\4\1G\0\1\0\1\3\0\0\0\15WarningMsg\14nvim_echo\tWARN\21nvim_err_writeln\bapi\nERROR\vlevels\blog\bvim\vnotify\frequire™\1\1\0\2\0\6\0\n4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\0014\0\4\0001\1\5\0:\1\1\0G\0\1\0\0\bvim\1\0\4\22background_colour\f#000000\vrender\fdefault\ftimeout\3ˆ'\vstages\22fade_in_slide_out\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
