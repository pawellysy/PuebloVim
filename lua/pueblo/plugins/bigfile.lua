return {
    'LunarVim/bigfile.nvim',
    event = 'BufReadPre',
    enabled = false,
    opts = {
        filesize = 2
    },
    config = function (opts)
        require('bigfile').setup(opts)
    end
}
