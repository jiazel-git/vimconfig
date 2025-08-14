return {
    -- mason
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "html-lsp",
                "pyright",
                "stylua",
                "gopls",
                "prettier",
            },
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },

        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },

    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            { "MysticalDevil/inlay-hints.nvim", event = "LspAttach" },
        },

        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = function(diagnostic)
                        local severity_name = ({
                            [vim.diagnostic.severity.ERROR] = "ERROR",
                            [vim.diagnostic.severity.WARN] = "WARN",
                            [vim.diagnostic.severity.INFO] = "INFO",
                            [vim.diagnostic.severity.HINT] = "HINT",
                        })[diagnostic.severity]
                        local icons = {
                            ERROR = "✘",
                            WARN = "▲",
                            INFO = "⚑",
                            HINT = "»",
                        }
                        print(diagnostic.severity)
                        return icons[severity_name] or "● "
                    end,
                },
                severity_sort = true,
                signs = {
                    text = {
                        ERROR = "✘",
                        WARN = "▲",
                        INFO = "⚑",
                        HINT = "»",
                    },
                },
            },
            inlay_hints = {
                enabled = true,
            },
            servers = {
                lua_ls = require("lsp_utils.lua_ls"),
                gopls = require("lsp_utils.gopls"),
                clangd = require("lsp_utils.clangd"),
            },
        },
        config = function(_, opts)
            require("inlay-hints").setup()
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local servers = opts.servers
            local has_blink, blink = pcall(require, "blink.cmp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_blink and blink.get_lsp_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})
                require("lspconfig")[server].setup(server_opts)
            end

            for server, _ in pairs(servers) do
                setup(server)
            end
        end,
    },
}
