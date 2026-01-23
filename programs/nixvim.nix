{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      showmode = false;
      clipboard = "unnamedplus";

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      breakindent = true;

      whichwrap = "b,s,<,>,[,],h,l";

      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      list = true;
      listchars = "tab:» ,trail:·,nbsp:␣";
      inccommand = "split";
      cursorline = true;
      scrolloff = 10;
      conceallevel = 2;
      
      termguicolors = true;
      cmdheight=1;
      shortmess = "aoOFcWs";
    };

    colorschemes.gruvbox = {
      enable = true;
      settings = {
        background = "dark";
        transparent_mode = true;
      };
    };

    plugins = {
      web-devicons.enable = true;
      plenary.enable = true;
      sleuth.enable = true;
      comment.enable = true;
      gitsigns = {
        enable = true;
          settings = {
            signs = {
              add = { text = "+"; };
              change = { text = "~"; };
              delete = { text = "_"; };
              topdelete = { text = "‾"; };
              changedelete = { text = "~"; };
            };
          };
      };

      which-key.enable = true;
      leap.enable = true;
      nvim-autopairs.enable = true;

      indent-blankline = {
        enable = true;
        settings = {
           exclude = {
             filetypes = [ "help" "terminal" "dashboard" ];
           };
        };
      };

      lualine.enable = true;

      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          window = {
            position = "left";
            width = 20;
          };
          filesystem = {
            window = {
              mappings = {"\\"="close_window";};
            };
          };
        };
      };

      todo-comments.enable = true;
      wakatime.enable = true;

      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          open_mapping = "[[<c-\\>]]";
        };
      };

      treesitter = {
        enable = true;
        nixGrammars = true; 
        settings = {
          highlight.enable = true;
          indent.enable = true;
          ensure_installed = [
            "c" "cpp" "python" "lua" "nix" "markdown" "markdown_inline" "vim" "vimdoc" "bash" "json"
          ];
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>sf" = "find_files";
          "<leader>sg" = "live_grep";
          "<leader>sb" = "buffers";
          "<leader>sh" = "help_tags";
          "<leader>sw" = "grep_string";
          "<leader>sd" = "diagnostics";
          "<leader>sr" = "resume";
        };
      };

      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          lspBuf = {
            "gd" = "definition";
            "gr" = "references";
            "gI" = "implementation";
            "<leader>D" = "type_definition";
            "<leader>ds" = "document_symbol";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "K" = "hover";
            "gD" = "declaration";
          };
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>e" = "open_float";
            "<leader>q" = "setloclist";
          };
        };

        servers = {
          # Nix
          nil_ls = {
            enable = true;
            settings.formatting.command = [ "nixfmt" ];
          };

          # Python
          pylsp = {
            enable = true;
            settings.plugins = {
              pycodestyle.enabled = false;
              flake8.enabled = false;
              pylint.enabled = false;
              pyflakes.enabled = true;
              mccabe.enabled = false;
            };
          };

          # C/C++
          clangd.enable = true;
        };
      };

      lsp-signature.enable = true;
      fidget.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<Down>" = "cmp.mapping.select_next_item()";
            "<Up>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      luasnip.enable = true;
      
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters_by_ft = {
          };
        };
      };
    };

    keymaps = [
      { mode = "n"; key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; }
      { mode = "t"; key = "<Esc><Esc>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }
      
      { mode = "n"; key = "<S-Left>"; action = "<C-w>h"; options.desc = "Move focus to left"; }
      { mode = "n"; key = "<S-Right>"; action = "<C-w>l"; options.desc = "Move focus to right"; }
      { mode = "n"; key = "<S-Up>"; action = "<C-w>k"; options.desc = "Move focus to up"; }
      { mode = "n"; key = "<S-Down>"; action = "<C-w>j"; options.desc = "Move focus to down"; }

      { mode = "n"; key = "<A-k>"; action = "10k"; }
      { mode = "n"; key = "<A-j>"; action = "10j"; }
      { mode = "n"; key = "<A-Up>"; action = "10k"; }
      { mode = "n"; key = "<A-Down>"; action = "10j"; }

      { mode = "i"; key = "<C-v>"; action = "<Esc>pi"; }
      { mode = "n"; key = "\\"; action = "<cmd>Neotree reveal<CR>"; options.desc = "NeoTree reveal"; }

      { mode = ["n" "x" "o"]; key = "s"; action = "<Plug>(leap-forward)"; options.desc = "Leap forward"; }
      { mode = ["n" "x" "o"]; key = "S"; action = "<Plug>(leap-backward)"; options.desc = "Leap backward"; }
      { mode = ["n" "x" "o"]; key = "gs"; action = "<Plug>(leap-from-window)"; options.desc = "Leap from window"; }
    ];

    extraConfigLua = ''
      if vim.g.neovide then
        vim.o.guifont = "FiraCode Nerd Font:h12"
        vim.g.neovide_transparency = 0.9
        vim.g.transparency = 0.9
        vim.g.neovide_cursor_animate_in_insert_mode = false
        vim.g.neovide_position_animation_length = 0.15
        vim.g.neovide_scroll_animation_length = 0.3
        vim.g.neovide_refresh_rate = 30
        vim.g.neovide_refresh_rate_idle = 5
        vim.g.neovide_input_ime = true
      end
      vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
        callback = function()
          vim.highlight.on_yank()
        end,
      })
    '';

    # extraPlugins = with pkgs.vimPlugins; [
    #   # fittencode-nvim 
    # ];
    
    extraPackages = with pkgs; [
      ripgrep
      fd
      isort
    ];
  };
}
