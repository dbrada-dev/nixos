require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "clangd",
  "ts_ls",
  "jsonls",
  "rust_analyzer",
  "eslint",
  "svelte",
  "tailwindcss",
  "texlab",
  "kotlin_language_server",
  "pylsp",
}
vim.lsp.enable(servers)
