local opt = vim.opt
vim.g.mapleader = " "
opt.clipboard:append("unnamedplus")
opt.number = true
opt.cursorline = true
opt.showcmd = true
opt.showmode = true
opt.mouse = "a"
opt.background = "light"
opt.laststatus = 2

opt.tabstop = 8
opt.shiftwidth = 8
opt.softtabstop = 8
opt.expandtab = false
opt.autoindent = true
opt.cindent = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.list = true
opt.listchars = { tab = "▸ ", trail = "·", extends = ">", precedes = "<" }

opt.tags = { "./tags;", "tags" }
opt.undofile = true
opt.directory:prepend(vim.fn.expand("$HOME/.local/state/nvim/swap//"))

local keymap = vim.keymap.set

keymap('n', '<F5>', ':w<CR>:!gcc % -o %:r -lm -lncurses && ./%:r<CR>', { noremap = true, silent = true })

local py_group = vim.api.nvim_create_augroup("python_settings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    command = "setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent smartindent",
    group = py_group,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
    { "neoclide/coc.nvim", branch = "release" },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                current_line_blame = true, -- 默认开启行内 blame
            })
            vim.keymap.set('n', ']c', ':Gitsigns next_hunk<CR>', { desc = '下一个修改块' })
            vim.keymap.set('n', '[c', ':Gitsigns prev_hunk<CR>', { desc = '上一个修改块' })
            vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { desc = '预览当前修改' })
            vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = '撤销当前修改块' })
        end
    },

    { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "打开 LazyGit" }
        }
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesitter-context").setup({
                max_lines = 3, -- 顶部最多吸附 3 行，避免占用太多屏幕
            })
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                scope = { enabled = true, show_start = true }, -- 高亮当前光标所在的代码块
            })
        end
    },

    {
        "stevearc/aerial.nvim",
        dependencies = {
             "nvim-treesitter/nvim-treesitter",
             "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("aerial").setup({
                -- 优先使用 treesitter 提取结构
                backends = { "treesitter", "lsp", "markdown", "man" },
                layout = { max_width = { 40, 0.2 } },
            })
            -- 快捷键：空格 + a 开启/关闭大纲侧边栏
            vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "切换代码大纲" })
        end
    },

})

vim.cmd([[colorscheme gruvbox]])

vim.cmd([[
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction
]])


