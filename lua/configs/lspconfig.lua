-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "tsserver", "volar", "rust_analyzer", "vimls", "slint_lsp", "clangd" }

local npm_home = os.getenv "NPM_HOME" or ""
-- lsps with default config
for _, lsp in ipairs(servers) do
  local config = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
  if lsp == "volar" then
    config.init_options = {
      typescript = {
        tsdk = npm_home .. "/node_modules/typescript/lib",
      },
    }
    config.filetypes = {
      "typescript",
      "javascript",
      "vue",
    }
  end
  if lsp == "tsserver" then
    config.init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = npm_home .. "/node_modules/@vue/typescript-plugin",
          languages = { "javascript", "typescript", "vue" },
        },
      },
    }
    config.filetypes = {
      "javascript",
      "typescript",
      "vue",
    }
  end

  lspconfig[lsp].setup(config)
end
