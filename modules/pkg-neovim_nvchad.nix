{ pkgs, ... }:

let
  mkRaw = __raw: { inherit __raw; };
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
  programs.nixvim = {
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
    };

    plugins = {
      web-devicons = {
        enable = true;
        settings = {
          override = mkRaw "require('nvchad.icons.devicons')";
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
            menu = mkRaw "require('nvchad.blink').menu";
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

      treesitter = {
        enable = true;
        highlight.enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          lua
          nix
        ];
      };

      vim-be-good.enable = true;

      # LSP CONFIGURATION
      lsp = {
        enable = true;
        servers = {
          jsonls.enable = true;
          nil_ls = {
            enable = true;
            settings.nil.formatting.command = [ "${pkgs.alejandra}/bin/alejandra" ];
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
        action = mkRaw "vim.lsp.buf.code_action";
        options.desc = "LSP code action";
      }
      {
        mode = "n";
        key = "<leader>s";
        action = mkRaw ''
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
        action = mkRaw ''
          function()
            vim.opt.relativenumber = not vim.opt.relativenumber:get()
            vim.opt.number = not vim.opt.number:get()
          end
        '';
        options.desc = "Toggle relative line numbers";
      }

      {
        mode = "n";
        key = "<leader>gl";
        action = ":Neogit<CR>";
        options = { noremap = true; silent = true; };
      }
    ];

    # AUTOCMDS
    autoCmd = [
      {
        event = "BufDelete";
        callback = mkRaw ''
          function()
            local bufs = vim.t.bufs
            if bufs and #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" and not vim.g.nvdash_displayed then
              vim.cmd "Nvdash"
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
