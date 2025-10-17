require("mason").setup()

-- Add completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- mason-lspconfig automatically sets up ALL installed language servers
require("mason-lspconfig").setup({
    -- Servers you want auto-installed
    ensure_installed = { "lua_ls", "pyright", "ts_ls" },
    
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
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
	end,
})
