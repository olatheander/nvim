-- local lsp_format = require("lsp-format")

-- Installation location of jdtls by nvim-lsp-installer
-- local JDTLS_LOCATION = "/usr/share/java/jdtls"
-- local JDTLS_LOCATION = vim.fn.stdpath("data") .. "/lsp_servers/jdtls"
-- local MASON = vim.fn.stdpath("data") .. "/mason"
--
-- Debugger installation location
-- local DEBUGGER_LOCATION = "~/Git"

-- Only for Linux and Mac
-- local SYSTEM = "linux"
-- if vim.fn.has("mac") == 1 then
-- SYSTEM = "mac"
-- end

local function get_jdtls()
    local mason_registry = require "mason-registry"
    local jdtls = mason_registry.get_package "jdtls"
    local jdtls_path = jdtls:get_install_path()
    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local SYSTEM = "linux"
    if vim.fn.has "mac" == 1 then
        SYSTEM = "mac"
    end
    local config = jdtls_path .. "/config_" .. SYSTEM
    local lombok = jdtls_path .. "/lombok.jar"
    return launcher, config, lombok
end

local function get_bundles()
    local mason_registry = require "mason-registry"
    local java_debug = mason_registry.get_package "java-debug-adapter"
    local java_test = mason_registry.get_package "java-test"
    local java_debug_path = java_debug:get_install_path()
    local java_test_path = java_test:get_install_path()
    local bundles = {}
    vim.list_extend(bundles,
        vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n"))
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))
    return bundles
end

local function get_workspace()
    local home = os.getenv "HOME"
    local workspace_path = home .. "/.local/share/nde/jdtls-workspace/"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = workspace_path .. project_name
    return workspace_dir
end

local launcher, os_config, lombok = get_jdtls()
-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. project_name
local workspace_dir = get_workspace()
local bundles = get_bundles()

-- local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
-- local root_dir = require("jdtls.setup").find_root(root_markers)
-- if root_dir == "" then
--     return
-- end

local jdtls = require("jdtls")
local jdtls_dap = require("jdtls.dap")
local jdtls_setup = require("jdtls.setup")
local navic = require("nvim-navic")

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- format on save
    -- if client.server_capabilities.documentFormattingProvider then
    -- 	vim.api.nvim_create_autocmd("BufWritePre", {
    -- 		group = vim.api.nvim_create_augroup("Format", { clear = true }),
    -- 		buffer = bufnr,
    -- 		callback = function()
    -- 			vim.lsp.buf.formatting_seq_sync()
    -- 		end,
    -- 	})
    -- end

    vim.lsp.codelens.refresh()
    navic.attach(client, bufnr)
    -- lsp_format.on_attach(client)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    jdtls_dap.setup_dap_main_class_configs()
    jdtls_setup.add_commands()

    --Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Debugging
-- local bundles = {
--     vim.fn.glob(
--         DEBUGGER_LOCATION .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
--     ),
-- }
-- vim.list_extend(bundles, vim.split(vim.fn.glob(DEBUGGER_LOCATION .. "/vscode-java-test/server/*.jar"), "\n"))

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. lombok,
        "-jar",
        launcher,
        -- vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        -- vim.fn.glob(MASON .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        -- "/home/olathe/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
        "-configuration",
        os_config,
        -- "/home/olathe/.config/java/jdtls/config_linux",
        -- JDTLS_LOCATION .. "/config_" .. SYSTEM,
        -- MASON .. "/packages/jdtls/config_" .. SYSTEM,
        "-data",
        workspace_dir,
    },

    on_attach = on_attach,
    -- capabilities = require("config.lsp").capabilities,
    -- capabilities = capabilities,
    root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                -- And search for `interface RuntimeOption`
                -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = "/usr/lib/jvm/java-11-openjdk/",
                    },
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk/",
                    },
                    {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/java-21-openjdk/",
                    },
                },
            },
            maven = {
                downloadSources = true,
                updateSnapshots = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all", -- literals, all, none
                },
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        contentProvider = { preferred = "fernflower" },
        saveActions = {
            organizeImports = true,
        },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
    on_init = function(client)
        if client.config.settings then
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
    end,
    -- flags = {
    --   allow_incremental_sync = true,
    -- },
    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = bundles,
    },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
