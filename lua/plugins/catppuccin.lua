return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = function(colors)
            return {
                LineNr = { fg = colors.surface2 },
                Visual = { bg = colors.overlay0 },
                Search = { bg = colors.surface2 },
                Incsearch = { bg = colors.lavender },
                CurSearch = { bg = colors.lavender },
                MatchParen = {
                    bg = colors.lavender,
                    fg = colors.base,
                    bold = true,
                },
            }
        end,
        default_integrations = true,
        integrations = {
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
            barbar = true,
            mason = true,
            notice = true,
            notify = true,
            rainbow_delimiters = true,
            blink_cmp = {
                style = "bordered",
            },
            flash = true,
            markdown = true,
            neo_tree = true,
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },

        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
