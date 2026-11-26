require "nvchad.options"

vim.opt.colorcolumn = "80"
vim.wo.relativenumber = true
vim.wo.number = true

vim.opt.spell = false
vim.opt.spelllang = { "en_us", "cs" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  command = "setlocal tabstop=4 shiftwidth=4 expandtab",
})

vim.keymap.set("v", "<", "<gv", { desc = "Keep selection after outdent" })
vim.keymap.set("v", ">", ">gv", { desc = "Keep selection after indent" })

vim.opt.shell = "fish"

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})
