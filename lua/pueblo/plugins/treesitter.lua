return {

    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "VeryLazy" },
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            config = function()
                -- When in diff mode, we want to use the default
                -- vim text objects c & C instead of the treesitter ones.
                local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
                local configs = require("nvim-treesitter.configs")
                for name, fn in pairs(move) do
                    if name:find("goto") == 1 then
                        move[name] = function(q, ...)
                            if vim.wo.diff then
                                local config = configs.get_module("textobjects.move")
                                    [name] ---@type table<string,string>
                                for key, query in pairs(config or {}) do
                                    if q == query and key:find("[%]%[][cC]") then
                                        vim.cmd("normal! " .. key)
                                        return
                                    end
                                end
                            end
                            return fn(q, ...)
                        end
                    end
                end
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter-context",
            event = "VeryLazy",
            enabled = true,
            opts = { mode = "cursor", max_lines = 3 },

        }
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            'vue',
            'css',
            "c",
            "diff",
            'ron',
            'go',
            'rust',
            "html",
            "javascript",
            'go',
            'goctl',
            'godot_resource',
            'gomod',
            'gosum',
            'gotmpl',
            'gowork',
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "svelte",
            "vim",
            "vimdoc",
            "yaml",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookehead = true,
                keymaps = {
                    ["a="] = { query = "@assignment.outer", desc = "Select outer part of assignment" },
                    ["i="] = { query = "@assignment.inner", desc = "Select inner part of assignment" },
                    ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of assignment" },
                    ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of assignment" },
                    ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
                    ["ia"] = { query = "@paramenter.inner", desc = "Select inner parameter" },
                    ["af"] = { query = "@function.outer", desc = "Select outer function" },
                    ["if"] = { query = "@function.inner", desc = "Select inner function" },
                    ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
                    ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
                    ["ac"] = { query = "@class.outer", desc = "Select outer class" },
                    ["ic"] = { query = "@class.inner", desc = "Select inner class" },
                }
            },
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
            },
        },
    },
    config = function(_, opts)
        vim.filetype.add({
            extension = {
                pyst = "python",
            },
        })
        if type(opts.ensure_installed) == "table" then
            ---@type table<string, boolean>
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
                if added[lang] then
                    return false
                end
                added[lang] = true
                return true
            end, opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
    end,

}
