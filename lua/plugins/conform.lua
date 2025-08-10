return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    --lazy = true,
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            json = { "prettier" },
            css = { "prettier" },
        },

        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}
