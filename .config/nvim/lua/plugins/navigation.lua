return {
  {
    "tpope/vim-surround"
  },
  {
    "vim-airline/vim-airline",
    dependencies = { 'vim-airline/vim-airline-themes' },
    -- vim-airline only allows using config for configuration.
    config = function ()
      -- Enable the tabline extension to show buffers/tabs at the top
      vim.g["airline#extensions#tabline#enabled"] = 1
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_hidden = false,
        },
      },
    },
    cmd = {
      "NeoTreeClose", "NeoTreeFloat", "NeoTreeFloatToggle", "NeoTreeFocus", "NeoTreeFocusToggle", "NeoTreeLogs",
      "NeoTreePasteConfig", "NeoTreeReveal", "NeoTreeRevealInSplit", "NeoTreeRevealInSplitToggle", "NeoTreeRevealToggle",
      "NeoTreeSetLogLevel", "NeoTreeShow", "NeoTreeShowInSplit", "NeoTreeShowInSplitToggle", "NeoTreeShowToggle",
      "Neotree",
    },
    keys = {
      { "<leader>lf", "<cmd>Neotree toggle reveal<cr>", desc = "Reveal file" },
      { "<leader>ls", "<cmd>Neotree toggle<cr>", desc = "Toggle filesystem bar" }
    },
  },
}
