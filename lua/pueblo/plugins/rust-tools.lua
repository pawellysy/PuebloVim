local on_attach = function(client, bufnr)
    require('pueblo.utils').load_mappings('lspconfig', {buffer = bufnr})
end
return {
    'simrat39/rust-tools.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    ft = {'rust'},
    opts = function ()
        return {
            tools = {
                autoSetHints = true,
                hover_with_actions = true,
                runnables = {
                    use_telescope = true
                },
                inlay_hints = {
                    show_parameter_hints = true,
                    parameter_hints_prefix = "<- ",
                    other_hints_prefix = "=> ",
                    max_len_align = false,
                    max_len_align_padding = 1,
                    right_align = false,
                    right_align_padding = 7,
                },
                hover_actions = {
                    auto_focus = false,
                },
            },
            server = {
                on_attach = on_attach,
                -- on_init = require('lsp').on_init,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                settings = {
                    ["rust-analyzer"] = {
                        assist = {
                            importGranularity = "module",
                            importPrefix = "by_self",
                        },
                        cargo = {
                            loadOutDirsFromCheck = true
                        },
                        procMacro = {
                            enable = true
                        },
                        checkOnSave = {
                            command = "clippy"
                        },
                        diagnostics = {
                            disabled = { "unresolved-proc-macro" },
                            enableExperimental = true
                        },
                        experimental = {
                            procAttrMacros = true
                        }
                    }
                }
            }
        }
    end,
    config = function (options)
        require('rust-tools').setup(options)
    end
}
