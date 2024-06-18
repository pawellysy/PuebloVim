return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')


        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview"
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<c-k>"] = cmp.mapping.select_prev_item(),
                ["<c-j>"] = cmp.mapping.select_next_item(),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "crates" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            })
        })
    end
}
