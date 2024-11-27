return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "ms-jpq/coq_nvim",                     branch = "coq" },

        -- 9000+ Snippets
        { "ms-jpq/coq.artifacts",                branch = "artifacts" },

        -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
        -- Need to **configure separately**
        { 'ms-jpq/coq.thirdparty',               branch = "3p" }

    },
    init = function()
        vim.g.coq_settings = {
            auto_start = true,
        }
    end,
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
        local coq = require("coq")

        -- Do not forget to use the on_attach function

        -- To instead override globally
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        local lspconfig = require("lspconfig")

        local on_attach = function(client, bufnr)
            local utils = require('pueblo.utils')
            utils.load_mappings('lspconfig', { buffer = bufnr })
        end

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig.gopls.setup(coq.lsp_ensure_capabilities({
            on_attach = on_attach,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" }
        }))

        lspconfig.buf_ls.setup(coq.lsp_ensure_capabilities({
            on_attach = on_attach,
        }))



        lspconfig['rust_analyzer'].setup(coq.lsp_ensure_capabilities({
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
        }));
        lspconfig.ts_ls.setup(coq.lsp_ensure_capabilities({
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
            },
        }))


        lspconfig.pyright.setup(coq.lsp_ensure_capabilities({
            on_attach = on_attach,
        }))
        lspconfig.svelte.setup(coq.lsp_ensure_capabilities({
            on_attach = on_attach,
        }))

        lspconfig.biome.setup({
        })

        lspconfig["cssls"].setup(coq.lsp_ensure_capabilities({
            on_attach = on_attach,

        }))

        lspconfig.vtsls.setup(coq.lsp_ensure_capabilities({
            on_attach = on_attach,
            filetypes = { "vue" }
        }))

        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
            pattern = "*.wgsl",
            callback = function()
                vim.bo.filetype = "wgsl"
            end,
        })

        lspconfig.wgsl_analyzer.setup {}

        lspconfig["lua_ls"].setup(coq.lsp_ensure_capabilities({
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
        }))
    end
}
