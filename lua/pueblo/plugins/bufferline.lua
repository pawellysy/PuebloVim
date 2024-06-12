return {
    'akinsho/bufferline.nvim',
    version = "*",
    -- enabled = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup({
            options = {
                show_buffer_icons = false,
                mode = 'tabs',
                always_show_bufferline = false
            }
        })
    end
}
