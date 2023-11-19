return {
        'kevinhwang91/nvim-bqf',
        event = 'VeryLazy',
            dependencies = {'junegunn/fzf'},
            config = function ()
            require('bqf').setup({
                func_map = {
                    fzffilter = 'zF'
                    }
            })
        end
    }
