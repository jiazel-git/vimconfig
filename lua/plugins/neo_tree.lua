return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
            "s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
            version = "2.*",
            config = function()
                require("window-picker").setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = {
                                "neo-tree",
                                "neo-tree-popup",
                                "notify",
                            },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                })
            end,
        },
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config
    opts = {
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        open_files_using_relative_paths = true,
        default_component_configs = {
            container = {
                enable_character_fade = true,
            },
            file_size = {
                enabled = false,
            },
            type = {
                enabled = false,
            },
        },
        filesystem = {
            follow_current_file = {
                enabled = true,
            },
        },
    },
    vim.keymap.set("n", "<leader>e", "<Cmd>Neotree reveal<CR>"),
}
