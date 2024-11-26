return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('fzf-lua').setup {
            keymap = {
                builtin = {
                    -- Next and previous result
                    ["<C-j>"] = "down",
                    ["<C-k>"] = "up",
                },
                fzf = {
                    -- For fzf-native bindings (if you use them)
                    ["ctrl-j"] = "down",
                    ["ctrl-k"] = "up",
                },
            },
        }
    end
}
