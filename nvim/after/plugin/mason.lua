require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { 
		"lua_ls",
		"shellcheck",
		"shfmt",
		"bash-language-server"
	},
	automatic_installation = true
})



