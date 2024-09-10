return {
      "leath-dub/snipe.nvim",
      config = function()
        local snipe = require("snipe")
        snipe.setup({
            ui = {
                position  = 'cursor'
            }
        })
        vim.keymap.set("n", "<leader>j", snipe.create_buffer_menu_toggler())
      end
}
