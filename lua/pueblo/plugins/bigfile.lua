return {
    'LunarVim/bigfile.nvim',
    enabled = false,
    event = 'BufReadPre',
    opts = {
        filesize = 5
    },
    config = function (opts)
        require('bigfile').setup(opts)
    end
}
