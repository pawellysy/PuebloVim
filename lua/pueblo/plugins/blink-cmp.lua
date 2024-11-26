return {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = 'rafamadriz/friendly-snippets',

    version = 'v0.*',
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        keymap = { preset = 'enter' },

        highlight = {
            use_nvim_cmp_as_default = true,
        },
        nerd_font_variant = 'mono',

        sources = {
            completion = {
                enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },

        -- experim
        accept = { auto_brackets = { enabled = true } },

        -- experimental signature help support
        trigger = { signature_help = { enabled = true } }
    },
    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.completion.enabled_providers" }
    -- LSP servers and clients communicate what features they support through "capabilities".
    --  By default, Neovim support a subset of the LSP specification.
    --  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
    --  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
    --
    -- This can vary by config, but in general for nvim-lspconfig:
}
