local whichkey = require("which-key")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, close_on_exit = true, direction = "float" })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

-- Create a custom DiffviewToggle cmd.
vim.api.nvim_create_user_command("DiffviewToggle", function(e)
    local view = require("diffview.lib").get_current_view()

    if view then
        vim.cmd("DiffviewClose")
    else
        vim.cmd("DiffviewOpen " .. e.args)
    end
end, { nargs = "*" })

local conf = {
    window = {
        border = "single",   -- none, single, double, shadow
        position = "bottom", -- bottom, top
    },
}
whichkey.setup(conf)

local opts = {
    mode = "n",     -- Normal mode
    prefix = "",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local keymap = {
    g = {
        name = "GoTo",
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "GoTo Definition" },
    }
}

local n_opts = {
    mode = "n",     -- Normal mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
    mode = "v",     -- Visual mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local n_keymap = {
    b = {
        name = "Buffer",
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
        f = { "<Cmd>BDelete! this<Cr>", "Force Close Buffer" },
        F = { "<Cmd>BWipeout all<Cr>", "Close All Buffer(s)" },
        D = { "<Cmd>BWipeout other<Cr>", "Close Other Buffer(s)" },
        p = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
        x = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
        m = { "<Cmd>JABSOpen<Cr>", "Menu" },
    },
    c = {
        name = "Code",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        b = {
            "<CMD>lua require('Comment.api').toggle.blockwise.current()<CR>",
            "Comment Block",
        },
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
        D = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Document Symbols" },
        E = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        f = { "<cmd>lua vim.lsp.buf.format {async = true}<cr>", "Format" },
        F = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostics" },
        g = { "<cmd>Neogen func<Cr>", "Func Doc" },
        G = { "<cmd>Neogen class<Cr>", "Class Doc" },
        h = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
        j = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Diagnostics prev" },
        k = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Diagnostics next" },
        K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hoover docs" },
        l = {
            "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>",
            "Comment Line",
        },
        o = { "<cmd>LSoutlineToggle<cr>", "Outline" },
        O = {
            name = "Litee Outline",
            b = { "<cmd>LTCreateBookmark<cr>", "Create bookmark" },
            d = { "<cmd>LTDeleteBookmark<cr>", "Delete bookmark" },
            f = { "<cmd>LTOpenFiletree<cr>", "File tree" },
            i = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "Incoming calls" },
            l = { "<cmd>LTListNotebooks<cr>", "List notebooks" },
            n = { "<cmd>LTOpenNotebook<cr>", "Open notebook" },
            N = { "<cmd>LTCreateNotebook<cr>", "Create notebook" },
            o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", "Outgoing calls" },
            s = { "<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Symbols" },
        },
        -- r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
        r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "References" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
        t = {
            name = "Trouble",
            d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
            t = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
            q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
            w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
        },
        T = { "<cmd>TodoTelescope<Cr>", "List TODOs" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Diagnostics Loc List" },
        w = { "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", "Workspace Symbols" },
        x = { "<cmd>LspRestart<Cr>", "LSP Restart" },
    },
    d = {
        name = "Debug",
        R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
        E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
        C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
        U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
        b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Start/Continue" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        l = { "<cmd>lua require('dap.ext.vscode').load_launchjs()<cr>", "Load launch.json" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    f = {
        name = "Find",
        b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
        d = {
            "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })<cr>",
            "Fuzzy Find in Buffer" },
        f = { "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", "Files" },
        g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep" },
        h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help Tags" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        p = { "<cmd>lua require('telescope.builtin').git_files()<cr>", "Git Files" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
    },
    g = {
        name = "Git",
        b = { "<cmd>GitBlameToggle<CR>", "Toogle Git Blame" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = { "<cmd>DiffviewToggle<cr>", "Diff View Toggle" },
        g = { "<cmd>diffget //2<cr>", "diffget left" },
        h = { "<cmd>diffget //3<cr>", "diffget right" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file(s)" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        S = { "<cmd>Git<cr>", "Git Status" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        x = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    },
    h = { "<cmd>split<cr>", "split" },
    m = {
        name = "Markdown",
        t = { "<cmd>MarkdownPreviewToggle<cr>", "Toogle Markdown Preview" },
    },
    n = {
        name = "Bookmark",
        a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
        c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
        b = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
        m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
        ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
        [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
        j = { "<cmd>silent BookmarkNext<cr>", "Bookmark Next" },
        s = { "<cmd>Telescope harpoon marks<cr>", "Harpoon Marks" },
        k = { "<cmd>silent BookmarkPrev<cr>", "Bookmark Prev" },
        S = { "<cmd>silent BookmarkShowAll<cr>", "Bookmark Show All" },
        x = { "<cmd>BookmarkClearAll<cr>", "Bookmark Clear All" },
        [";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
    },
    o = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Recently Opened" },
    p = {
        name = "Copilot",
        d = { "<cmd>Copilot disable<cr>", "Disable" },
        e = { "<cmd>Copilot enable<cr>", "Enable" },
        p = { "<cmd>Copilot panel<cr>", "Panel" },
        s = { "<cmd>Copilot status<cr>", "Status" },
        v = { "<cmd>Copilot version<cr>", "Version" },
    },
    r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "Show References" },
    u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
    v = { "<cmd>vsplit<cr>", "vsplit" },
    w = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
}

local v_keymap = {
    c = {
        name = "Code",
        l = {
            "<ESC><CMD>lua require('Comment.api').locked('comment.linewise')(vim.fn.visualmode())<CR>",
            "Comment Line",
        },
        L = {
            "<ESC><CMD>lua require('Comment.api').locked('uncomment.linewise')(vim.fn.visualmode())<CR>",
            "Uncomment Line",
        },
        b = {
            "<ESC><CMD>lua require('Comment.api').locked('comment.blockwise')(vim.fn.visualmode())<CR>",
            "Comment Block",
        },
        B = {
            "<ESC><CMD>lua require('Comment.api').locked('uncomment.blockwise')(vim.fn.visualmode())<CR>",
            "Uncomment Block",
        },
    },
    d = {
        name = "Debug",
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    },
}

-- File-type specific keymaps
local function ft_keymap()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
            vim.schedule(FtRunner)
        end,
    })

    function FtRunner()
        local bufnr = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        local fname = vim.fn.expand("%:p:t")
        local keymap_ft = {}   -- normal key map
        local keymap_ft_v = {} -- visual key map

        if ft == "python" then
            keymap_ft = {
                name = "Python",
                r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
                m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
            }
        elseif ft == "lua" then
            keymap_ft = {
                name = "Lua",
                r = { "<cmd>luafile %<cr>", "Run" },
            }
        elseif ft == "rust" then
            keymap_ft = {
                name = "Rust",
                r = { "<cmd>execute 'Cargo run' | startinsert<cr>", "Run" },
                D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
                h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
                R = { "<cmd>RustRunnables<cr>", "Runnables" },
            }
        elseif ft == "go" then
            keymap_ft = {
                name = "Go",
                r = { "<cmd>GoRun<cr>", "Run" },
            }
        elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
            keymap_ft = {
                name = "Typescript",
                F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
                i = { "<cmd>AddMissingImports<cr>", "Add Missing Imports" },
                l = { "<cmd>!eslint_d --fix %<cr>", "ESLint Fix" },
                o = { "<cmd>OrganizeImports<cr>", "Organize Imports" },
                p = { "<cmd>w | !npx prettier --write %<cr>", "Prettier" }, -- Save and Prettier
                r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
                u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
                R = { "<cmd>lua require('config.neotest').javascript_runner()<cr>", "Choose Test Runner" },
                -- s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
                -- t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
            }
        elseif ft == "java" then
            keymap_ft = {
                name = "Java",
                o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
                v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
                c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
                t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
                n = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Nearest Method" },
            }
            keymap_ft_v = {
                name = "Java",
                v = { "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
                c = { "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
                m = { "<esc><cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
            }
        end

        if fname == "package.json" then
            keymap_ft = {
                name = "Npm/Yarn",
                c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" },
                v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" },
            }
            -- keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
            -- keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
        end

        if fname == "Cargo.toml" then
            keymap_ft = {
                name = "Cargo",
                u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" },
            }
        end

        if next(keymap_ft) ~= nil then
            local k = { t = keymap_ft }
            local o = { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
            whichkey.register(k, o)
        end

        if next(keymap_ft_v) ~= nil then
            local k = { t = keymap_ft_v }
            local o = { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
            whichkey.register(k, o)
        end
    end
end

whichkey.register(keymap, opts)
whichkey.register(n_keymap, n_opts)
whichkey.register(v_keymap, v_opts)
ft_keymap()
