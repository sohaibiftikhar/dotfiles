-- Ignore case for file name matching
vim.opt.wildignorecase = true
-- Ignore case only if search is only in lowercase
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Wrap lines and retain indent
vim.opt.breakindent = true
-- Set default tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- Don't use the mouse
vim.opt.mouse = ""
-- Save undo history
vim.opt.undofile = true
-- Show line numbers
vim.opt.number = true
-- Integrate with the system clipboard (like unnamedplus in Vimscript)
vim.opt.clipboard = 'unnamedplus'
-- Center viewport, except for help pages
local center_group = vim.api.nvim_create_augroup("center", {})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "let &scrolloff = &filetype == 'help' ? 0 : 99",
  group = center_group, })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "autocmd CursorMoved <buffer> :execute 'normal! zt'",
  group = center_group,
})
-- Resize windows when vim is resized to be equal in size
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
  group = vim.api.nvim_create_augroup("window_resize", {}),
})
-- Highlight cursor line when window is active
local cursorline_group = vim.api.nvim_create_augroup("cursorline", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  once = true,
  callback = function()
    vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "FocusGained" }, {
      pattern = "*",
      command = "setlocal cursorline",
      group = cursorline_group,
    })
    vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
      pattern = "*",
      command = "setlocal nocursorline",
      group = cursorline_group,
    })
  end,
  group = cursorline_group,
})

-- Set leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "["
-- Ignore TMP directory to speed up vim diffs.
vim.g.piperlib_ignored_dirs = "['/tmp']"
-- Set column lines for 80 characters.
vim.opt.colorcolumn = "80"

-- Custom mappings
local function map(mode, lhs, rhs, desc)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, desc = desc })
end

map("n", "<leader>c", "<Plug>Kwbd<cr>", "Close buffer without killing window.")
map("n", "<leader>[", "<cmd>bp<cr>", "Go to the previous buffer.")
map("n", "<leader>]", "<cmd>bn<cr>", "Go to the next buffer.")
map("n", "<leader>hh", "<C-w>h")
map("n", "<leader>ll", "<C-w>l")
map("v", "p", "pgvy", "Paste does not change the content of the current buffer.")


-- End custom mappings

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system(
    { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Configuration for lazy module loading.
require("lazy").setup({
  {
    url = "sso://user/fentanes/nvgoog",
    import = "nvgoog.default",
  },
  { import = "plugins" },
  {
    "nvimdev/lspsaga.nvim",
    -- disable lightbulb entirely.
    opts = {
      lightbulb = {
        enable = false,
      }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            -- Make sure to require actions if not globally available
            ["<esc>"] = "close",
          }
        }
      },
      extensions = {
        codesearch = {
          experimental = true
        }
      }
    }
  }
})
