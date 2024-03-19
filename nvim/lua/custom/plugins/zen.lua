return {
  {
    'folke/zen-mode.nvim',
    dependencies = {
      { 'folke/twilight.nvim' },
    },
    keys = {
      { '<Leader>z', ':ZenMode <Cr>', desc = 'Toggle ZenMode' },
    },
    opts = {
      plugins = {
        twilight = { enabled = false },
      },
      window = {
        backdrop = 1,
        width = 80,
        options = {
          signcolumn = 'no',
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = '0',
          list = false,
        },
      },
    },
  },
}
