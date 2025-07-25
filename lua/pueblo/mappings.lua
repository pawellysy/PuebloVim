local M = {}
-- create a vim shortcut to close all other buffers
-- vim.api.nvim_set_keymap()

M.oil = {
    n = {
        ['-'] = { '<cmd>Oil<cr>' },
    }
}

M.general = {
    i = {
        -- go to  beginning and end
        ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
        ["<C-e>"] = { "<End>", "End of line" },

    },

    n = {
        ['<leader>d'] = { "<cmd>%bd!|e#|bd!#<cr>", "close all other buffers" },
        ['<leader>O'] = { "m`O<esc>``", "add one line above and not move cursor" },
        ['<leader>o'] = { "m`o<esc>``", "add one line below and not move cursor" },
        ["<leader>x"] = { "<cmd>bp|bd#<CR>", "close buffer" },
        ["<Esc>"] = { "<cmd>noh<CR>", "Clear highlights" },
        ["<leader>s"] = { "<cmd>wa<CR>", "save all files" },
        ["<leader>lg"] = { "<cmd>LazyGit<CR>", "Open LazyGit" },
        ["0"] = { "^", "go to first non whitespace char on the line" },
        ["^"] = { "0", "go to beginning o the line" },
        ["J"] = { "mzJ`z", 'move next line to the same line' },
        ["<c-i>"] = { "<c-i>zz", 'jumplist backward' },
        ["<c-o>"] = { "<c-o>zz", 'jumplist foreward' },

        -- move 1/2 screen
        ["<C-d>"] = { "<C-d>zz", 'go down 1/2 screen' },
        ["<C-u>"] = { "<C-u>zz", 'go up 1/2 screen' },
        ---
        ["n"] = { "nzzzv", 'go to next search result' },
        ["N"] = { "Nzzzv", 'go to prev search result' },

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
        ["<leader>y"] = { "\"*y", "yank to system register" },
        ["<leader>p"] = { "\"*p", "paste from system register" },

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
                vim.lsp.buf.hover { border = "single" }
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

    i = {
        ["<c-l>"] = { function() vim.lsp.buf.signature_help() end, "Signature Help" }
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

M.scratch = {
    n = {
        ["<leader>."] = { function() Snacks.scratch() end, "Toggle Scratch Buffer" },
        ["<leader>S"] = { function() Snacks.scratch.select() end, "Select Scratch Buffer" },
    },
}
M.telescope = {
    plugin = true,
    n = {
        -- find
        ["<leader>ff"] = { "<cmd> FzfLua files <CR>", "Find files" },
        ["<leader>fs"] = { "<cmd> FzfLua lsp_document_symbols <CR>", "Find symbols in the current document" },
        ["<leader>fw"] = { "<cmd> FzfLua live_grep <CR>", "Live grep" },
        ["<leader>fb"] = { "<cmd> FzfLua buffers <CR>", "Find buffers" },
        ["<leader>j"] = { "<cmd> FzfLua buffers <CR>", "Find buffers" },
        ["<leader>fz"] = { "<cmd> FzfLua lgrep_curbuf <CR>", "Find in current buffer" },
        ["<c-q>"] = { "<cmd> FzfLua quickfix <CR>", "Send quickfix list results back to fzf" },
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
        ['∆'] = { -- alt + j
            function() require('harpoon.ui').nav_next() end, 'Harpoon: next'
        },
        ['Ż'] = { -- alt + k
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

-- M.symbolsoutline = {
--     n = {
--         ["<leader>o"] = { "<cmd>SymbolsOutline<CR>", 'Show Symbols Outline' }
--     }
-- }

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


M.snacks = {
    n = {
        ["<leader>n"] = {
            function()
                Snacks.notifier.show_history()
            end,
            "show notification history",
        },
    },
}
M.conform = {
    n = {
        ["<leader>="] = {
            function()
                require("conform").format { async = true, lsp_fallback = true }
            end,
            "Format the whole file",
        },
    },
    v = {
        ["<leader>="] = {
            function()
                require("conform").format { async = true, lsp_fallback = true }
            end,
            "Format selection",
        },
    }
}
return M
