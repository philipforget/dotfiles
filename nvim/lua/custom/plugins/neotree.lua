return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup {}
  end,
  keys = {
    { "<leader>t", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  }
}
