return {
    -- blink.cmp
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            "rafamadriz/friendly-snippets",
            "xzbdmw/colorful-menu.nvim",
        },

        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "none",
                ["<C-space>"] = {
                    "show",
                    "show_documentation",
                    "hide_documentation",
                },
                ["<C-e>"] = { "hide", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                ["<C-n>"] = { "select_next", "fallback_to_mappings" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },

            completion = {
                documentation = {
                    auto_show = true,
                },
                keyword = {
                    range = "prefix",
                },
                ghost_text = {
                    enabled = true,
                },
                menu = {
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(
                                        ctx
                                    )
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(
                                        ctx
                                    )
                                end,
                            },
                        },
                    },
                },
            },

            signature = {
                enabled = true,
            },

            cmdline = {
                completion = {
                    menu = {
                        auto_show = true,
                    },
                },
            },

            documentation = {
                window = {
                    scrollbar = false,
                },
            },
        },
    },
}
