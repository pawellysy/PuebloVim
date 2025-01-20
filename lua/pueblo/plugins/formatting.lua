return {

    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    -- keys = {
    --     {
    --         "<leader>=",
    --         function()
    --             require("conform").format { async = true, lsp_fallback = true }
    --         end,
    --         desc = "format the whole file",
    --     },
    -- },
    setup = function()
        require("conform").setup()
        require('pueblo.utils').load_mappings('conform')
    end,
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            javascript = { "biome", },
            typescript = { "biome", },
            jsx = { "biome", },
            tsx = { "biome", },
            svelte = { "biome", },
            vue = { "biome", },
            json = { "biome", }
        },

        formatters = {
            shfmt = {
                prepend_args = { "-i", "2" },
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
