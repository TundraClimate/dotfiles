return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<C-J>"] = require("telescope.actions").move_selection_next,
                    ["<C-K>"] = require("telescope.actions").move_selection_previous,
                }
            },

            sorting_strategy = "ascending",

            layout_config = {
                horizontal = { prompt_position = "top", preview_width = 0.55 },
                height = 0.80,
                preview_cutoff = 120,
            },
        }
    }
}
