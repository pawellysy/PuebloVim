local M = {}
-- create a vim shortcut to close all other buffers
-- vim.api.nvim_set_keymap()

M.globalnote = {
    n = {
        ['<leader>gn'] = { '<cmd>GlobalNote<cr>' },
    }
}
M.general = {
    i = {
        -- go to  beginning and end
        ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
        ["<C-e>"] = { "<End>", "End of line" },

        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", "Move left" },
        ["<C-l>"] = { "<Right>", "Move right" },
        ["<C-j>"] = { "<Down>", "Move down" },
        ["<C-k>"] = { "<Up>", "Move up" },
    },

    n = {
        ["<tab>"] = { "<cmd>bnext<CR>", "go to next buffer" },
        ["<S-tab>"] = { "<cmd>bprev<CR>", "go to prev buffer" },
        -- ['<leader>b']= {':BufDel<CR>', "close all other buffers"},
        ["<leader>x"] = { "<cmd>bd<CR>", "close buffer" },
        ["<Esc>"] = { "<cmd>noh<CR>", "Clear highlights" },
        ["<leader>s"] = { "<cmd>wa<CR>", "save all files" },
        ["<leader>lg"] = { "<cmd>LazyGit<CR>", "Open LazyGit" },
        -- switch between windows "<leader>d"
        --
        ["<leader>d"] = { "<cmd>BufferLineCloseOthers<CR>", "close other buffers" },
        ["<C-h>"] = { "<C-w>h", "Window left" },
        ["<C-l>"] = { "<C-w>l", "Window right" },
        ["<C-j>"] = { "<C-w>j", "Window down" },
        ["<C-k>"] = { "<C-w>k", "Window up" },
        ["J"] = { "mzJ`z", 'move next line to the same line' },
        -- move 1/2 screen
        ["<C-d>"] = { "<C-d>zz", 'go down 1/2 screen' },
        ["<C-u>"] = { "<C-u>zz", 'go up 1/2 screen' },

        ---
        ["n"] = { "nzzzv", 'go to next search result' },
        ["N"] = { "Nzzzv", 'go to prev search result' },

        -- save
        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

        -- Copy all
        ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

        -- line numbers
        ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

        -- new buffer

        ["<leader>fm"] = {
            function()
                vim.lsp.buf.format { async = true }
            end,
            "LSP formatting",
        },
    },

    t = {
        ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
        ["<C-j>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N><C-w>j", true, true, true), "Move from terminal to window down" },
        ["<C-k>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N><C-w>k", true, true, true), "Move from terminal to window up" },
        ["<C-h>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N><C-w>h", true, true, true), "Move from terminal to window left" },
        ["<C-l>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N><C-w>l", true, true, true), "Move from terminal to window right" },
    },

    v = {
        ["J"] = { ":m '>+1<CR>gv=gv", "Move selected lines up" },
        ["K"] = { ":m '<-2<CR>gv=gv", "Move selected lines down" },
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        ["<"] = { "<gv", "Indent line" },
        [">"] = { ">gv", "Indent line" },
        ["<leader>d"] = { "\"_d", "delete to black hole register" },
    },

    x = {
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
    },
}

M.comment = {
    plugin = true,

    -- toggle comment in both modes
    n = {
        ["<leader>/"] = {
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            "Toggle comment",
        },
    },

    v = {
        ["<leader>/"] = {
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            "Toggle comment",
        },
    },
}

-- M.bqf = {
--     plugin = true,
--     n = {
--         ["<C-q>"] = {
--             "<cmd>copen<CR>",
--             "show quickfix window"
--         }
--     }
--
-- }
M.lspconfig = {
    plugin = true,

    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

    n = {
        ["<leader>ra"] = {
            function()
                vim.lsp.buf.rename()
            end,
            "LSP rename",
        },
        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "LSP declaration",
        },

        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "LSP definition",
        },

        ["K"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "LSP hover",
        },

        ["gi"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "LSP implementation",
        },

        ["<leader>ls"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "LSP signature help",
        },

        ["<leader>D"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            "LSP definition type",
        },

        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
        },

        ["gr"] = {
            function()
                vim.lsp.buf.references()
            end,
            "LSP references",
        },

        ["<leader>fd"] = {
            function()
                vim.diagnostic.open_float { border = "rounded" }
            end,
            "Floating diagnostic",
        },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev { float = { border = "rounded" } }
            end,
            "Goto prev",
        },

        ["]d"] = {
            function()
                vim.diagnostic.goto_next { float = { border = "rounded" } }
            end,
            "Goto next",
        },

        ["<leader>q"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "Diagnostic setloclist",
        },

        ["<leader>wa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "Add workspace folder",
        },

        ["<leader>wr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "Remove workspace folder",
        },

        ["<leader>wl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "List workspace folders",
        },
    },

    v = {
        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
        },
    },
}

M.nvimtree = {
    plugin = true,

    n = {
        -- toggle
        ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    },
}

M.telescope = {
    plugin = true,
    n = {
        -- find
        ["<leader>ff"] = { "<cmd> Telescope find_files theme=ivy<CR>", "Find files" },
        ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Find symbols in the current document" },
        ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
        ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
        ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
        ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

        -- git
        ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
        ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

        ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
    },
}

M.whichkey = {
    plugin = true,
    n = {
        ["<leader>wK"] = {
            function()
                vim.cmd "WhichKey"
            end,
            "Which-key all keymaps",
        },
        ["<leader>wk"] = {
            function()
                local input = vim.fn.input "WhichKey: "
                vim.cmd("WhichKey " .. input)
            end,
            "Which-key query lookup",
        },
    },
}

