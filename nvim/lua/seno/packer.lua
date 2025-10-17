-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate"})
	use('navarasu/onedark.nvim')
	use('mbbill/undotree')
	use('neovim/nvim-lspconfig')
	use('mason-org/mason.nvim')
	use('mason-org/mason-lspconfig.nvim')
	use('feline-nvim/feline.nvim')
end)
