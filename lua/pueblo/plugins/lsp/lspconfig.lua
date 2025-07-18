return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "antosha417/nvim-lsp-file-operations", config = true },
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        { 'j-hui/fidget.nvim',                   opts = {} },

        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { 'folke/neodev.nvim',                   opts = {} },
        { 'saghen/blink.cmp' },
    },
    config = function()
        local lspconfig = require("lspconfig")

        local on_attach = function(_, bufnr)
            local utils = require('pueblo.utils')
            utils.load_mappings('lspconfig', { buffer = bufnr })
        end

        local capabilities = require('blink.cmp').get_lsp_capabilities()


        vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true }, })

        lspconfig.gopls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            directoryFilters = { "-vendor", "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        }



        lspconfig["pyright"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        lspconfig["lua_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })
    end
}
