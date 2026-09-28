return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",

        config = function(_)
            local ts = require("nvim-treesitter")

            ts.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "<filetype>" },
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)

                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "BufRead",
        opts = {},
    },
    {
        "m-demare/hlargs.nvim",
    },
}
