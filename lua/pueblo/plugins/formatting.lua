return {

    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>=",
            function()
                require("conform").format { async = true, lsp_fallback = true }
            end,
            mode = "v",
            desc = "Format the selected part",
        },
    },
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            javascript = { { "biome" } },
            typescript = { { "biome" } },

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
