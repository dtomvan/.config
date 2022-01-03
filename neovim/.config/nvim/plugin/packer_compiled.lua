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
  local success, result = pcall(loadstring(s))
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
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["auto.pairs"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/auto.pairs"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["feline.nvim"] = {
    config = { "\27LJ\1\2î\1\0\0\2\0\14\0\0234\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\4\0%\1\6\0:\1\5\0004\0\0\0007\0\4\0'\1\0\0:\1\a\0004\0\0\0007\0\b\0%\1\t\0>\0\2\0014\0\n\0%\1\v\0>\0\2\0027\0\f\0003\1\r\0>\0\2\1G\0\1\0\1\0\1\vpreset\vnoicon\nsetup\vfeline\frequire\25colorscheme kanagawa\bcmd\29gruvbox_invert_selection\thard\26gruvbox_contrast_dark\6g\tdark\15background\6o\bvim\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/feline.nvim"
  },
  firenvim = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  harpoon = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/harpoon"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/kanagawa.nvim"
  },
  ["kotlin-vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/kotlin-vim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lightspeed.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nui.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["presence.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/presence.nvim"
  },
  ["quickfix-reflector.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/quickfix-reflector.vim"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/refactoring.nvim"
  },
  ["registers.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/registers.nvim"
  },
  ["ron.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/ron.vim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-closer"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-git"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-git"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  ["vim-transpose-words"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-transpose-words"
  },
  ["xplr.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/xplr.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: feline.nvim
time([[Config for feline.nvim]], true)
try_loadstring("\27LJ\1\2î\1\0\0\2\0\14\0\0234\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\4\0%\1\6\0:\1\5\0004\0\0\0007\0\4\0'\1\0\0:\1\a\0004\0\0\0007\0\b\0%\1\t\0>\0\2\0014\0\n\0%\1\v\0>\0\2\0027\0\f\0003\1\r\0>\0\2\1G\0\1\0\1\0\1\vpreset\vnoicon\nsetup\vfeline\frequire\25colorscheme kanagawa\bcmd\29gruvbox_invert_selection\thard\26gruvbox_contrast_dark\6g\tdark\15background\6o\bvim\0", "config", "feline.nvim")
time([[Config for feline.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
