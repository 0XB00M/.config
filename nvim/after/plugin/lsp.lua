require("mason").setup()

-- ============================================
-- ADD THESE DIAGNOSTIC CONFIGURATIONS
-- ============================================

-- Configure how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = true,      -- Show errors inline on the right
  signs = true,             -- Show signs in the sign column (left side)
  underline = true,         -- Underline errors
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true,     -- Sort by severity
})

-- Enable sign column (this shows the icons on the left)
vim.opt.signcolumn = "yes"

-- Define diagnostic signs (icons in the left gutter)
local signs = { 
  Error = "✘ ", 
  Warn = "▲ ", 
  Hint = "⚑ ", 
  Info = "» " 
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ============================================
-- YOUR EXISTING CONFIG CONTINUES BELOW
-- ============================================

-- Add completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- mason-lspconfig automatically sets up ALL installed language servers
require("mason-lspconfig").setup({
    -- Servers you want auto-installed
    ensure_installed = { "lua_ls", "pyright", "ts_ls", "bashls"},
    -- This automatically configures ALL servers installed via Mason
    automatic_installation = true,
    -- Default handler for all servers
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
                capabilities = capabilities,
            })
        end,
        -- Optional: Custom config for specific servers
        ["lua_ls"] = function()
            require('lspconfig').lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' } -- Recognize 'vim' global
                        }
                    }
                }
            })
        end,
    }
})

-- Add keybindings for LSP
vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                end, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
        end,
})
