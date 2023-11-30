local M = {};
function M.fg(name)
  ---@type {foreground?:number}?
  ---@diagnostic disable-next-line: deprecated
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  ---@diagnostic disable-next-line: undefined-field
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format("#%06x", fg) } or nil
end

return  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
        local lualine_require = require("lualine_require")
        lualine_require.require = require

        local icons = {
            misc = {
                dots = "󰇘",
            },
            dap = {
                Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
                Breakpoint          = " ",
                BreakpointCondition = " ",
                BreakpointRejected  = { " ", "DiagnosticError" },
                LogPoint            = ".>",
            },
            diagnostics = {
                Error = " ",
                Warn  = " ",
                Hint  = " ",
                Info  = " ",
            },
            git = {
                added    = " ",
                modified = " ",
                removed  = " ",
            },
            kinds = {
                Array         = " ",
                Boolean       = "󰨙 ",
                Class         = " ",
                Codeium       = "󰘦 ",
                Color         = " ",
                Control       = " ",
                Collapsed     = " ",
                Constant      = "󰏿 ",
                Constructor   = " ",
                Copilot       = " ",
                Enum          = " ",
                EnumMember    = " ",
                Event         = " ",
                Field         = " ",
                File          = " ",
                Folder        = " ",
                Function      = "󰊕 ",
                Interface     = " ",
                Key           = " ",
                Keyword       = " ",
                Method        = "󰊕 ",
                Module        = " ",
                Namespace     = "󰦮 ",
                Null          = " ",
                Number        = "󰎠 ",
                Object        = " ",
                Operator      = " ",
                Package       = " ",
                Property      = " ",
                Reference     = " ",
                Snippet       = " ",
                String        = " ",
                Struct        = "󰆼 ",
                TabNine       = "󰏚 ",
                Text          = " ",
                TypeParameter = " ",
                Unit          = " ",
                Value         = " ",
                Variable      = "󰀫 ",
            },
        }

        vim.o.laststatus = vim.g.lualine_laststatus

        return {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },

                lualine_c = {
                    -- Util.lualine.root_dir(),
                    {
                        "diagnostics",
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                    },
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }, -- might change to prettyPath
                    {'filename', file_status = true, full_path = true},
                },
                lualine_x = {
                    -- stylua: ignore
                    {
                        function() return require("noice").api.status.command.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                        color = M.fg("Statement"),
                    },
                    -- stylua: ignore
                    {
                        function() return require("noice").api.status.mode.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        color = M.fg("Constant"),
                    },
                    -- stylua: ignore
                    {
                        function() return "  " .. require("dap").status() end,
                        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                        color = M.fg("Debug"),
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = M.fg("Special"),
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                    },
                },
                lualine_y = {
                    { "progress", separator = " ", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
            extensions = { "neo-tree", "lazy" },
        }
    end,
  }
