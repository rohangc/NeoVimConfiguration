return {
    {'akinsho/toggleterm.nvim',
        version = "*",

        opts = {
            close_on_exit = true,
            clear_env = true, 
        },

        keys = {
            {'<F12>', "<Cmd>exe v:count1 . \"ToggleTerm\"<CR>", mode = 'n'},
            {'<F12>', "<Esc><Cmd>exe v:count1 . \"ToggleTerm\"<CR>", mode = 'i'},
        },
    },
}
