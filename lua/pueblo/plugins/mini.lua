return {
    { 'echasnovski/mini.trailspace', version = '*' },
    { 'echasnovski/mini.ai',         version = '*' },
    {
        'echasnovski/mini.bufremove',
        version = '*',
        enabled = true,
        setup = function()
            require('mini.bufremove').setup() -- use default config
        end
    }
}
