local M = {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    keys = {
        {
            "<leader>gf",
            function()
                require("telescope.builtin").grep_string()
            end,
            desc = "Telescope find files",
        },
        {
            "<leader>pl",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Telescope live grep",
        },
        {
            "<leader>pp",
            function()
                require("telescope.builtin").git_files({ show_untracked = true })
            end,
            desc = "Telescope Git Files",
        },
        {
            "<leader>pe",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Telescope buffers",
        },
        {
            "<leader>gs",
            function()
                require("telescope.builtin").git_status()
            end,
            desc = "Telescope Git status",
        },
        {
            "<leader>gb",
            function()
                require("telescope.builtin").git_branches()
            end,
            desc = "Telescope Git branches",
        },
        {
            "<leader>rp",
            function()
                require("telescope.builtin").find_files({
                    prompt_title = "Plugins",
                    cwd = vim.fn.stdpath("config") .. "/lua/plugins",
                    attach_mappings = function(_, map)
                        local actions = require("telescope.actions")
                        local action_state = require("telescope.actions.state")
                        map("i", "<c-y>", function(prompt_bufnr)
                            local new_plugin = action_state.get_current_line()
                            actions.close(prompt_bufnr)
                            vim.cmd(string.format("edit ~/.config/nvim/lua/plugins/%s.lua", new_plugin))
                        end)
                        return true
                    end,
                })
            end,

            desc = "Telescope find Plugins",
        },
        {
            "<leader>pf",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Telescope Find Files",
        },
        {
            "<leader>ph",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Telescope Help",
        },
        {
            "<C-n>",
            function()
                require("telescope").extensions.file_browser.file_browser({ path = "%:h:p", select_buffer = true })
            end,
            desc = "Telescope file browser",
        },
        {
            "<leader>cs",
            function()
                require("telescope.builtin").colorscheme({ enable_preview = true })
            end,
            desc = "Telescope colorscheme",
        },
        {
            "<leader>pk",
            function()
                require("telescope.builtin").keymaps()
            end,
            desc = "Telescope keymaps",
        },
        {
            "<leader>gc",
            function()
                require("telescope.builtin").git_bcommits()
            end,
            desc = "Telescope git commits",
        },
    },
}
function M.config()
    local actions = require("telescope.actions")

    require("telescope").setup({
        defaults = {
            selection_caret = " ",
            prompt_prefix = "   ",
            border = true,
            entry_prefix = "  ",
            multi_icon = "  ",
            sorting_strategy = "ascending",
            hl_result_eol = true,
            prompt_position = "top",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "bottom",
                    preview_width = 0.5,
                    results_width = 0.5,
                },
                width = 0.90,
                height = 0.99,
            },
            mappings = {
                i = {
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,

                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,

                    ["<C-q>"] = actions.close,
                    ["<C-d>"] = function(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        local filepath = selection.path
                        actions.close(prompt_bufnr)
                        vim.fn.delete(filepath)
                        print("Deleted file: " .. filepath)
                    end,
                },
                n = {
                    ["<esc>"] = actions.close,
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["q"] = actions.close,
                },
            },
        },
    })
end
return M
