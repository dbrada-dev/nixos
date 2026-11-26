require "nvchad.autocmds"

-- █░░ ▄▀█ ▀█▀ █▀▀ ▀▄▀
-- █▄▄ █▀█ ░█░ ██▄ █░█
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.tex",
  callback = function()
    if vim.b.vimtex ~= nil then
      vim.cmd("silent! VimtexCompileSS")
    end
  end,
  desc = "Auto-compile LaTeX on save",
})
