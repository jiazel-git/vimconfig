-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "

-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- cursor

local function set_cursorline_underline()
    vim.api.nvim_set_hl(0, "CursorLine", {
        underline = true,
        sp = "#ffffff", -- 下划线颜色
        bg = nil,
        fg = nil,
    })
end

vim.opt.cursorline = true
set_cursorline_underline()

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        vim.opt_local.cursorline = true
        set_cursorline_underline()
    end,
})

-- Tab
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 15
vim.sidesscrolloff = 10
vim.opt.startofline = false

vim.opt.conceallevel = 2

vim.wo.wrap = false

vim.o.winborder = "rounded"

-- 启用bufferline的event
vim.o.mousemoveevent = true

-- no swap file
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

-- 启用窗口标题
vim.o.title = true

-- 自定义标题格式：显示文件名 + nvim
vim.o.titlestring = "%t - nvim"
