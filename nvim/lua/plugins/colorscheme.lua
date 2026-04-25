return {
    -- disable tokyonight
    { "folke/tokyonight.nvim", enabled = false },

    -- add base16 which can load any hex palette
    {
        "RRethy/base16-nvim",
        lazy = false,
        priority = 1000,
        config = function()
        local ok, colors = pcall(dofile, vim.fn.expand("~/.cache/matugen/nvim-colors.lua"))
        if ok and colors then
            require("base16-colorscheme").setup(colors)
            else
                vim.cmd("colorscheme base16-catppuccin-mocha")
                end

                -- transparent background so alacritty opacity shows through
                vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })

                -- give dashboard a semi-transparent dark background so text is readable
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = "snacks_dashboard",
                    callback = function()
                    vim.api.nvim_win_set_option(0, "winblend", 20)
                    vim.api.nvim_set_hl(0, "Normal", { bg = "#0d0d0d" })
                    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#cba6f7", bg = "NONE" })
                    vim.api.nvim_set_hl(0, "SnacksDashboardTitle", { fg = "#cdd6f4", bg = "NONE" })
                    vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#cdd6f4", bg = "NONE" })
                    vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#cba6f7", bg = "NONE" })
                    vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#cba6f7", bg = "NONE" })
                    vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = "#a6adc8", bg = "NONE" })
                    end,
                })
                end,
    },

    -- tell LazyVim to use base16
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = function()
            -- handled by base16 setup above
            end,
        },
    },
}
