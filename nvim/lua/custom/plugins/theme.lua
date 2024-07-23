return {
  {
    'f-person/auto-dark-mode.nvim',
    dependencies = {
      {
        'catppuccin/nvim',
        config = function()
          require('catppuccin').setup {
            integrations = {
              cmp = true,
              gitsigns = true,
              nvimtree = true,
              treesitter = true,
              notify = false,
              mini = {
                enabled = true,
                indentscope_color = '',
              },
            },
          }
        end,
      },
    },
    config = {
      set_dark_mode = function()
        vim.cmd.colorscheme 'catppuccin-mocha'
      end,
      set_light_mode = function()
        vim.cmd.colorscheme 'catppuccin-latte'
      end,
    },
  },
}

-- return {
--   {
--     'catppuccin/nvim',
--     config = function()
--       require('catppuccin').setup {
--         integrations = {
--           cmp = true,
--           gitsigns = true,
--           nvimtree = true,
--           treesitter = true,
--           notify = false,
--           mini = {
--             enabled = true,
--             indentscope_color = '',
--           },
--         },
--       }
--
--       -- vim.cmd.colorscheme 'catppuccin-mocha'
--       vim.cmd.colorscheme 'catppuccin-latte'
--     end,
--   },
-- }
