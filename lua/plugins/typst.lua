return {
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    lazy = false, -- or ft = 'typst'
    -- version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
  },
  -- {
  --   "kaarmu/typst.vim",
  --   ft = "typst",
  --   lazy = false,
  -- },
}
