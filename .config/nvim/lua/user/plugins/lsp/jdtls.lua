local M = {}

function M.setup(capabilities)
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = JoinPath(vim.fn.stdpath("data"), "jdtls-workspace", project_name)
  local packages_dir = JoinPath(vim.fn.stdpath("data"), "mason", "packages", "jdtls")
  local os_config = "linux"
  local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

      "java",

      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-javaagent:" .. JoinPath(packages_dir, "lombok.jar"),
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",

      "-jar",
      vim.fn.glob(JoinPath(packages_dir, "plugins", "org.eclipse.equinox.launcher_*.jar")),

      "-configuration",
      JoinPath(packages_dir, "config_" .. os_config),

      "-data",
      workspace_dir,
    },
    capabilities = capabilities,
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", }),

    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        configuration = {
          updateBuildConfiguration = "interactive",
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = false,
        },
        references = {
          includeDecompiledSources = true,
        },
      },
      signatureHelp = { enabled = true },
      -- completion = {
      --   favoriteStaticMembers = {
      --     "org.hamcrest.MatcherAssert.assertThat",
      --     "org.hamcrest.Matchers.*",
      --     "org.hamcrest.CoreMatchers.*",
      --     "org.junit.jupiter.api.Assertions.*",
      --     "java.util.Objects.requireNonNull",
      --     "java.util.Objects.requireNonNullElse",
      --     "org.mockito.Mockito.*",
      --   },
      -- },
      -- contentProvider = { preferred = "fernflower" },
      extendedClientCapabilities = extendedClientCapabilities,
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      -- codeGeneration = {
      --   toString = {
      --     template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      --   },
      --   useBlocks = true,
      -- },
    },
    flags = {
      allow_incremental_sync = true,
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
      bundles = {},
    },
  }

  require("jdtls").start_or_attach(config)
end

return M
