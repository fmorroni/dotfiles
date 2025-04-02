return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "JavaSE-17",
                      path = "/usr/lib/jvm/java-17-openjdk/",
                    },
                    {
                      name = "JavaSE-21",
                      path = "/usr/lib/jvm/java-21-openjdk/",
                      default = true,
                    }
                  }
                }
              }
            }
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({
              jdk = {
                auto_install = false,
              },
            })
          end,
        },
      },
    },
  },
}
