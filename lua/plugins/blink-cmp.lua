return {
    -- blink.cmp
    {
        'saghen/blink.cmp',
         -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
               preset = 'none',
               ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
               ['<C-e>'] = { 'hide', 'fallback' },
               ['<CR>'] = { 'accept', 'fallback' },
               ['<Tab>'] = { 'snippet_forward', 'fallback' },
               ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
               ['<Up>'] = { 'select_prev', 'fallback' },
               ['<Down>'] = { 'select_next', 'fallback' },
               ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
               ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
               ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
               ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
               ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },

            completion = {
                keyword = {
                    range = 'prefix',
                },

                trigger = {
                    prefetch_on_insert = true,
                    show_in_snippet = true,
                    show_on_keyword = true,
                    show_on_trigger_character = true,
                    show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
                    show_on_accept_on_trigger_character = true,
                    show_on_insert_on_trigger_character = true,
                    show_on_x_blocked_trigger_characters = { "'", '"', '(' },
                },

                list = {
                    max_items = 200,
                    selection = {
                      preselect = true,
                      auto_insert = true,
                    },
                    cycle = {
                      from_bottom = true,
                      from_top = true,
                    },
                },

                accept = {
                    dot_repeat = true,
                    create_undo_point = true,
                    resolve_timeout_ms = 100,
                    auto_brackets = {
                      enabled = true,
                      default_brackets = { '(', ')' },
                      override_brackets_for_filetypes = {},
                      kind_resolution = {
                        enabled = true,
                        blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue' },
                      },
                      semantic_token_resolution = {
                        enabled = true,
                        blocked_filetypes = { 'java' },
                        timeout_ms = 400,
                      },
                    },
                },

                menu = {
                    enabled = true,
                    min_width = 15,
                    max_height = 10,
                    border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+
                    winblend = 65,
                    winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
                    scrolloff = 2,
                    scrollbar = true,
                    direction_priority = { 's', 'n' },

                    auto_show = true,

                    cmdline_position = function()
                      if vim.g.ui_cmdline_pos ~= nil then
                        local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                        return { pos[1] - 1, pos[2] }
                      end
                      local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                      return { vim.o.lines - height, 0 }
                    end,

                    draw = {
                        align_to = 'label', -- or 'none' to disable, or 'cursor' to align to the cursor
                        padding = 1,
                        gap = 1,
                        cursorline_priority = 10000,
                        treesitter = {},

                        columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },

                        components = {
                          kind_icon = {
                            ellipsis = false,
                            text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                            highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
                          },

                          kind = {
                            ellipsis = false,
                            width = { fill = true },
                            text = function(ctx) return ctx.kind end,
                            highlight = function(ctx) return ctx.kind_hl end,
                          },

                          label = {
                            width = { fill = true, max = 60 },
                            text = function(ctx) return ctx.label .. ctx.label_detail end,
                            highlight = function(ctx)
                              local highlights = {
                                { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                              }
                              if ctx.label_detail then
                                table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
                              end

                              for _, idx in ipairs(ctx.label_matched_indices) do
                                table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                              end

                              return highlights
                            end,
                          },

                          label_description = {
                            width = { max = 30 },
                            text = function(ctx) return ctx.label_description end,
                            highlight = 'BlinkCmpLabelDescription',
                          },

                          source_name = {
                            width = { max = 30 },
                            text = function(ctx) return ctx.source_name end,
                            highlight = 'BlinkCmpSource',
                          },

                          source_id = {
                            width = { max = 30 },
                            text = function(ctx) return ctx.source_id end,
                            highlight = 'BlinkCmpSource',
                          },
                        },
                    },
                },

                documentation = {
                    auto_show = false,
                    auto_show_delay_ms = 500,
                    update_delay_ms = 50,
                    treesitter_highlighting = true,
                    draw = function(opts) opts.default_implementation() end,
                    window = {
                      min_width = 10,
                      max_width = 80,
                      max_height = 20,
                      border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
                      winblend = 0,
                      winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                      scrollbar = true,
                      direction_priority = {
                        menu_north = { 'e', 'w', 'n', 's' },
                        menu_south = { 'e', 'w', 's', 'n' },
                      },
                    },
                },

                ghost_text = {
                      enabled = false,
                      show_with_selection = true,
                      show_without_selection = false,
                      show_with_menu = true,
                      show_without_menu = true,
                },
            },

            signature = {
              enabled = false,
              trigger = {
                enabled = true,
                show_on_keyword = false,
                blocked_trigger_characters = {},
                blocked_retrigger_characters = {},
                show_on_trigger_character = true,
                show_on_insert = false,
                show_on_insert_on_trigger_character = true,
              },
              window = {
                min_width = 1,
                max_width = 100,
                max_height = 10,
                border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
                winblend = 0,
                winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
                scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
                direction_priority = { 'n', 's' },
                treesitter_highlighting = true,
                show_documentation = true,
              },
            },

            fuzzy = {
              implementation = 'prefer_rust_with_warning',
              max_typos = function(keyword) return math.floor(#keyword / 4) end,

              use_frecency = true,

              use_proximity = true,

              use_unsafe_no_lock = false,

              sorts = {
                'score',
                'sort_text',
              },
          
              prebuilt_binaries = {
                download = true,
            
                ignore_version_mismatch = false,
            
                force_version = nil,
                force_system_triple = nil,
                extra_curl_args = {},
                proxy = {
                    from_env = true,
                    url = nil,
                },
              },
            },

            source = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                per_filetype = {
                },
                transform_items = function(_, items) return items end,
                min_keyword_length = 0,

                providers = {
                    lsp = {
                      name = 'LSP',
                      module = 'blink.cmp.sources.lsp',
                      fallbacks = { 'buffer' },
                      transform_items = function(_, items)
                        return vim.tbl_filter(
                          function(item) return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text end,
                          items
                        )
                      end,
                      opts = { tailwind_color_icon = '██' },
                      name = nil, -- Defaults to the id ("lsp" in this case) capitalized when not set
                      enabled = true, -- Whether or not to enable the provider
                      async = false, -- Whether we should show the completions before this provider returns, without waiting for it
                      timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
                      transform_items = nil, -- Function to transform the items before they're returned
                      should_show_items = true, -- Whether or not to show the items
                      max_items = nil, -- Maximum number of items to display in the menu
                      min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
                      fallbacks = {},
                      score_offset = 0, -- Boost/penalize the score of the items
                      override = nil, -- Override the source's functions
                    },
                    path = {
                      module = 'blink.cmp.sources.path',
                      score_offset = 3,
                      fallbacks = { 'buffer' },
                      opts = {
                        trailing_slash = true,
                        label_trailing_slash = true,
                        get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
                        show_hidden_files_by_default = false,
                        -- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
                        ignore_root_slash = false,
                      }
                    },
                    buffer = {
                      module = 'blink.cmp.sources.buffer',
                      score_offset = -3,
                      opts = {
                        -- default to all visible buffers
                        get_bufnrs = function()
                          return vim
                            .iter(vim.api.nvim_list_wins())
                            :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                            :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                            :totable()
                        end,
                        -- buffers when searching with `/` or `?`
                        get_search_bufnrs = function() return { vim.api.nvim_get_current_buf() } end,
                      }
                    },
                    cmdline = {
                      module = 'blink.cmp.sources.cmdline',
                      -- Disable shell commands on windows, since they cause neovim to hang
                      enabled = function()
                        return vim.fn.has('win32') == 0
                          or vim.fn.getcmdtype() ~= ':'
                          or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                      end,
                    },
                    omni = {
                      module = 'blink.cmp.sources.complete_func',
                      enabled = function() return vim.bo.omnifunc ~= 'v:lua.vim.lsp.omnifunc' end,
                      ---@type blink.cmp.CompleteFuncOpts
                      opts = {
                          complete_func = function() return vim.bo.omnifunc end,
                      },
                    },
                },
            },
            
            appearance = {
                  highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
                  use_nvim_cmp_as_default = false,
                  nerd_font_variant = 'mono',
                  kind_icons = {
                    Text = '󰉿',
                    Method = '󰊕',
                    Function = '󰊕',
                    Constructor = '󰒓',
                
                    Field = '󰜢',
                    Variable = '󰆦',
                    Property = '󰖷',
                
                    Class = '󱡠',
                    Interface = '󱡠',
                    Struct = '󱡠',
                    Module = '󰅩',
                
                    Unit = '󰪚',
                    Value = '󰦨',
                    Enum = '󰦨',
                    EnumMember = '󰦨',
                
                    Keyword = '󰻾',
                    Constant = '󰏿',
                
                    Snippet = '󱄽',
                    Color = '󰏘',
                    File = '󰈔',
                    Reference = '󰬲',
                    Folder = '󰉋',
                    Event = '󱐋',
                    Operator = '󰪚',
                    TypeParameter = '󰬛',
                },
            },
        },
        opts_extend = { "sources.default" }
    }
}
