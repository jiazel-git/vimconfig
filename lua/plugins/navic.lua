return {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
        highlight = true,
        lsp = {
            auto_attach = true,
            preference = {
                "clangd",
                "gopls",
                "pyright",
                "lua_ls",
                "tsserver",
                "rust_analyzer",
            },
        },
    },
    init = function()
        vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
}
