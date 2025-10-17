require("seno")

vim.opt.number = true
vim.opt.relativenumber = true

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }}}}})

