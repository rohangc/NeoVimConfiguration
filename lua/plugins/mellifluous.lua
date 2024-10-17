return {
    {'ramojus/mellifluous.nvim',
        opts = {
            dim_inactive = false,
            colorset = 'alduin',
            styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
                main_keywords = {},
                other_keywords = {},
                types = {},
                operators = {},
                strings = {},
                functions = {},
                constants = {},
                comments = { italic = true },
                markup = {
                    headings = { bold = true },
                },
                folds = {},
            },
            transparent_background = {
                enabled = false,
                floating_windows = true,
                telescope = true,
                file_tree = true,
                cursor_line = true,
                status_line = false,
            },
            flat_background = {
                line_numbers = false,
                floating_windows = false,
                file_tree = false,
                cursor_line_number = false,
            },
            plugins = {
                cmp = true,
                nvim_tree = {
                    enabled = true,
                    show_root = false,
                },
                lazy = {
                    enabled = true,
                },
                mason = {
                    enabled = true,
                },
                telescope = {
                    enabled = true,
                    nvchad_like = true,
                },
                treesitter = {
                    enabled = true,
                }
            },
        },

        init = function()
            -- My Colour scheme
            vim.cmd("colorscheme mellifluous")

            -- My font (on Windows only)
            if vim.fn.has('gui_running') == 1 then
                if (vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1) then
                  -- The default Windows font.
                  -- Install your favourite font and edit the following line (my favourite is: 'Fira Code').
                  vim.opt.guifont = 'Cascadia Code:h11'
                  -- https://github.com/mietzen/juliamono-nerd-font
                  --vim.opt.guifont = 'JuliaMono Nerd Font:h12.25'
                end
            end
        end
    },
}
