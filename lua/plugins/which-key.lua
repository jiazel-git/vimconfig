return {

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      win = {
        width = 0.5,
        title_pos = "center",
        title = "All Keymaps", -- 自定义标题
      },
      spec = {
        {"<leader>cc", group = "<CodeCompanion>",icon = ""},
        {"<leader>s", group = "<Snacks>"},
        {"<leader>t", group = "<Snacks>Toggle"},

      },
      expand = function(node)
        return not node.desc
      end,
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "[Which-Key] Buffer Local Keymaps",
      },
    },
  },
}
