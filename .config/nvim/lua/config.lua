-- NERDTree equivalent in nvim.
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  git = {
    ignore = false,
  },
  actions ={
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  renderer = {
    full_name = true,
    group_empty = true,
    special_files = {},
    symlink_destination = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "signcolumn",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
})

-- gitgutter like plugin.
require('gitsigns').setup()

-- LSP setup. --

-- 1. Setup autocompletion.
-- Set up nvim-cmp.

local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"
vim.lsp.set_log_level("warn")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts
  )
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format {
      async = true,
      filter = function(client) return client.name ~= "tsserver" end } end, bufopts)
end

local home = os.getenv("HOME")
-- require("chatgpt").setup({
-- })

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require 'lspconfig.util'
local nvim_lsp = require('lspconfig')
-- Python language server.
nvim_lsp.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    root_dir = util.root_pattern("pyrightconfig.json"),
})

-- c++ language server.
nvim_lsp.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    cmd = {
      "/usr/local/opt/llvm/bin/clangd",
      "--offset-encoding=utf-16",
    },
})

-- javascript/typescript setup.
nvim_lsp.tsserver.setup({
    on_attach = on_attach,
})

-- rustlang setup
nvim_lsp.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
        },
    },
})
require("rust-tools").setup()

-- golang setup
nvim_lsp.gopls.setup{
  on_attach = on_attach,
  cmd = {'gopls'},
  -- for postfix snippets and analyzers
  capabilities = capabilities,
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
            shadow = true,
         },
         staticcheck = true,
        },
      },
}

-- terraform language server
nvim_lsp.terraformls.setup({
    on_attach = on_attach,
})
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   pattern = {"*.tf", "*.tfvars"},
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })


-- purescript language server
nvim_lsp.purescriptls.setup {
  on_attach = on_attach,
  settings = {
    purescript = {
      addSpagoSources = true, -- e.g. any purescript language-server config here
      formatter = "purs-tidy"
    }
  },
  flags = {
    debounce_text_changes = 150,
  }
}

-- nullls setup
local null_ls = require("null-ls")
null_ls.setup({
    -- debug=true,
    on_attach = on_attach,
    sources = {
      -- Formatting tools
      null_ls.builtins.formatting.jq, -- json formatter
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.prettierd.with({
          filetypes = {
            "css",
            "scss",
            "less",
            "html",
            "yaml",
            "graphql",
        },
      }),
      null_ls.builtins.formatting.goimports_reviser,
      null_ls.builtins.formatting.goimports_reviser,
      null_ls.builtins.formatting.golines,
      null_ls.builtins.formatting.black.with({extra_args={"--line-length", "120"}}),
      -- Diagnostics Tools.
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.code_actions.eslint,
    },
})
null_ls.register({null_ls.builtins.formatting.rustfmt, args = {"-emit=files"}})

-- trouble.nvim setup. Pretty diagnostics for LSP errors.
require("trouble").setup()

-- End LSP setup. --

-- CoPilot
require("CopilotChat").setup {
  -- debug = true, -- Enable debugging
  -- See Configuration section for rest
}