M.blankline = {
    plugin = true,

    n = {
        ["<leader>cc"] = {
            function()
                local ok, start = require("indent_blankline.utils").get_current_context(
                    vim.g.indent_blankline_context_patterns,
                    vim.g.indent_blankline_use_treesitter_scope
                )

                if ok then
                    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                    vim.cmd [[normal! _]]
                end
            end,

            "Jump to current context",
        },
    },
}

M.gitsigns = {
    plugin = true,

    n = {
        -- Navigation through hunks
        ["<leader>gp"] = { "<cmd>lua require('gitsigns').preview_hunk()<CR>", "Preview hunk" },
        ["]c"] = {
            function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    require("gitsigns").next_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to next hunk",
            opts = { expr = true },
        },

        ["[c"] = {
            function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    require("gitsigns").prev_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to prev hunk",
            opts = { expr = true },
        },

        -- Actions
        ["<leader>rh"] = {
            function()
                require("gitsigns").reset_hunk()
            end,
            "Reset hunk",
        },

        ["<leader>ph"] = {
            function()
                require("gitsigns").preview_hunk()
            end,
            "Preview hunk",
        },

        ["<leader>gb"] = {
            function()
                package.loaded.gitsigns.blame_line()
            end,
            "Blame line",
        },

        ["<leader>td"] = {
            function()
                require("gitsigns").toggle_deleted()
            end,
            "Toggle deleted",
        },
    },
}

M.trouble = {
    plugin = true,
    n = {
        ["<leader>tx"] = {

            function() require("trouble").toggle() end,
            "Trouble: toggle"
        },
        ["<leader>tw"] = {
            function()
                require("trouble").toggle("workspace_diagnostics")
            end,
            "Trouble: workspace workspace_diagnostics"
        },
        ["<leader>td"] = {
            function()
                require("trouble").toggle("document_diagnostics")
            end,
            'Trouble: document_diagnostics'
        },
        ["<leader>tq"] = {
            function()
                require("trouble").toggle("quickfix")
            end,
            'Trouble: quickfix list'
        },
        ["<leader>tl"] = {
            function() require("trouble").toggle("loclist") end,
            'Trouble: loclist'
        },
        ["gR"] = {
            function() require("trouble").toggle("lsp_references") end,
            'Trouble: lsp references'
        }
    }
}

M.harpoon = {
    n = {
        ['<leader>a'] = {
            function() require('harpoon.mark').add_file() end, 'Harpoon: add file'
        },
        ['<c-e>'] = {
            function() require('harpoon.ui').toggle_quick_menu() end, 'Harpoon: toggle quick menu'
        },
        ['<a-j>'] = {
            function() require('harpoon.ui').nav_next() end, 'Harpoon: next'
        },
        ['<a-k>'] = {
            function() require('harpoon.ui').nav_prev() end, 'Harpoon: prev'
        },
        ['<a-i>'] = {
            function() require('harpoon.ui').nav_file(1) end, 'Harpoon: goto 1'
        },
        ['<a-o>'] = {
            function() require('harpoon.ui').nav_file(2) end, 'Harpoon: goto 2'
        },
        ['<a-p>'] = {
            function() require('harpoon.ui').nav_file(3) end, 'Harpoon: goto 3'
        },
    }

}

M.symbolsoutline = {
    n = {
        ["<leader>o"] = { "<cmd>SymbolsOutline<CR>", 'Show Symbols Outline' }
    }
}

-- M.dap = {
--
--     n = {
--
--         ['<Leader>dc'] = { function() require("dap").continue() end, 'Debug start/continue' },
--         ['<Leader>do'] = { function() require("dap").step_over() end, 'Debug step over' },
--         ['<Leader>di'] = { function() require("dap").step_into() end, 'Debug step into' },
--         ['<Leader>du'] = { function() require("dap").step_out() end, 'Debug step out' },
--         ['<Leader>db'] = { function() require("dap").toggle_breakpoint() end, 'Debug toggle breakpoint' },
--         ['<Leader>dB'] = { function() require("dap").set_breakpoint() end, 'Debug set breakpoint' },
--         ['<Leader>dr'] = { function() require("dap").repl.open() end, 'Debug open REPL' },
--         ['<Leader>dR'] = { function() require("dap").repl.close() end, 'Debug close REPL' },
--         ['<Leader>dl'] = { function() require("dap").run_last() end, 'Debug run last' },
--         ['<Leader>dlp'] = { function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, 'Debug set breackpoint with log message' },
--         ['<Leader>ds'] = { function() require("dap").terminate({}, {}, function() print "DAP session finished" end) end, 'Debug stop/delete session' },
--         ['<Leader>dh'] = { function() require('dap.ui.widgets').hover() end, 'Debug widgets hover' },
--         ['<Leader>dp'] = { function() require('dap.ui.widgets').preview() end, 'Debug widgets preview' },
--         ['<Leader>dF'] = { function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames) end, 'Debug widgets frames' },
--         ['<Leader>dS'] = { function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes) end, 'Debug widgets scopes' }
--
--     }
-- }

M.terminal = {
    n = {
        ['<C-g>'] = {"<cmd>ToggleTerm<CR>", "Show terminal"},
    },
    t = {
        ['<C-g>'] = {"<cmd>ToggleTerm<CR>", "Hide terminal"},
    }

}
return M
