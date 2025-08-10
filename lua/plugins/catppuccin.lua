return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            transparent_background = true,
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
                notify = true,
                rainbow_delimiters = true,
                blink_cmp = {
                    style = "bordered",
                },
                flash = true,
                markdown = true,
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
