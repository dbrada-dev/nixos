{ inputs, pkgs, ... }:

let
  mkNvPlugin = pkg: pkg.overrideAttrs (old: {
    dependencies = [ ];
    doCheck = false;
    src = pkgs.fetchgit {
      url = "https://github.com/${old.src.owner}/${old.src.repo}.git";
      inherit (old.src) rev;
      sha256 = old.src.outputHash;
    };
  });
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = { lib, ... }: {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    nixpkgs.useGlobalPackages = true;

    # EXTRA PLUGINS
    extraPlugins = with pkgs.vimPlugins; [
      (mkNvPlugin base46)
      (mkNvPlugin nvchad-ui)
      (mkNvPlugin nvchad)
      (mkNvPlugin nvzone-volt)
      (mkNvPlugin nvzone-menu)
      (mkNvPlugin nvzone-minty)
      vim-visual-multi
      sg-nvim
    ];

    extraPackages = with pkgs; [
      stylua
      prettier
    ];

    globals = {
      mapleader = " ";
      maplocalleader = ",";
      tex_flavor = "latex";
      mkdp_filetypes = [ "markdown" ];

      # Disable built-in plugins
      loaded_2html_plugin = 1;
      loaded_tohtml = 1;
      loaded_getscript = 1;
      loaded_getscriptPlugin = 1;
      loaded_gzip = 1;
      loaded_logipat = 1;
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
      loaded_netrwSettings = 1;
      loaded_netrwFileHandlers = 1;
      loaded_matchit = 1;
      loaded_tar = 1;
      loaded_tarPlugin = 1;
      loaded_rrhelper = 1;
      loaded_spellfile_plugin = 1;
      loaded_vimball = 1;
      loaded_vimballPlugin = 1;
      loaded_zip = 1;
      loaded_zipPlugin = 1;
      loaded_tutor = 1;
      loaded_rplugin = 1;
      loaded_synmenu = 1;
      loaded_optwin = 1;
      loaded_compiler = 1;
      loaded_bugreport = 1;
    };

    opts = {
      colorcolumn = "80";
      relativenumber = true;
      number = true;
      spell = false;
      spelllang = [ "en_us" "cs" ];
      shell = "fish";
    };

    plugins = {
      web-devicons = {
        enable = true;
        settings = {
          override = lib.nixvim.mkRaw "require('nvchad.icons.devicons')";
        };
      };
      nvim-tree.enable = true;
      gitsigns.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      which-key.enable = true;
      luasnip.enable = true;
      friendly-snippets = {
        enable = true;
        package = mkNvPlugin pkgs.vimPlugins.friendly-snippets;
      };

      telescope.enable = true;
      fzf-lua.enable = true;

      diffview.enable = true;
      neogit.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            css = [ "prettier" ];
            html = [ "prettier" ];
          };
        };
      };

      blink-cmp = {
        enable = true;
        settings = {
          snippets.preset = "luasnip";
          keymap = {
            preset = "default";
            "<CR>" = [ "accept" "fallback" ];
            "<Tab>" = [ "select_next" "snippet_forward" "fallback" ];
            "<S-Tab>" = [ "select_prev" "snippet_backward" "fallback" ];
          };
          completion = {
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
              window.border = "single";
            };
            menu = lib.nixvim.mkRaw "require('nvchad.blink').menu";
          };
          sources = {
            default = [ "lsp" "snippets" "buffer" "path" ];
            per_filetype = {
              tex = [ "lsp" "snippets" "buffer" "path" "omni" ];
              plaintex = [ "lsp" "snippets" "buffer" "path" "omni" ];
            };
          };
        };
      };

      markdown-preview = {
        enable = true;
        settings = {
          filetypes = [ "markdown" ];
        };
      };

      otter.enable = true;

      treesitter = {
        enable = true;
        highlight.enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          vim
          lua
          vimdoc
          html
          css
          tsx
          javascript
          rust
          vue
          svelte
          latex
          bibtex
          nix
        ];
      };

      ts-autotag = {
        enable = true;
        settings = {
          opts = {
            enable_close = true;
            enable_rename = true;
            enable_close_on_slash = false;
          };
        };
      };

      vim-be-good.enable = true;

      vimtex = {
        enable = true;
        texlivePackage = pkgs.texlive.withPackages (tl: [
          tl.scheme-full
        ]);
        settings = {
          view_method = "zathura";
          view_automatic = 0;
          compiler_method = "latexmk";
          compiler_latexmk_engines = {
            _ = "-lualatex";
          };
          compiler_latexmk = {
            aux_dir = "build";
            out_dir = "build";
            options = [
              "-verbose"
              "-file-line-error"
              "-synctex=1"
              "-interaction=nonstopmode"
            ];
          };
        };
      };

      # LSP CONFIGURATION
      lsp = {
        enable = true;
        servers = {
          html.enable = true;
          cssls.enable = true;
          clangd.enable = true;
          ts_ls.enable = true;
          jsonls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          eslint.enable = true;
          svelte.enable = true;
          tailwindcss.enable = true;
          kotlin_language_server.enable = true;
          pylsp.enable = true;
          nil_ls = {
            enable = true;
            settings.nil.formatting.command = [ "${pkgs.alejandra}/bin/alejandra" ];
          };

          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                diagnostics = {
                  globals = [ "vim" "tex" ];
                };
              };
            };
            extraOptions = {
              filetypes = [ "lua" ];
              on_init = lib.nixvim.mkRaw ''
                function(client)
                  local buf_path = vim.api.nvim_buf_get_name(0)
                  if buf_path:match("hypr") then
                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
                      workspace = {
                        library = { "/run/current-system/sw/share/hypr/stubs" },
                      },
                    })
                    client.rpc.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                  end
                end
              '';
            };
          };

          texlab = {
            enable = true;
            onAttach.function = ''
              local ok, otter = pcall(require, "otter")
              if ok then
                pcall(otter.activate, { "lua" }, true, true, nil)
              end
            '';
            settings = {
              texlab = {
                build = {
                  executable = "latexmk";
                  args = [ "-lualatex" "-interaction=nonstopmode" "-synctex=1" "%f" ];
                  onSave = false;
                };
                forwardSearch = {
                  executable = "zathura";
                  args = [ "--synctex-forward" "%l:1:%c" "%p" ];
                };
              };
            };
          };
        };
      };
    };

    # KEYMAPS
    keymaps = [
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "Keep selection after outdent";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "Keep selection after indent";
      }

      {
        mode = "n";
        key = ";";
        action = ":";
        options.desc = "CMD enter command mode";
      }
      {
        mode = "i";
        key = "jk";
        action = "<ESC>";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = lib.nixvim.mkRaw "vim.lsp.buf.code_action";
        options.desc = "LSP code action";
      }
      {
        mode = "n";
        key = "<leader>s";
        action = lib.nixvim.mkRaw ''
          function()
            vim.opt.spell = not vim.opt.spell:get()
            print("Spell check: " .. tostring(vim.opt.spell:get()))
          end
        '';
        options.desc = "Toggle spell check";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = lib.nixvim.mkRaw ''
          function()
            vim.opt.relativenumber = not vim.opt.relativenumber:get()
            vim.opt.number = not vim.opt.number:get()
          end
        '';
        options.desc = "Toggle relative line numbers";
      }

      {
        mode = "n";
        key = "<leader>mp";
        action = ":MarkdownPreview<CR>";
        options = { noremap = true; silent = true; };
      }
      {
        mode = "n";
        key = "<leader>ms";
        action = ":MarkdownPreviewStop<CR>";
        options = { noremap = true; silent = true; };
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = ":Neogit<CR>";
        options = { noremap = true; silent = true; };
      }

      {
        mode = "n";
        key = "<localleader>ll";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexCompile";
        options.desc = "VimtexCompile";
      }
      {
        mode = "n";
        key = "<localleader>lv";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexView";
        options.desc = "VimtexView";
      }
      {
        mode = "n";
        key = "<localleader>lc";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexCompileSS";
        options.desc = "VimtexCompileSS";
      }
      {
        mode = "n";
        key = "<localleader>le";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexErrors";
        options.desc = "VimtexErrors";
      }
      {
        mode = "n";
        key = "<localleader>lo";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexOutput";
        options.desc = "VimtexOutput";
      }
      {
        mode = "n";
        key = "<localleader>ls";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexStop";
        options.desc = "VimtexStop";
      }
      {
        mode = "n";
        key = "<localleader>lS";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexStopAll";
        options.desc = "VimtexStopAll";
      }
      {
        mode = "n";
        key = "<localleader>li";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexInfo";
        options.desc = "VimtexInfo";
      }
      {
        mode = "n";
        key = "<localleader>lT";
        action = lib.nixvim.mkRaw "vim.cmd.VimtexTocOpen";
        options.desc = "VimtexTocOpen";
      }
    ];

    # AUTOCMDS
    autoCmd = [
      {
        event = "BufWritePost";
        pattern = "*.tex";
        desc = "Auto-compile LaTeX on save";
        callback = lib.nixvim.mkRaw ''
          function()
            if vim.b.vimtex ~= nil then
              vim.cmd("silent! VimtexCompileSS")
            end
          end
        '';
      }

      {
        event = "FileType";
        pattern = "nix";
        callback = lib.nixvim.mkRaw ''
          function()
            local ok, otter = pcall(require, "otter")
            if ok then
              otter.deactivate()
            end
          end
        '';
      }

      {
        event = "FileType";
        pattern = "java";
        command = "setlocal tabstop=4 shiftwidth=4 expandtab";
      }

      {
        event = "BufDelete";
        callback = lib.nixvim.mkRaw ''
          function()
            local bufs = vim.t.bufs
            if bufs and #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" and not vim.g.nvdash_displayed then
              vim.cmd "Nvdash"
            end
          end
        '';
      }

      {
        event = "User";
        pattern = "VimtexEventCompileSuccess";
        callback = lib.nixvim.mkRaw ''
          function()
            if not vim.b.vimtex then return end
            
            local root = vim.b.vimtex.root
            local name = vim.fn.fnamemodify(vim.b.vimtex.tex, ":t:r")

            local build_pdf = root .. "/build/" .. name .. ".pdf"
            local root_pdf = root .. "/" .. name .. ".pdf"

            if vim.fn.filereadable(build_pdf) == 1 then
              vim.fn.system(string.format('cp "%s" "%s"', build_pdf, root_pdf))
              vim.notify("Copied " .. name .. ".pdf to root", vim.log.levels.INFO)
            end
          end
        '';
      }
    ];

    extraFiles."lua/chadrc.lua".text = ''
      ---@type ChadrcConfig
      local M = {}

      M.base46 = {
        theme = "radium",
        hl_override = {
          Comment = { italic = true },
          ["@comment"] = { italic = true },
        },
      }

      M.ui = {
        telescope = { style = "bordered" },
        statusline = {
          order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "cwd", "cursor" },
        },
      }

      M.nvdash = {
        load_on_startup = true,
        buttons = {
          { txt = "  Empty buffer", keys = "<leader>b", cmd = "Nvdash" },
          { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
          { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
          { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
          { txt = "  Neogit", keys = "<leader>gl", cmd = "Neogit" },
          { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
          {
            txt = function()
              local ok, lazy = pcall(require, "lazy")
              if ok then
                local stats = lazy.stats()
                local ms = math.floor(stats.startuptime) .. " ms"
                return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
              end
              return "  Managed by Nixvim"
            end,
            hl = "NvDashFooter",
            no_gap = true,
            content = "fit",
          },
          { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
        },
      }

      M.term = {
        float = {
          row = 0.2,
          col = 0.15,
          width = 0.7,
          height = 0.6,
          border = "rounded",
        },
      }

      return M
    '';

    # LUA BOOTSTRAP FOR NVCHAD
    extraConfigLuaPre = ''
      vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

      -- Generate base46 cache on first run if missing
      if not vim.uv.fs_stat(vim.g.base46_cache .. "defaults") then
        pcall(function()
          require("base46").load_all_highlights()
        end)
      end

      -- Load all compiled base46 highlights early so all UI components and plugins use them
      if vim.uv.fs_stat(vim.g.base46_cache) then
        for name, type in vim.fs.dir(vim.g.base46_cache) do
          if type == "file" and name ~= "colors" and name ~= "term" then
            pcall(dofile, vim.g.base46_cache .. name)
          end
        end
      end
    '';

    extraConfigLua = ''
      -- Initialize NvChad UI (statusline, tabufline, nvdash, etc.)
      pcall(require, "nvchad")

      -- Load NvChad defaults
      pcall(require, "nvchad.options")
      pcall(require, "nvchad.autocmds")
      pcall(function()
        require("nvchad.configs.lspconfig").defaults()
      end)
      pcall(require, "nvchad.configs.luasnip")

      vim.schedule(function()
        pcall(require, "nvchad.mappings")
      end)
    '';
  };
}
