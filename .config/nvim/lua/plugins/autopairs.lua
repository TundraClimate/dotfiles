return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function(opts)
        require("nvim-autopairs").setup(opts)

        -- TODO
        -- require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
}
