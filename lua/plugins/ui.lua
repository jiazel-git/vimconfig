return {
    -- notice
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            poupmenu = {
                enable = true,
                backend = "cmp",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["com.entry.get_documentation"] = true,
                },
            },
        },
        keys = {
            {
                "<leader>sN",
                "<CMD>Notice pick<CR>",
                desc = "[Notice] pick history messages",
            },
            {
                "<leader>N",
                "<CMD>Notice<CR>",
                desc = "[Notice] Show history messages",
            },
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
            {
                filter = { event = "msg_show", kind = "search_count" },
                opts = { skip = true },
            },
            {
                filter = { event = "msg_show", kind = "" },
                opts = { skip = true },
            },
        },
    },

    -- lazydev
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
