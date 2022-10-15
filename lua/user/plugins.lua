local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
--vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost plugins.lua source <afile> | PackerSync
--  augroup end
--]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
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

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("wbthomason/packer.nvim") -- Packer can manage itself
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }) -- Folding
  use({ "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } })
  use("kyazdani42/nvim-tree.lua")
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
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")
  use("honza/vim-snippets")
  use("saadparwaiz1/cmp_luasnip")
  use("b0o/SchemaStore.nvim")
  use("MattesGroeger/vim-bookmarks")
  use("ThePrimeagen/harpoon")
  use("ThePrimeagen/vim-be-good") -- In-vim game to practice editing speed.
  use("onsails/lspkind-nvim") -- vscode-like pictograms
  use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
  use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
  use("hrsh7th/nvim-cmp") -- Completion
  use("neovim/nvim-lspconfig") -- A collection of configurations for Neovim’s built-in LSP
  use("glepnir/lspsaga.nvim") -- LSP UIs
  use("ldelossa/litee.nvim")
  use("ldelossa/litee-calltree.nvim")
  use("ldelossa/litee-symboltree.nvim")
  use("ldelossa/litee-filetree.nvim")
  use("ldelossa/litee-bookmarks.nvim")
  use("williamboman/mason.nvim") -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters
  use("williamboman/mason-lspconfig.nvim") -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use({
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup({})
    end,
  })
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
  use("MunifTanjim/prettier.nvim") -- Prettier plugin for Neovim's built-in LSP client
  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  })
  use("nvim-treesitter/nvim-treesitter") -- Experimenal parser library
  use("nvim-treesitter/nvim-treesitter-context")
  use("nvim-telescope/telescope.nvim") -- A highly extendable fuzzy finder over lists
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("windwp/nvim-ts-autotag")
  use("norcalli/nvim-colorizer.lua")
  use("kyazdani42/nvim-web-devicons")
  use({
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({ hint_enable = true, hint_prefix = " " })
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
  use({
    "nvim-lualine/lualine.nvim", -- A blazing fast and easy to configure Neovim statusline written in Lua
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" }) -- A snazzy bufferline
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
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")

  -- Comment
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
  use("f-person/git-blame.nvim")
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
end)
