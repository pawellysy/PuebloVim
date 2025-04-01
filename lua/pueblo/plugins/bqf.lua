return {
    'kevinhwang91/nvim-bqf',
    event = 'VeryLazy',
    dependencies = { 'junegunn/fzf' },
    config = function(opts)
        opts.func_map = {
            open = '<cr>',
            openc = 'o',
            drop = 'o',
            split = '<c-x>',
            vsplit = '<c-v>',
            tab = 't',
            tabb = 't',
            tabc = '<c-t>',
            tabdrop = '',
            ptogglemode = 'zp',
            ptoggleitem = 'p',
            ptoggleauto = 'p',
            pscrollup = '<c-b>',
            pscrolldown = '<c-f>',
            pscrollorig = 'zo',
            prevfile = '<c-p>',
            nextfile = '<c-n>',
            prevhist = '<',
            nexthist = '>',
            lastleave = [['"]],
            stoggleup = '<s-tab>',
            stoggledown = '<tab>',
            stogglevm = '<tab>',
            stogglebuf = [['<tab>]],
            sclear = 'z<tab>',
            filter = 'zn',
            filterr = 'zn',
            fzffilter = 'zj'
        }

        require('bqf').setup(opts)
    end
}
