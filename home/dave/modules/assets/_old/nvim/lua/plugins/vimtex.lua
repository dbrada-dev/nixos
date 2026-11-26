return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_automatic = 0

      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-lualatex",
      }
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = "build",
        out_dir = "build",
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventCompileSuccess",
        callback = function()
          local filepath = vim.fn.expand("%:p:h")
          local filename = vim.fn.expand("%:t:r")

          local build_pdf = filepath .. "/build/" .. filename .. ".pdf"
          local root_pdf = filepath .. "/" .. filename .. ".pdf"

          if vim.fn.filereadable(build_pdf) == 1 then
            vim.fn.system(string.format('cp "%s" "%s"', build_pdf, root_pdf))
          end
        end,
      })
    end,
  },
}
