return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {--[[ things you want to change go here]]},
    config = function ()
        require('pueblo.utils').load_mappings('terminal')
        require('toggleterm').setup()
    end
}
