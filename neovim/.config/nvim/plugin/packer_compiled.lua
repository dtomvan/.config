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
local package_path_str = "/home/tomvd/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/tomvd/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/tomvd/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/tomvd/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/tomvd/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
    config = { "\27LJ\2\nO\0\0\2\0\3\0\f6\0\0\0009\0\1\0009\0\2\0B\0\1\2\21\0\0\0)\1\0\0\0\1\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\20buf_get_clients\blsp\bvimŽ\1\0\0\6\0\t\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0026\1\3\0\18\3\0\0B\1\2\2\a\1\4\0X\1\b€6\1\4\0009\1\5\1\18\3\0\0'\4\6\0'\5\a\0B\1\4\3L\1\2\0X\1\2€'\1\b\0L\1\2\0K\0\1\0\6 \5\tðŸ‡»\tgsub\vstring\ttype\vstatus\15lsp-status\frequire¼\3\1\0\6\0\26\1-6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0'\2\5\0B\0\2\0016\0\0\0009\0\4\0'\2\6\0B\0\2\0016\0\0\0009\0\a\0009\0\b\0\b\0\0\0X\0\23€6\0\t\0'\2\n\0B\0\2\0029\0\v\0006\1\f\0009\1\r\0019\3\14\0:\3\2\0035\4\15\0003\5\16\0=\5\17\4B\1\3\0016\1\t\0'\3\18\0B\1\2\0029\1\19\0015\3\20\0=\0\21\0035\4\23\0003\5\22\0=\5\24\4=\4\25\3B\1\2\0016\0\0\0009\0\a\0)\1\1\0=\1\b\0K\0\1\0\21custom_providers\23lsp_current_status\1\0\0\0\15components\1\0\0\nsetup\vfeline\fenabled\0\1\0\1\rprovider\23lsp_current_status\vactive\vinsert\ntable\vnoicon\19feline.presets\frequire\20feline_has_init\6g&hi Normal guibg=NONE ctermbg=NONE\25colorscheme kanagawa\bcmd\tdark\15background\6o\bvim\2\0" },
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
  ["is-prime-online.nvim"] = {
    config = { "\27LJ\2\n‚\2\0\0\4\0\t\1%6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\2\v\0\2\0X\1\14€6\1\3\0009\1\4\0019\1\5\1\b\1\0\0X\1\t€6\1\3\0009\1\6\1'\3\a\0B\1\2\0016\1\3\0009\1\4\1)\2\1\0=\2\5\1X\1\15€\v\0\1\0X\1\r€6\1\3\0009\1\4\0019\1\5\1\t\1\0\0X\1\b€6\1\3\0009\1\6\1'\3\b\0B\1\2\0016\1\3\0009\1\4\1)\2\0\0=\2\5\1K\0\1\0\27ðŸ”´ Prime is offline.\26ðŸŸ¢ Prime is online!\vnotify\17PRIME_STATUS\6g\bvim\vstatus\20is-prime-online\frequire\2ç\1\1\0\t\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0B\0\1\2\18\3\0\0009\1\a\0)\4è\3)\5 N6\6\4\0009\6\b\0063\b\t\0B\6\2\0A\1\3\1K\0\1\0\0\18schedule_wrap\nstart\14new_timer\tloop\bvim\1\0\3 refresh_interval_in_seconds\3<\vsource\vtwitch\18streamer_name\17ThePrimeagen\nsetup\20is-prime-online\frequire\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/is-prime-online.nvim",
    url = "https://github.com/samodostal/is-prime-online.nvim"
  },
  ["jvim.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/jvim.nvim",
    url = "https://github.com/theprimeagen/jvim.nvim"
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
    config = { "\27LJ\2\nÇ\1\0\0\a\0\n\0\0306\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0004\3\4\0006\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\5\4>\4\1\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\6\4>\4\2\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\a\4>\4\3\3=\3\t\2B\0\2\1K\0\1\0\fsources\1\0\0\nblack\ntaplo\vstylua\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0" },
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
    config = { "\27LJ\2\n—\2\0\2\a\0\v\0.6\2\0\0'\4\1\0B\2\2\2\18\4\0\0\18\5\1\0B\2\3\0016\2\2\0009\2\3\0029\2\4\0029\2\5\2\5\1\2\0X\2\6€6\2\2\0009\2\6\0029\2\a\2\18\4\0\0B\2\2\1X\2\27€6\2\2\0009\2\3\0029\2\4\0029\2\b\2\5\1\2\0X\2\v€6\2\2\0009\2\6\0029\2\t\0024\4\3\0005\5\n\0>\0\1\5>\5\1\4+\5\2\0004\6\0\0B\2\4\1X\2\n€6\2\2\0009\2\6\0029\2\t\0024\4\3\0004\5\3\0>\0\1\5>\5\1\4+\5\2\0004\6\0\0B\2\4\1K\0\1\0\1\3\0\0\0\15WarningMsg\14nvim_echo\tWARN\21nvim_err_writeln\bapi\nERROR\vlevels\blog\bvim\vnotify\frequire™\1\1\0\3\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0003\1\5\0=\1\1\0K\0\1\0\0\bvim\1\0\4\vrender\fdefault\ftimeout\3ˆ'\22background_colour\f#000000\vstages\22fade_in_slide_out\nsetup\vnotify\frequire\0" },
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
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
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
  ["vim-startuptime"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
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
  },
  ["yuck.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/yuck.vim",
    url = "https://github.com/elkowar/yuck.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: is-prime-online.nvim
time([[Config for is-prime-online.nvim]], true)
try_loadstring("\27LJ\2\n‚\2\0\0\4\0\t\1%6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\2\v\0\2\0X\1\14€6\1\3\0009\1\4\0019\1\5\1\b\1\0\0X\1\t€6\1\3\0009\1\6\1'\3\a\0B\1\2\0016\1\3\0009\1\4\1)\2\1\0=\2\5\1X\1\15€\v\0\1\0X\1\r€6\1\3\0009\1\4\0019\1\5\1\t\1\0\0X\1\b€6\1\3\0009\1\6\1'\3\b\0B\1\2\0016\1\3\0009\1\4\1)\2\0\0=\2\5\1K\0\1\0\27ðŸ”´ Prime is offline.\26ðŸŸ¢ Prime is online!\vnotify\17PRIME_STATUS\6g\bvim\vstatus\20is-prime-online\frequire\2ç\1\1\0\t\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0B\0\1\2\18\3\0\0009\1\a\0)\4è\3)\5 N6\6\4\0009\6\b\0063\b\t\0B\6\2\0A\1\3\1K\0\1\0\0\18schedule_wrap\nstart\14new_timer\tloop\bvim\1\0\3 refresh_interval_in_seconds\3<\vsource\vtwitch\18streamer_name\17ThePrimeagen\nsetup\20is-prime-online\frequire\0", "config", "is-prime-online.nvim")
time([[Config for is-prime-online.nvim]], false)
-- Config for: feline.nvim
time([[Config for feline.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\2\0\3\0\f6\0\0\0009\0\1\0009\0\2\0B\0\1\2\21\0\0\0)\1\0\0\0\1\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\20buf_get_clients\blsp\bvimŽ\1\0\0\6\0\t\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0026\1\3\0\18\3\0\0B\1\2\2\a\1\4\0X\1\b€6\1\4\0009\1\5\1\18\3\0\0'\4\6\0'\5\a\0B\1\4\3L\1\2\0X\1\2€'\1\b\0L\1\2\0K\0\1\0\6 \5\tðŸ‡»\tgsub\vstring\ttype\vstatus\15lsp-status\frequire¼\3\1\0\6\0\26\1-6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0'\2\5\0B\0\2\0016\0\0\0009\0\4\0'\2\6\0B\0\2\0016\0\0\0009\0\a\0009\0\b\0\b\0\0\0X\0\23€6\0\t\0'\2\n\0B\0\2\0029\0\v\0006\1\f\0009\1\r\0019\3\14\0:\3\2\0035\4\15\0003\5\16\0=\5\17\4B\1\3\0016\1\t\0'\3\18\0B\1\2\0029\1\19\0015\3\20\0=\0\21\0035\4\23\0003\5\22\0=\5\24\4=\4\25\3B\1\2\0016\0\0\0009\0\a\0)\1\1\0=\1\b\0K\0\1\0\21custom_providers\23lsp_current_status\1\0\0\0\15components\1\0\0\nsetup\vfeline\fenabled\0\1\0\1\rprovider\23lsp_current_status\vactive\vinsert\ntable\vnoicon\19feline.presets\frequire\20feline_has_init\6g&hi Normal guibg=NONE ctermbg=NONE\25colorscheme kanagawa\bcmd\tdark\15background\6o\bvim\2\0", "config", "feline.nvim")
time([[Config for feline.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nÇ\1\0\0\a\0\n\0\0306\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0004\3\4\0006\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\5\4>\4\1\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\6\4>\4\2\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\a\4>\4\3\3=\3\t\2B\0\2\1K\0\1\0\fsources\1\0\0\nblack\ntaplo\vstylua\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\n—\2\0\2\a\0\v\0.6\2\0\0'\4\1\0B\2\2\2\18\4\0\0\18\5\1\0B\2\3\0016\2\2\0009\2\3\0029\2\4\0029\2\5\2\5\1\2\0X\2\6€6\2\2\0009\2\6\0029\2\a\2\18\4\0\0B\2\2\1X\2\27€6\2\2\0009\2\3\0029\2\4\0029\2\b\2\5\1\2\0X\2\v€6\2\2\0009\2\6\0029\2\t\0024\4\3\0005\5\n\0>\0\1\5>\5\1\4+\5\2\0004\6\0\0B\2\4\1X\2\n€6\2\2\0009\2\6\0029\2\t\0024\4\3\0004\5\3\0>\0\1\5>\5\1\4+\5\2\0004\6\0\0B\2\4\1K\0\1\0\1\3\0\0\0\15WarningMsg\14nvim_echo\tWARN\21nvim_err_writeln\bapi\nERROR\vlevels\blog\bvim\vnotify\frequire™\1\1\0\3\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0003\1\5\0=\1\1\0K\0\1\0\0\bvim\1\0\4\vrender\fdefault\ftimeout\3ˆ'\22background_colour\f#000000\vstages\22fade_in_slide_out\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
