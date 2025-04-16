return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            {'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font}
        },
        init = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Telescope buffers'})
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {desc = 'Telescope diagnostics'})
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Telescope find files'})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = 'Telescope live grep'})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'Telescope help tags'})
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, {desc = 'Telescope [S]earch [K]eymaps'})
            vim.keymap.set('n', '<leader>ft', builtin.tagstack, {desc = 'Telescope tag stack'})
            vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope search current [W]ord'})
        end,
    },
}
