return {
    'saghen/blink.cmp',
    opts_extend = {
        "sources.completion.enabled_providers",
        "sources.compat",
        "sources.default",
    },
    dependencies = {
        "rafamadriz/friendly-snippets",
        "supermaven-inc/supermaven-nvim",

        {
            "saghen/blink.compat",
            opts = {},
            version = "*",
        },
    },
    version = '*',
    opts = {

        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },

        signature = { enabled = true },
        keymap = {
            preset = "enter",
            ["<C-y>"] = { "select_and_accept" },
            ["<C-j>"] = { "select_next" },
            ["<C-k>"] = { "select_prev" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },

        sources = {
            -- default = { 'lsp', 'supermaven', 'path', 'snippets', 'buffer' },
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            -- You may disable cmdline completions by replacing this with an empty table
            cmdline = {
                enabled = false
            },
        },
    },
}
