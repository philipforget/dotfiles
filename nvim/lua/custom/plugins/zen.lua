return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      { "folke/twilight.nvim" },
    },
    keys = {
      { "<Leader>z", ":ZenMode <Cr>", desc = "Toggle ZenMode" },
    },
    opts = {
      window = {
        -- backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 80,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
    },
  },
}
