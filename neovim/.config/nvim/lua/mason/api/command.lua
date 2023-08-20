-- Overrides the default `mason.api.command` in order to optimize startup time.
local M = {}

M.Mason = function()
    require("mason.ui").open()
end

---@param handles InstallHandle[]
local function join_handles(handles)
    local a = require "mason-core.async"
    local Optional = require "mason-core.optional"

    vim.tbl_map(
    ---@param handle InstallHandle
        function(handle)
            handle:on("stdout", vim.schedule_wrap(vim.api.nvim_out_write))
            handle:on("stderr", vim.schedule_wrap(vim.api.nvim_err_write))
        end,
        handles
    )

    a.run_blocking(function()
        a.wait_all(vim.tbl_map(
        ---@param handle InstallHandle
            function(handle)
                return function()
                    a.wait(function(resolve)
                        if handle:is_closed() then
                            resolve()
                        else
                            handle:once("closed", resolve)
                        end
                    end)
                end
            end,
            handles
        ))
        local failed_packages = vim.iter(handles):map(function(handle)
                if not handle.package:is_installed() then
                    return Optional.of(handle.package.name)
                else
                    return Optional.empty()
                end
            end):filter(function(o) return o:is_present() end)
            :map(function(o) return o:get() end)
            :totable()

        if #failed_packages > 0 then
            a.wait(vim.schedule) -- wait for scheduler for logs to finalize
            a.wait(vim.schedule) -- logs have been written
            vim.api.nvim_err_writeln ""
            vim.api.nvim_err_writeln(
                ("The following packages failed to install: %s"):format(failed_packages:concat(', '))
            )
            vim.cmd [[1cq]]
        end
    end)
end

---@param valid_packages string[]
---@param opts? PackageInstallOpts
M.MasonInstall = function(valid_packages, opts)
    opts = opts or {}
    local Package = require "mason-core.package"
    local registry = require "mason-registry"

    local function install_packages(pkgs)
        return vim.tbl_map(function(pkg_specifier)
            local package_name, version = Package.Parse(pkg_specifier)
            local pkg = registry.get_package(package_name)
            return pkg:install {
                version = version,
                debug = opts.debug,
                force = opts.force,
                strict = opts.strict,
                target = opts.target,
            }
        end, pkgs)
    end

    if require 'mason-core.platform'.is_headless then
        registry.refresh()
        join_handles(install_packages(valid_packages))
    else
        local ui = require "mason.ui"
        ui.open()
        -- Important: We start installation of packages _after_ opening the UI. This gives the UI components a chance to
        -- register the necessary event handlers in time, avoiding desynced state.
        registry.refresh(function()
            install_packages(valid_packages)
            vim.schedule(function()
                ui.set_sticky_cursor "installing-section"
            end)
        end)
    end
end

---@param package_names string[]
M.MasonUninstall = function(package_names)
    local registry = require "mason-registry"
    if #package_names > 0 then
        vim.tbl_map(function(package_name)
            local pkg = registry.get_package(package_name)
            pkg:uninstall()
        end, package_names)
        require("mason.ui").open()
    end
end

M.MasonUninstallAll = function()
    local registry = require "mason-registry"
    require("mason.ui").open()
    for _, pkg in ipairs(registry.get_installed_packages()) do
        pkg:uninstall()
    end
end

M.MasonUpdate = function()
    local notify = require "mason-core.notify"
    local registry = require "mason-registry"
    notify "Updating registries…"

    ---@param success boolean
    ---@param updated_registries RegistrySource[]
    local function handle_result(success, updated_registries)
        if success then
            local count = #updated_registries
            notify(("Successfully updated %d %s."):format(count, count == 1 and "registry" or "registries"))
        else
            notify(("Failed to update registries: %s"):format(updated_registries), vim.log.levels.ERROR)
        end
    end

    if require 'mason-core.platform'.is_headless then
        local a = require "mason-core.async"
        a.run_blocking(function()
            local success, updated_registries = a.wait(registry.update)
            a.scheduler()
            handle_result(success, updated_registries)
        end)
    else
        registry.update(function(...)
            local args = table.pack(...)
            vim.schedule(function()
                handle_result(unpack(args, 1, #args + 1))
            end)
        end)
    end
end

M.MasonLog = function()
    local log = require "mason-core.log"
    vim.cmd(([[tabnew %s]]):format(log.outfile))
end

return M
