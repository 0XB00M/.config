
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { 
		"lua_ls",
		"bashls",
	},
	automatic_installation = true,
})



