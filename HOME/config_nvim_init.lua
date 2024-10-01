local vimrc = vim.fn.expand("~/.vimrc")
if vim.fn.filereadable(vimrc) == 1 then
    vim.cmd("source " .. vimrc)
end

-- https://lazy.folke.io/installation
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  -- 插件列表
  spec = {
        {"morhetz/gruvbox", config = function() vim.cmd([[colorscheme gruvbox]]) end }, 
        {"justinmk/vim-sneak", config = function() vim.g['sneak#label'] = 1 end },
        {
          "nvim-treesitter/nvim-treesitter",
          opts = { ensure_installed = { "cpp", "c", "python", "cmake", "make", "bash", "markdown", "markdown_inline" } },
        },
        {
          "p00f/clangd_extensions.nvim",
          lazy = true,
          config = function() end,
          opts = {
            inlay_hints = {
              inline = false,
            },
            ast = {
              --These require codicons (https://github.com/microsoft/vscode-codicons)
              role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
              },
              kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
              },
            },
          },
        },
        {"neovim/nvim-lspconfig", config = function()
          require("lspconfig").clangd.setup({
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            },
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,  
            },
          })
        end,  
        opts = {
            server = {
              clangd = {
                keys = {
                  { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                },
              },
            }, -- server
          }, -- opts  
        }, -- neovim/nvim-lspconfig
    }, --spec
    
  install = { colorscheme = { "habamax" } }, -- 插件安装时使用的颜色主题
  checker = { enabled = true },              -- 自动检查插件更新
})

--colorscheme gruvbox
vim.cmd([[colorscheme murphy]])
