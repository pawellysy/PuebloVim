return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
        vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

        local border = {
            { " ", "FloatBorder" },
            { "▔", "FloatBorder" },
            { " ", "FloatBorder" },
            { "▕", "FloatBorder" },
            { " ", "FloatBorder" },
            { "▁", "FloatBorder" },
            { " ", "FloatBorder" },
            { "▏", "FloatBorder" },
        }

        -- LSP settings (for overriding per client)
        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        }

        -- Do not forget to use the on_attach function

        -- To instead override globally
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        local lspconfig = require("lspconfig")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local on_attach = function(client, bufnr)
            local utils = require('pueblo.utils')
            utils.load_mappings('lspconfig', { buffer = bufnr })
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig.gopls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" }
        }

        lspconfig.bufls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }



        lspconfig['rust_analyzer'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    assist = {
                        importGranularity = "module",
                        importPrefix = "by_self",
                    },
                    cargo = {
                        loadOutDirsFromCheck = true,
                        allFeatures = true
                    },
                    procMacro = {
                        enable = true
                    },
                }
            }
        });
        lspconfig.ts_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = '/home/oguz/.local/share/nvim/mason/bin/vue-language-server',
                        languages = { 'vue' },
                    },
                },
            },

            lspconfig.volar.setup {
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                },
            }, }


        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.svelte.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.biome.setup({
        })

        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,

        })

        lspconfig.vtsls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "vue" }
        })

        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
            pattern = "*.wgsl",
            callback = function()
                vim.bo.filetype = "wgsl"
            end,
        })

        lspconfig.wgsl_analyzer.setup {}

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
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
