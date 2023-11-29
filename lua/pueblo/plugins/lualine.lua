-- local M = {}
-- function M.get(opts)
--       local buf = vim.api.nvim_get_current_buf()
--       local ret = M.cache[buf]
--       if not ret then
--         local roots = M.detect({ all = false })
--     ret = roots[1] and roots[1].paths[1] or vim.loop.cwd()
--     M.cache[buf] = ret
--   end
--       if opts and opts.normalize then
--         return ret
--           end
--       return ret
-- end
--
-- ---@alias Sign {name:string, text:string, texthl:string, priority:number}
--
-- -- Returns a list of regular and extmark signs sorted by priority (low to high)
-- ---@return Sign[]
-- ---@param buf number
-- ---@param lnum number
-- function M.get_signs(buf, lnum)
--   -- Get regular signs
--   ---@type Sign[]
--   local signs = vim.tbl_map(function(sign)
--     ---@type Sign
--     local ret = vim.fn.sign_getdefined(sign.name)[1]
--     ret.priority = sign.priority
--     return ret
--   end, vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs)
--
--   -- Get extmark signs
--   local extmarks = vim.api.nvim_buf_get_extmarks(
--     buf,
--     -1,
--     { lnum - 1, 0 },
--     { lnum - 1, -1 },
--     { details = true, type = "sign" }
--   )
--   for _, extmark in pairs(extmarks) do
--     signs[#signs + 1] = {
--       name = extmark[4].sign_hl_group or "",
--       text = extmark[4].sign_text,
--       texthl = extmark[4].sign_hl_group,
--       priority = extmark[4].priority,
--     }
--   end
--
--   -- Sort by priority
--   table.sort(signs, function(a, b)
--     return (a.priority or 0) < (b.priority or 0)
--   end)
--
--   return signs
-- end
--
-- ---@return Sign?
-- ---@param buf number
-- ---@param lnum number
-- function M.get_mark(buf, lnum)
--   local marks = vim.fn.getmarklist(buf)
--   vim.list_extend(marks, vim.fn.getmarklist())
--   for _, mark in ipairs(marks) do
--     if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
--       return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
--     end
--   end
-- end
--
-- ---@param sign? Sign
-- ---@param len? number
-- function M.icon(sign, len)
--   sign = sign or {}
--   len = len or 2
--   local text = vim.fn.strcharpart(sign.text or "", 0, len) ---@type string
--   text = text .. string.rep(" ", len - vim.fn.strchars(text))
--   return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
-- end
--
-- function M.foldtext()
--   local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
--   local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()
--   if not ret or type(ret) == "string" then
--     ret = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
--   end
--   table.insert(ret, { " " .. require("lazyvim.config").icons.misc.dots })
--
--   if not vim.treesitter.foldtext then
--     return table.concat(
--       vim.tbl_map(function(line)
--         return line[1]
--       end, ret),
--       " "
--     )
--   end
--   return ret
-- end
--
-- function M.statuscolumn()
--   local win = vim.g.statusline_winid
--   local buf = vim.api.nvim_win_get_buf(win)
--   local is_file = vim.bo[buf].buftype == ""
--   local show_signs = vim.wo[win].signcolumn ~= "no"
--
--   local components = { "", "", "" } -- left, middle, right
--
--   if show_signs then
--     ---@type Sign?,Sign?,Sign?
--     local left, right, fold
--     for _, s in ipairs(M.get_signs(buf, vim.v.lnum)) do
--       if s.name and s.name:find("GitSign") then
--         right = s
--       else
--         left = s
--       end
--     end
--     if vim.v.virtnum ~= 0 then
--       left = nil
--     end
--     vim.api.nvim_win_call(win, function()
--       if vim.fn.foldclosed(vim.v.lnum) >= 0 then
--         fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
--       end
--     end)
--     -- Left: mark or non-git sign
--     components[1] = M.icon(M.get_mark(buf, vim.v.lnum) or left)
--     -- Right: fold icon or git sign (only if file)
--     components[3] = is_file and M.icon(fold or right) or ""
--   end
--
--   -- Numbers in Neovim are weird
--   -- They show when either number or relativenumber is true
--   local is_num = vim.wo[win].number
--   local is_relnum = vim.wo[win].relativenumber
--   if (is_num or is_relnum) and vim.v.virtnum == 0 then
--     if vim.v.relnum == 0 then
--       components[2] = is_num and "%l" or "%r" -- the current line
--     else
--       components[2] = is_relnum and "%r" or "%l" -- other lines
--     end
--     components[2] = "%=" .. components[2] .. " " -- right align
--   end
--
--   return table.concat(components, "")
-- end
--
-- function M.fg(name)
--   ---@type {foreground?:number}?
--   ---@diagnostic disable-next-line: deprecated
--   local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
--   ---@diagnostic disable-next-line: undefined-field
--   local fg = hl and (hl.fg or hl.foreground)
--   return fg and { fg = string.format("#%06x", fg) } or nil
-- end
--
-- M.skip_foldexpr = {} ---@type table<number,boolean>
-- local skip_check = assert(vim.loop.new_check())
--
-- function M.foldexpr()
--   local buf = vim.api.nvim_get_current_buf()
--
--   -- still in the same tick and no parser
--   if M.skip_foldexpr[buf] then
--     return "0"
--   end
--
--   -- don't use treesitter folds for non-file buffers
--   if vim.bo[buf].buftype ~= "" then
--     return "0"
--   end
--
--   -- as long as we don't have a filetype, don't bother
--   -- checking if treesitter is available (it won't)
--   if vim.bo[buf].filetype == "" then
--     return "0"
--   end
--
--   local ok = pcall(vim.treesitter.get_parser, buf)
--
--   if ok then
--     return vim.treesitter.foldexpr()
--   end
--
--   -- no parser available, so mark it as skip
--   -- in the next tick, all skip marks will be reset
--   M.skip_foldexpr[buf] = true
--   skip_check:start(function()
--     M.skip_foldexpr = {}
--     skip_check:stop()
--   end)
--   return "0"
-- end
--
-- function M.cmp_source(name, icon)
--   local started = false
--   local function status()
--     if not package.loaded["cmp"] then
--       return
--     end
--     for _, s in ipairs(require("cmp").core.sources) do
--       if s.name == name then
--         if s.source:is_available() then
--           started = true
--         else
--           return started and "error" or nil
--         end
--         if s.status == s.SourceStatus.FETCHING then
--           return "pending"
--         end
--         return "ok"
--       end
--     end
--   end
--
--   local colors = {
--     ok = M.fg("Special"),
--     error = M.fg("DiagnosticError"),
--     pending = M.fg("DiagnosticWarn"),
--   }
--
--   return {
--     function()
--       return icon or require("lazyvim.config").icons.kinds[name:sub(1, 1):upper() .. name:sub(2)]
--     end,
--     cond = function()
--       return status() ~= nil
--     end,
--     color = function()
--       return colors[status()] or colors.ok
--     end,
--   }
-- end
--
-- ---@param component any
-- ---@param text string
-- ---@param hl_group? string
-- ---@return string
-- function M.format(component, text, hl_group)
--   if not hl_group then
--     return text
--   end
--   ---@type table<string, string>
--   component.hl_cache = component.hl_cache or {}
--   local lualine_hl_group = component.hl_cache[hl_group]
--   if not lualine_hl_group then
--     local utils = require("lualine.utils.utils")
--     lualine_hl_group = component:create_hl({ fg = utils.extract_highlight_colors(hl_group, "fg") }, "LV_" .. hl_group)
--     component.hl_cache[hl_group] = lualine_hl_group
--   end
--   return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
-- end
--
-- ---@param opts? {relative: "cwd"|"root", modified_hl: string?}
-- function M.pretty_path(opts)
--   opts = vim.tbl_extend("force", {
--     relative = "cwd",
--     modified_hl = "Constant",
--   }, opts or {})
--
--   return function(self)
--     local path = vim.fn.expand("%:p") --[[@as string]]
--
--     if path == "" then
--       return ""
--     end
--     local root = M.root.get({ normalize = true })
--     local cwd = M.root.cwd()
--
--     if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
--       path = path:sub(#cwd + 2)
--     else
--       path = path:sub(#root + 2)
--     end
--
--     local sep = package.config:sub(1, 1)
--     local parts = vim.split(path, "[\\/]")
--     if #parts > 3 then
--       parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
--     end
--
--     if opts.modified_hl and vim.bo.modified then
--       parts[#parts] = M.format(self, parts[#parts], opts.modified_hl)
--     end
--
--     return table.concat(parts, sep)
--   end
-- end
--
-- ---@param opts? {cwd:false, subdirectory: true, parent: true, other: true, icon?:string}
-- function M.root_dir(opts)
--   opts = vim.tbl_extend("force", {
--     cwd = false,
--     subdirectory = true,
--     parent = true,
--     other = true,
--     icon = "󱉭 ",
--     color = M.fg("Special"),
--   }, opts or {})
--
--   local function get()
--     local cwd = M.root.cwd()
--     local root = M.root.get({ normalize = true })
--     local name = vim.fs.basename(root)
--
--     if root == cwd then
--       -- root is cwd
--       return opts.cwd and name
--     elseif root:find(cwd, 1, true) == 1 then
--       -- root is subdirectory of cwd
--       return opts.subdirectory and name
--     elseif cwd:find(root, 1, true) == 1 then
--       -- root is parent directory of cwd
--       return opts.parent and name
--     else
--       -- root and cwd are not related
--       return opts.other and name
--     end
--   end
--
--   return {
--     function()
--       return (opts.icon and opts.icon .. " ") .. get()
--     end,
--     cond = function()
--       return type(get()) == "string"
--     end,
--     color = opts.color,
--   }
-- end
--
-- return {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     init = function()
--       vim.g.lualine_laststatus = vim.o.laststatus
--       if vim.fn.argc(-1) > 0 then
--         -- set an empty statusline till lualine loads
--         vim.o.statusline = " "
--       else
--         -- hide the statusline on the starter page
--         vim.o.laststatus = 0
--       end
--     end,
--     opts = function()
--       -- PERF: we don't need this lualine require madness 🤷
--       local lualine_require = require("lualine_require")
--       lualine_require.require = require
--
--       local icons = require("lazyvim.config").icons
--
--       vim.o.laststatus = vim.g.lualine_laststatus
--
--       return {
--         options = {
--           theme = "auto",
--           globalstatus = true,
--           disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
--         },
--         sections = {
--           lualine_a = { "mode" },
--           lualine_b = { "branch" },
--
--           lualine_c = {
--             M.root_dir(),
--             {
--               "diagnostics",
--               symbols = {
--                 error = icons.diagnostics.Error,
--                 warn = icons.diagnostics.Warn,
--                 info = icons.diagnostics.Info,
--                 hint = icons.diagnostics.Hint,
--               },
--             },
--             { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
--             { M.pretty_path() },
--           },
--           lualine_x = {
--             -- stylua: ignore
--             {
--               function() return require("noice").api.status.command.get() end,
--               cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
--               color = M.fg("Statement"),
--             },
--             -- stylua: ignore
--             {
--               function() return require("noice").api.status.mode.get() end,
--               cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
--               color = M.fg("Constant"),
--             },
--             -- stylua: ignore
--             {
--               function() return "  " .. require("dap").status() end,
--               cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
--               color = M.fg("Debug"),
--             },
--             {
--               require("lazy.status").updates,
--               cond = require("lazy.status").has_updates,
--               color = M.fg("Special"),
--             },
--             {
--               "diff",
--               symbols = {
--                 added = icons.git.added,
--                 modified = icons.git.modified,
--                 removed = icons.git.removed,
--               },
--               source = function()
--                 local gitsigns = vim.b.gitsigns_status_dict
--                 if gitsigns then
--                   return {
--                     added = gitsigns.added,
--                     modified = gitsigns.changed,
--                     removed = gitsigns.removed,
--                   }
--                 end
--               end,
--             },
--           },
--           lualine_y = {
--             { "progress", separator = " ", padding = { left = 1, right = 0 } },
--             { "location", padding = { left = 0, right = 1 } },
--           },
--           lualine_z = {
--             function()
--               return " " .. os.date("%R")
--             end,
--           },
--         },
--         extensions = { "neo-tree", "lazy" },
--       }
--     end,
--   };
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function ()

        -- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

    end
}
