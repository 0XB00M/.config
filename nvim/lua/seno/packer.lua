-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)

	-- theme
		use {'datsfilipe/vesper.nvim'}
	use('Yazeed1s/minimal.nvim')

	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate"})
	use('mbbill/undotree')

	-- LSP
	use('neovim/nvim-lspconfig')
	use('mason-org/mason.nvim')
	use('mason-org/mason-lspconfig.nvim')

	-- Autocompletion
	use('hrsh7th/nvim-cmp')         -- Completion plugin
	use('hrsh7th/cmp-nvim-lsp')     -- LSP completion source
	use('hrsh7th/cmp-buffer')       -- Buffer completion source
	use('hrsh7th/cmp-path')         -- Path completion source
	use('hrsh7th/cmp-cmdline')      -- Command line completion

	-- Snippets
	use('L3MON4D3/LuaSnip',{
		-- follow latest release.
		tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!:).
		run = "make install_jsregexp"
	})         -- Snippet engine
	use('saadparwaiz1/cmp_luasnip') -- Snippet completion source
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
	use {
		'numToStr/FTerm.nvim',
		config = function()
			require('FTerm').setup({
				border = 'double',
				dimensions = {
					height = 0.9,
					width = 0.9,
				},
			})
		end
	}
	use('ThePrimeagen/vim-be-good')
end)



