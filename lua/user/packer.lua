-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Failed to require packer!")
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    use("folke/tokyonight.nvim")
    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })
    use({
        "folke/trouble.nvim",
        wants = "nvim-web-devicons",
        cmd = { "TroubleToggle", "Trouble" },
        config = function()
            require("trouble").setup({
                use_diagnostic_signs = true,
            })
        end,
    })
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use("kyazdani42/nvim-tree.lua")
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-context')
    use('nvim-treesitter/playground')
    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use("norcalli/nvim-colorizer.lua")
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                -- for example, context is off by default, use this to turn it on
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    })

    use("ldelossa/litee.nvim")
    use("ldelossa/litee-calltree.nvim")
    use("ldelossa/litee-symboltree.nvim")
    use("ldelossa/litee-filetree.nvim")
    use("ldelossa/litee-bookmarks.nvim")

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use("ray-x/lsp_signature.nvim")

    use("github/copilot.vim")

    use({ "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } })
    use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" }) -- A snazzy bufferline
    use({
        "nvim-lualine/lualine.nvim",                                                            -- A blazing fast and easy to configure Neovim statusline written in Lua
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
    use({
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    })

    use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }) -- Folding
    use("windwp/nvim-autopairs")                                              -- Autopairs, integrates with both cmp and treesitter
    use("windwp/nvim-ts-autotag")

    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })

    use({
        "akinsho/toggleterm.nvim",
        tag = "v2.*",
        config = function()
            require("toggleterm").setup({
                close_on_exit = true,
            })
        end,
    })

    -- Java
    use("mfussenegger/nvim-jdtls")

    -- DAP
    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-dap-python")
    use("mxsdev/nvim-dap-vscode-js")
    use {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npm run compile"
    }
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
    use("nvim-telescope/telescope-dap.nvim")

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                mappings = {
                    ---Operator-pending mapping
                    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
                    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
                    basic = false,
                    ---Extra mapping
                    ---Includes `gco`, `gcO`, `gcA`
                    extra = false,
                    ---Extended mapping
                    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
                    extended = false,
                },
            })
        end,
    })
    -- Git
    use({
        "lewis6991/gitsigns.nvim", -- Git integration for buffers
        config = function()
            require("gitsigns").setup({
                numhl = true,
            })
        end,
    })
    use('tpope/vim-fugitive')
    use("f-person/git-blame.nvim")
end)
