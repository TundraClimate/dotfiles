return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true, branch = "main" },
            { "m-demare/hlargs.nvim" },
        },
        event = "BufReadPre",
        cmd = {
            "TSBufDisable",
            "TSBufEnable",
            "TSBufToggle",
            "TSDisable",
            "TSEnable",
            "TSToggle",
            "TSInstall",
            "TSInstallInfo",
            "TSInstallSync",
            "TSModuleInfo",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
        },
        build = ":TSUpdate",
        opts = {
            auto_install = false,
            highlight = { enable = true },
            incremental_selection = { enable = true },
            indent = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.config").setup(opts)
            require("nvim-treesitter-textobjects.init").setup(opts)
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "BufRead",
        opts = {},
    },
}
