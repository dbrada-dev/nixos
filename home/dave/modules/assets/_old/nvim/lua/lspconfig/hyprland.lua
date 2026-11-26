local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

vim.lsp.config("lua_ls", {
  capabilities = nvlsp.capabilities,
  on_init = function(client)
    local buf_path = vim.api.nvim_buf_get_name(0)
    if buf_path:match("hypr") then
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
        workspace = {
          library = { "/usr/share/hypr/stubs" }
        }
      })
      client.rpc.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})

vim.lsp.enable("lua_ls")
