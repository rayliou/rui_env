"Usage
" - Install  vim-gtk3 or neovim instead of vim
" https://mapan1984.github.io/tool/2016/04/10/Vim-%E5%A5%87%E6%8A%80%E6%B7%AB%E5%B7%A7/

":%TOhtml - 转换为HTML文件
"J - 合并下一行与当前行
"gf - 打开光标处的文件（这个命令在打到#include头文件时挺好用的，当然，仅限于有路径的）
"K - 在linux系统函数上用K跳转到man page查询页面查询系统函数（unix、linux），
"g<c-g> 字节统计


" 配色方案
"colorscheme morning
"colorscheme evening
"colorscheme industry
colorscheme desert
colorscheme peachpuff
"set background=dark
set background=dark
set background=light

set mouse=  "disable mouse
set history=2000           " 设置历史记录条目数
filetype on                " 启用文件类型检测
filetype plugin on         " 启用插件加载
filetype indent on         " 启用基于文件类型的缩进
set nocompatible            " 禁用兼容模式
set autoread                " 文件外部被修改后自动读取
set shortmess+=atI          " 启动时不显示欢迎信息
set nobackup                " 禁用备份文件
set noswapfile              " 禁用交换文件
set number                  " 显示行号
"set relativenumber          " 显示相对行号
set cursorline              " 高亮当前行
set title                   " 改变终端标题
set noerrorbells            " 禁止终端蜂鸣
set novisualbell            " 禁用视觉提示
set hlsearch                " 搜索时高亮匹配项
set ignorecase              " 搜索时忽略大小写
set smartcase               " 智能区分大小写
set incsearch               " 增量搜索
set foldenable              " 启用折叠
set foldmethod=indent       " 根据缩进进行折叠
set foldlevel=99            " 默认不折叠内容
set tabstop=4               " Tab 键宽度为4个空格
set shiftwidth=4            " 自动缩进宽度为4个空格
set softtabstop=4           " 退格时缩进删除4个空格
set expandtab               " 将 Tab 替换为空格
set autoindent              " 启用自动缩进
set smarttab                " 在行首根据缩进级别插入Tab
set showcmd                 " 显示部分命令
set hidden                  " 支持隐藏未保存的缓冲区
set scrolloff=7             " 光标下方预留7行滚动空间
set ttyfast                 " 提高终端绘制速度
set wildmenu                " 启用命令补全菜单
set wildmode=list:longest   " 列出匹配的命令并补全最长部分
set ruler                   " 显示光标位置
set laststatus=2            " 始终显示状态栏
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set encoding=utf-8          " 使用 UTF-8 编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set ffs=unix,dos,mac        " 文件格式选择

" 自动命令，启用相对行号的切换
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd FocusLost * :set number
autocmd FocusGained * :set number
" 显示匹配括号
set showmatch
set mat=2                  " 匹配括号时等待 0.2 秒
" 光标移动设置
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" 设置 Leader 键为逗号
let mapleader = ','
let g:mapleader = ','

" Vimrc 配置快捷命令
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" 禁用方向键，强制使用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" 行内移动优化，允许使用 gk 和 gj 处理换行
map j gj
map k gk

" 使用 Ctrl + hjkl 切换窗口
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" 行首和行尾快速跳转
noremap H 0
noremap L $

" Tab 页管理快捷键
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove<CR>

" 快速保存并编译
map <F5> :wa<CR>:make<CR>

" 关闭搜索高亮
noremap <silent> <leader>/ :nohls<CR>

" 启用粘贴模式离开插入模式后自动关闭
autocmd InsertLeave * set nopaste

" 在保存 .vimrc 后自动重新加载
au BufWritePost .vimrc source $MYVIMRC

function! ToggleLineNumbers()
    if &number && &relativenumber " If both are enabled, switch to only absolute line numbers
        set norelativenumber
    elseif &number && !&relativenumber " If only absolute numbers are enabled, turn off all and enable paste mode
        set nonumber
        set paste
    else " If neither are enabled, enable both relative and absolute line numbers, and disable paste mode
        set number
        set relativenumber
        set nopaste
    endif
endfunction
"map <F2> :set relativenumber!  relativenumber?<cr>
map <F2> :call ToggleLineNumbers()<CR>



"Use arrow key to change buffer"
noremap <left> :bp<CR>
noremap <right> :bn<CR>

" 自动获取所有可用的配色方案
let s:colorschemes = split(globpath(&runtimepath, 'colors/*.vim'), '\n')
let s:current_colorscheme = 0

" 获取纯主题名，不带路径和文件扩展名
for i in range(len(s:colorschemes))
    let s:colorschemes[i] = substitute(fnamemodify(s:colorschemes[i], ':t'), '.vim$', '', '')
endfor

" 定义切换到下一个配色方案的函数
function! NextColorscheme()
    " 切换到下一个配色方案
    let s:current_colorscheme = (s:current_colorscheme + 1) % len(s:colorschemes)
    exe 'colorscheme ' . s:colorschemes[s:current_colorscheme]
    echo "Switched to " . s:colorschemes[s:current_colorscheme] . " colorscheme"
endfunction

function! SyncCursorLineToVisual()
    let visual_bg = synIDattr(hlID('Visual'), 'bg', 'cterm')
    let visual_fg = synIDattr(hlID('Visual'), 'fg', 'cterm')
    if visual_bg != ""
        execute 'highlight CursorLine ctermbg=' . visual_bg
    endif
    if visual_fg != ""
        execute 'highlight CursorLine ctermfg=' . visual_fg
    else
        execute 'highlight CursorLine ctermfg=NONE'
    endif
endfunction

autocmd ColorScheme * call SyncCursorLineToVisual()
call SyncCursorLineToVisual()

" 绑定快捷键 F9 切换到下一个配色方案
nnoremap <F12> :call NextColorscheme()<CR>
nnoremap <up> :call NextColorscheme()<CR>
nnoremap <F4> :E<CR>

"https://github.com/justinmk/vim-sneak
let g:sneak#label = 1

set diffopt+=iwhiteall,iblank
