return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell,

				null_ls.builtins.code_actions.statix,
				null_ls.builtins.diagnostics.statix,
				null_ls.builtins.diagnostics.deadnix,
				null_ls.builtins.formatting.nixfmt,

				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,
				-- null_ls.builtins.formatting.goimports_reviser,
			},
		})
	end,
}
