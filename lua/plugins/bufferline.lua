return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
        {
            "<leader>bP",
            "<Cmd>BufferLineGroupClose ungrouped<CR>",
            desc = "Delete Non-Pinned Buffers",
        },
        {
            "<leader>br",
            "<Cmd>BufferLineCloseRight<CR>",
            desc = "Delete Buffers to the Right",
        },
        {
            "<leader>bl",
            "<Cmd>BufferLineCloseLeft<CR>",
            desc = "Delete Buffers to the Left",
        },
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
        { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
        options = {
            close_command = "bdelete %d",
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "snacks_layout_box",
                },
            },
            separator_style = "slant",
            hover = {
                enabled = true,
                delay = 200,
                reveal = { "close" },
            },
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd("BufAdd", {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end,
}
