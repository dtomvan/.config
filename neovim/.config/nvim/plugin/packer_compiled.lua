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
  ["coq.artifacts"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/coq.artifacts"
  },
  coq_nvim = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/coq_nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
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
  ["lualine.nvim"] = {
    config = { "\27LJ\1\2z\0\0\3\0\b\0\0144\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\0014\0\0\0%\1\3\0>\0\2\0027\0\4\0003\1\6\0003\2\5\0:\2\a\1>\0\2\1G\0\1\0\foptions\1\0\0\1\0\1\ntheme\rnightfox\nsetup\flualine\tload\rnightfox\6R\0" },
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["mom.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/mom.vim"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nightfox.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nui.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
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
  ["startuptime.vim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-easymotion"
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
  ["vim-tabpagecd"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-tabpagecd"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  vimwiki = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/vimwiki"
  },
  ["xplr.nvim"] = {
    loaded = true,
    path = "/home/tomvd/.local/share/nvim/site/pack/packer/start/xplr.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\1\2z\0\0\3\0\b\0\0144\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\0014\0\0\0%\1\3\0>\0\2\0027\0\4\0003\1\6\0003\2\5\0:\2\a\1>\0\2\1G\0\1\0\foptions\1\0\0\1\0\1\ntheme\rnightfox\nsetup\flualine\tload\rnightfox\6R\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
