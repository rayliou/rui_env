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
    { "justinmk/vim-sneak", config = function() vim.g['sneak#label'] = 1 end },
    {"morhetz/gruvbox", config = function() vim.cmd([[colorscheme gruvbox]]) end }, },
    { "nvim-treesitter/nvim-treesitter",
      opts = { ensure_installed = { "cpp","c", "python" , "cmake", "make", "bash",  } },
    },
    { "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },  -- 延迟加载，文件读取或新文件创建时触发
        config = function()
          -- 配置 clangd
          require("lspconfig").clangd.setup({
            -- 设置 clangd 使用 compile_commands.json 或 .git 根目录
            root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
            -- 其他可选配置
            cmd = { "clangd", "--background-index", "--clang-tidy" },
            capabilities = require("cmp_nvim_lsp").default_capabilities(),  -- 可选，集成补全
          })
        end,
      },

    { "tpope/vim-fugitive", }, -- 其他插件可以在这里添加 例如：Git 插件
    
  install = { colorscheme = { "habamax" } }, -- 插件安装时使用的颜色主题
  checker = { enabled = true },              -- 自动检查插件更新
})

--colorscheme gruvbox
