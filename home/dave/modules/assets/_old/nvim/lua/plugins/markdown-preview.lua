return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }

      vim.api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gl", ":Neogit<CR>", { noremap = true, silent = true })
    end,
    ft = { "markdown" },
  }
}
