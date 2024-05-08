local jdtls = require "jdtls"
local conf = require("nvconfig").ui.lsp
local cmp_nvim_lsp = require "cmp_nvim_lsp"

local map = vim.keymap.set
local jdtls_path = vim.fn.stdpath "data" .. "/mason/packages/eclipse-jdt-ls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)

local java_home = os.getenv "LSP_JAVA_HOME" or ""
local function get_config_dir()
  if vim.fn.has "linux" == 1 then
    return "config_linux"
  elseif vim.fn.has "mac" == 1 then
    return "config_mac"
  else
    return "config_win"
  end
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  capabilities = capabilities,
  cmd = {
    vim.fs.normalize(java_home .. "/bin/java"),
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    vim.fs.normalize("-javaagent:" .. jdtls_path .. "/lombok.jar"),
    -- vim.fs.normalize("-Xbootclasspath/a:" .. jdtls_path .. "/lombok.jar"),
    "-jar",
    launcher_jar,
    "-configuration",
    vim.fs.normalize(jdtls_path .. "/" .. get_config_dir()),
    "-data",
    vim.fn.expand "~/.cache/jdtls-workspace/" .. workspace_dir,
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "pom.xml", ".classpath", ".git", "mvnw", "gradlew" }, { upward = true })[1]),
  init_options = { extendedClientCapabilities = jdtls.extendedClientCapabilities },
  on_attach = function(client, bufnr)
    local function opts(desc)
      return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    map("n", "<A-O>", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts "Organize imports")
    map("n", "<A-L>", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts "Extract variable")
    map("v", "<A-L>", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts "Extract variable")
    map("n", "<A-C>", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts "Extract constant")
    map("v", "<A-C>", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts "Extract constant")
    map("v", "<A-M>", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts "Extract method")

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gh", vim.lsp.buf.hover, opts "hover information")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    map("n", "gt", vim.lsp.buf.type_definition, opts "Go to type definition")

    map("n", "<A-r>", function()
      require "nvchad.lsp.renamer"()
    end, opts "NvRenamer")

    map({ "n", "v", "i" }, "<A-'>", vim.lsp.buf.code_action, opts "Code action")
    -- map({ "n", "v","i" }, "<A-.>", "<cmd>Lspsaga code_action<CR>", opts "Code action")
    -- map("n", "gr", vim.lsp.buf.references, opts "Show references")
    map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opts "Show references")

    -- setup signature popup
    if conf.signature and client.server_capabilities.signatureHelpProvider then
      require("nvchad.lsp.signature").setup(client, bufnr)
    end
  end,
  -- more config see https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      home = os.getenv "JAVA_HOME" or "",
      project = {
        referencedLibraries = {},
      },
      references = {
        includeDecompiledSources = true,
      },
      eclipse = {
        downloadSources = false,
      },
      maven = {
        downloadSources = false,
      },
      errors = {
        incompleteClasspath = {
          severity = "warning",
        },
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        maven = {
          userSettings = nil,
        },
      },
      trace = {
        server = "verbose",
      },
      import = {
        gradle = {
          enabled = true,
        },
        maven = {
          enabled = true,
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**",
        },
      },
      referencesCodeLens = {
        enabled = false,
      },
      signatureHelp = {
        enabled = false,
      },
      implementationsCodeLens = {
        enabled = false,
      },
      format = {
        enabled = true,
      },
      saveActions = {
        organizeImports = false,
      },
      contentProvider = {
        preferred = "fernflower",
      },
      autobuild = {
        enabled = false,
      },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
    },
  },
}
jdtls.start_or_attach(config)
