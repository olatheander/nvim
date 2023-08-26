local lualine = require("lualine")
local navic = require("nvim-navic")

local function pwd()
    return "󰉋 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

lualine.setup({
    options = {
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_c = {
            { "filename" },
            { navic.get_location, cond = navic.is_available },
            { "g:metals_status" }
        },
        lualine_x = { "encoding", "fileformat", "filetype", pwd },
    },
})
