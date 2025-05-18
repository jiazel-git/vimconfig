return {
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            auto_install = true,
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },  
        },
        config = function (_,opts) 
          local configs = require("nvim-treesitter.configs")
          configs.setup(opts)
        end
    },

    -- lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
          options = {
            theme = "catppuccin",
            always_divide_middle = false;
            component_separators = '',
            section_separators = '',
            theme = {
              normal = { c = { fg = '#bbc2cf', bg = '#202328' } },
              inactive = { c = { fg = '#bbc2cf', bg = '#202328' } },
            },
          },
          sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
          },
          inactive_sections = {
            lualine_a = {}, lualine_b = {}, lualine_y = {}, lualine_z = {},
            lualine_c = {}, lualine_x = {},
          },
        },
        config = function(_, opts)
          local colors = {
            bg       = '#202328',
            fg       = '#bbc2cf',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            darkblue = '#081633',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            magenta  = '#c678dd',
            blue     = '#51afef',
            red      = '#ec5f67',
          }

          local conditions = {
            buffer_not_empty = function()
              return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
              return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
              local filepath = vim.fn.expand('%:p:h')
              local gitdir = vim.fn.finddir('.git', filepath .. ';')
              return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
          }

          local function ins_left(component)
            table.insert(opts.sections.lualine_c, component)
          end

          local function ins_right(component)
            table.insert(opts.sections.lualine_x, component)
          end

          -- 在这里插入你的所有lualine组件配置...
          -- 示例：
          ins_left {
            function() return '▊' end,
            color = { fg = colors.blue },
            padding = { left = 0, right = 1 },
          }
          ins_left {
            -- mode component
            function()
              return ''
            end,
            color = function()
              -- auto change color according to neovims mode
              local mode_color = {
                n = colors.red,
                i = colors.green,
                v = colors.blue,
                [''] = colors.blue,
                V = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.red,
                t = colors.red,
              }
              return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = { right = 1 },
          }
          ins_left {
           -- filesize component
           'filesize',
           cond = conditions.buffer_not_empty,
         }

          ins_left {
            'filename',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = 'bold' },
          }

          ins_left { 'location' }

          ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

          ins_left {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.cyan },
            },
          }

          -- Insert mid section. You can make any number of sections in neovim :)
          -- for lualine it's any number greater then 2
          ins_left {
            function()
              return '%='
            end,
          }

          ins_left {
            -- Lsp server name .
            function()
              local msg = 'No Active Lsp'
              local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            icon = ' LSP:',
            color = { fg = '#ffffff', gui = 'bold' },
          }

          -- Add components to right sections
          ins_right {
            'o:encoding', -- option component same as &encoding in viml
            fmt = string.lower, -- I'm not sure why it's upper case either ;)
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
          }

          ins_right {
            'fileformat',
            fmt = string.lower,
            icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
            color = { fg = colors.green, gui = 'bold' },
          }

          ins_right {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
          }

          ins_right {
            'diff',
            -- Is it me or the symbol for modified us really weird
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.orange },
              removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
          }

          ins_right {
            function()
              return '▊'
            end,
            color = { fg = colors.blue },
            padding = { left = 1 },
          }
          require('lualine').setup(opts)
        end,
    },

    -- barbar
    {
      'romgrk/barbar.nvim',
      dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
      },
      init = function() vim.g.barbar_auto_setup = false end,
      event = {"VeryLazy"},
      opts = {
        animation = false,
        auto_hide = 1,
        sidebar_filetypes = {
          NvimTree = true,
        }
      },
      keys = {
        {"<A-<>","<CMD>BufferMovePrevious<CR>", mode = {"n"},desc = "[Buffer] move buffer left"},
        {"<A->>","<CMD>BufferMoveNext<CR>", mode = {"n"},desc = "[Buffer] move buffer right"},
        {"<A-1>","<CMD>BufferGoto 1<CR>", mode = {"n"},desc = "[Buffer] goto buffer 1"},
        {"<A-2>","<CMD>BufferGoto 2<CR>", mode = {"n"},desc = "[Buffer] goto buffer 2"},
        {"<A-3>","<CMD>BufferGoto 3<CR>", mode = {"n"},desc = "[Buffer] goto buffer 3"},
        {"<A-4>","<CMD>BufferGoto 4<CR>", mode = {"n"},desc = "[Buffer] goto buffer 4"},
        {"<A-5>","<CMD>BufferGoto 5<CR>", mode = {"n"},desc = "[Buffer] goto buffer 5"},
        {"<A-6>","<CMD>BufferGoto 6<CR>", mode = {"n"},desc = "[Buffer] goto buffer 6"},
        {"<A-7>","<CMD>BufferGoto 7<CR>", mode = {"n"},desc = "[Buffer] goto buffer 7"},
        {"<A-8>","<CMD>BufferGoto 8<CR>", mode = {"n"},desc = "[Buffer] goto buffer 8"},
        {"<A-9>","<CMD>BufferGoto 9<CR>", mode = {"n"},desc = "[Buffer] goto buffer 9"},
        {"<A-h>","<CMD>BufferPrevious<CR>", mode = {"n"},desc = "[Buffer] previous buffer"},
        {"<A-l>","<CMD>BufferNext<CR>", mode = {"n"},desc = "[Buffer] next buffer"},
        {"<A-w>","<CMD>BufferClose<CR>", mode = {"n"},desc = "[Buffer] close buffer"},
      }
    },

    -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    renderer = {
      indent_marks = {
        enable = true,
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {"<leader>e","<CMD>NvimTreeToggle<CR>", mode = {"n"},desc = "[NvimTree] Toggle NvimTree"}
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- rainbow-delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    submodules = false,
    main = "rainbow-delimiters.setup",
    opts = {}
  },

  -- notice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      poupmenu = {
        enable = false,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["com.entry.get_documentation"] = true,
        },
      }
    },
    keys = {
      {"<leader>sN","<CMD>Notice pick<CR>", desc = "[Notice] pick history messages"},
      {"<leader>N","<CMD>Notice<CR>", desc = "[Notice] Show history messages"},
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    routes = {
      {filter = {event = "msg_show",kind = "search_count",},opts = {skip = true},},
      {filter = {event = "msg_show",kind = "",},opts = {skip = true},},
    },
  },

  -- lazydev
   {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      win = {
        title = false,
        width = 0.5,
      },
      spec = {
        {"<leader>cc", group = "<CodeCompanion>",icon = ""},
        {"<leader>s", group = "<Snacks>"},
        {"<leader>t", group = "<Snacks>Toggle"},

      },
      expand = function(node)
        return not node.desc
      end,
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "[Which-Key] Buffer Local Keymaps",
      },
    },
  },
}
