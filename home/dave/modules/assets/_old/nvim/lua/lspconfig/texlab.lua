vim.g.tex_flavor = "latex"

local configs = require("nvchad.configs.lspconfig")

local blink_ok, blink = pcall(require, "blink.cmp")
local capabilities = blink_ok
  and blink.get_lsp_capabilities(configs.capabilities)
  or configs.capabilities

vim.lsp.config("texlab", {
  on_init = configs.on_init,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    configs.on_attach(client, bufnr)

    local ok, otter = pcall(require, "otter")
    if ok then
      pcall(otter.activate, { "lua" }, true, true, nil)
    end
  end,
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-lualatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = false,
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%c", "%p" },
      },
    },
  },
})

vim.lsp.enable("texlab")

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "tex" },
      },
    },
  },
})
