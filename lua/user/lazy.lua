local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

----------------
--- plugins ---
----------------
require("lazy").setup({

    {
        'olatheander/hello-world-lua-neovim-plugin', -- My own hello-world plugin
        dev = true,
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
    { "folke/tokyonight.nvim" },
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = function()
            require("trouble").setup({
                use_diagnostic_signs = true,
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },
    { "kyazdani42/nvim-tree.lua" },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            -- Additional text objects via treesitter
            'nvim-treesitter/nvim-treesitter-textobjects'
        }
    },
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'nvim-treesitter/playground' },
    -- { 'theprimeagen/harpoon' },
    { 'mbbill/undotree' },
    { "norcalli/nvim-colorizer.lua" },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    { "ldelossa/litee.nvim" },
    { "ldelossa/litee-calltree.nvim" },
    { "ldelossa/litee-symboltree.nvim" },
    { "ldelossa/litee-filetree.nvim" },
    -- { "ldelossa/litee-bookmarks.nvim" },

    { "MattesGroeger/vim-bookmarks" },
    {
        "tom-anders/telescope-vim-bookmarks.nvim",
        config = function()
            vim.g.bookmark_save_per_working_dir = 1
            vim.g.bookmark_auto_save = 1
        end,
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
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
    },

    -- { "ray-x/lsp_signature.nvim" }, --Disabled due to bug: https://github.com/ray-x/lsp_signature.nvim/issues/283

    { "github/copilot.vim" },

    { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } },
    {
        "akinsho/bufferline.nvim",
        dependencies = "kyazdani42/nvim-web-devicons"
    },                               -- A snazzy bufferline
    {
        "nvim-lualine/lualine.nvim", -- A blazing fast and easy to configure Neovim statusline written in Lua
        dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async"
    },                           -- Folding
    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
    { "windwp/nvim-ts-autotag" },

    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                close_on_exit = true,
            })
        end,
    },

    -- Java
    { "mfussenegger/nvim-jdtls" },

    -- Scala
    {
        "scalameta/nvim-metals",
        dependencies = "nvim-lua/plenary.nvim",
    },

    -- DAP
    { "mfussenegger/nvim-dap" },
    { "mfussenegger/nvim-dap-python" },
    { "mxsdev/nvim-dap-vscode-js" },
    {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = "npm install --legacy-peer-deps && npm run compile"
    },
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },

    {
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
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim", -- Git integration for buffers
        config = function()
            require("gitsigns").setup({
                numhl = true,
            })
        end,
    },
    { 'tpope/vim-fugitive' },
    { "f-person/git-blame.nvim" }
}, {
    dev = {
        -- directory where you store your local plugin projects
        path = "~/Git",
    },
})
