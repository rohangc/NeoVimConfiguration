-- See this website for documentation of plugin 'lsp-zero' that helps you setup LSP without 'lsp-zero'!:
-- https://lsp-zero.netlify.app/docs/getting-started.html

return{
    {'neovim/nvim-lspconfig',
        dependencies = {
            -- Use Mason for LSP server package management
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',

            -- Copilot
            'zbirenbaum/copilot-cmp',
            'zbirenbaum/copilot.lua',
            'nvim-lua/plenary.nvim',
            {'CopilotC-Nvim/CopilotChat.nvim', branch = 'canary',},
        },

        init = function()

            ----------------------------------------------------------------------------------
            --                                   LSP
            ----------------------------------------------------------------------------------
            require("mason").setup()

            require('mason-lspconfig').setup({
                ensure_installed = {'clangd',},
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                },
            })

            -- Configure clangd here:
            --require('lspconfig').clangd.setup({
            --})

            -- NOTE: to make any of this work you need a language server.
            -- If you don't know what that is, you should do some research.

            -- Reserve a space in the gutter
            vim.opt.signcolumn = 'yes'

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- This is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = {buffer = event.buf}

                    vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', '<leader>go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    vim.keymap.set({'n', 'x'}, '<F4>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                end,
            })

            require('copilot').setup({
                panel = {enabled = false},
                suggestion = {enabled = false},
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },

                copilot_node_command = 'node', -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })

            -- You'll find a list of language servers here:
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
            -- These are example language servers. 
            -- require('lspconfig').gleam.setup({})
            -- require('lspconfig').rust_analyzer.setup({})

            ----------------------------------------------------------------------------------
            --                                   CMP
            ----------------------------------------------------------------------------------
            local cmp = require('cmp')

            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
            end

            cmp.setup({
                sources = {
                    {name = 'nvim_lsp'},
                    {name = 'copilot'},
                },
                snippet = {
                    expand = function(args)
                    -- You need Neovim v0.10 to use vim.snippet
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- Navigate between completion items
                    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
                    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),

                    -- `Enter` key to confirm completion
                    ['<CR>'] = cmp.mapping.confirm({select = false}),

                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),

                    -- Github Copilot <TAB> completion
                    ['<Tab>'] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end),
                }),
            })

            require('copilot_cmp').setup()
            require('CopilotChat').setup()
        end,
    },
}
