local keyset = vim.keymap.set
keyset("i", "<C-h>", "<Left>")
keyset("i", "<C-l>", "<Right>")
keyset("i", "<C-j>", "<Down>")
keyset("i", "<C-k>", "<Up>")
keyset("i", "jj", "<Esc>")

keyset("n", "<C-h>", "<C-w>h")
keyset("n", "<C-l>", "<C-w>l")
keyset("n", "<C-j>", "<C-w>j")
keyset("n", "<C-k>", "<C-w>k")
keyset("n", "<leader>w", ":w")
keyset("n", "<leader>q", ":q")
keyset("n", "<C-n>", ":nohl<CR>")

--keyset({"n","x"}, "<S-H>","^",{desc = "Start of line"})
--keyset({"n","x"}, "<S-L>","$",{desc = "End  of line"})
