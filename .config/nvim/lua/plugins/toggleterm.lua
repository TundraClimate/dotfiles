return {
	"akinsho/toggleterm.nvim",
	event = "BufEnter",
	cmd = {
		"ToggleTerm",
		"TermExec",
	},
	opts = {
		direction = "float",

		on_create = function(t)
			local function toggle()
				t:toggle()
			end
			vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle)
		end,
		float_opts = { border = "rounded" },
	},
	keys = {
		{ "<F7>", "<cmd>ToggleTerm<CR>" },
	},
}
