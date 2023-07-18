""
"" 我的 vimrc，只把最近仍在使用的贴出来吧，其他的历史久远我也不记得是为了什么加进去的了
""

" 自动缩进
set autoindent smartindent
" 检测有外部修改，并自动重读
set autoread
set backspace=indent,eol,start "set backspace=2 "这是一个
" 看个人喜好，我不太喜欢高亮光标所在行
set nocursorline
" 当文件没有出现在任何一个窗口时，隐藏还是关闭文件
set nohidden
" 保存的历史命令的行数
set history=5000
" 随着输入递进式搜索
set incsearch
" 在 Linux 里可以用于查看所有 manpage，而不仅显示系统调用或 C 函数库的
set keywordprg=man\ -a
" 设置下方的命令区高度为 2 行
set laststatus=2
if has("gui_running")
  " 控制 gvim 的窗口大小（高度）
  set lines=32
endif
if has("gui_running")
  " gvim 中允许鼠标操作
  set mouse=a
else
  " 终端中运行禁止鼠标
  set mouse=
endif
" 在底部状态栏显示光标当前所在的“行,列”
set ruler
" 向上下滚动时，光标到窗口上、下各 2 行时认为触顶、底，开始滚动内容
set scrolloff=2 "like in emacs
" 设定通过键盘进入选择模式
set selectmode=key
if has("gui_running")
  " gvim 中加上鼠标
  set selectmode+=mouse
endif
" 到达行首/尾时，光标可以进入上/下的行，并且操作会包含光标所在字符
set selection=inclusive
" 是否在底部的命令输入行显示当前命令的信息，比如在 visual 模式下显示选择的区域大小，等
set showcmd
" 高亮显示对应的括号，比如光标到达 } 时，高亮对应的 {
set showmatch
" 设定底部状态栏显示“文件名、文件相关信息、光标所在字符的 ASCII 码值[十六进制]，列号、行号，页号，在文件中的百分比”
set statusline=[%n]%<%f%y%h%m%r%=[%b\ 0x%B]\ %l\ of\ %L,%c%V\ Page\ %N\ %P
" 设置编程语言的 tags 文件，用于在代码中跳转
if has ("win32")
  set tags=./tags,./TAGS,tags,TAGS
else
  set tags=./tags,./TAGS,tags,TAGS,/usr/include/tags
endif
" 设定终端的语言编码，可能是从以前 Linux 还对中文的支持还不够好时候遗留下来的设定
let &termencoding=&encoding
set viminfo='20,\"50
" 按错键时不要闪烁屏幕
set novisualbell t_vb=
" 打开命令行补全的加强模式，允许使用 <Tab> 键进入自动补全模式
set wildmenu

" 对 HTML 的设定，自动缩进时包含这几个标签
let g:html_indent_inctags="html,body,head,tbody"

" 使用 <Leader>p 切换粘贴模式。从剪切板贴代码的时候有用，不会引发自动格式化，默认的 Leader 键是 \
nmap <Leader>p :set paste!<Bar>set paste?<CR>

" ,f 键用于切换代码的 fold 功能
noremap <silent> ,f :set invfoldenable<CR>

""
"" 以下 f 打头的快捷键影射属于个人习惯，可以自行修改。是我最常用、唯一自定义的快捷键系列
""

" 让当前窗口纵向最大化
noremap ff <C-W>_
" 切换到另一个窗口并纵向最大化，r 和 R 分别对应下一个和上一个
noremap fr <C-W>w<C-W>_
noremap fR <C-W>W<C-W>_
" 增加、减少一行窗口高度
noremap f+ <C-W>+
noremap f- <C-W>-
" 增加、减少一列窗口宽度，纵向切分多个窗口时有效
noremap f< <C-W><
noremap f> <C-W>>
" 使所有窗口等大
noremap f= <C-W>=
" 在当前 tab 内关闭其他窗口，只保留当前的
noremap fo <C-W>o
" 下一个，上一个窗口
noremap fn <C-W>w
noremap fp <C-W>W
" 新开一个窗口
noremap fN <C-W>n
" 纵向切分屏幕，新开一个窗口在右侧
noremap <silent> fV :vertical new<CR>
" 水平切分当前窗口，切分后两个窗口显示同样内容
noremap fs <C-W>s
" 纵向切分当前窗口，切分后两个窗口显示同样内容
noremap fv <C-W>v
" 交换当前窗口和下一个窗口中的内容（对应的 Buffer）
noremap fx <C-W>x
" 切分当前窗口，并在另一窗口中调到 tag 所在位置
noremap f] <C-W><C-]>
" 查看 tag 时，在预览窗口中显示当前光标所在单词查找到的 tag
noremap f} <C-W>}

" 移动当前窗口到最 上、下、左、右
noremap <silent> fK <C-W>K
noremap <silent> fJ <C-W>J
noremap <silent> fH <C-W>H
noremap <silent> fL <C-W>L

" 光标进入 上、下、左、右 的窗口
noremap <silent> fk <C-W>k
noremap <silent> fj <C-W>j
noremap <silent> fh <C-W>h
noremap <silent> fl <C-W>l

" 把当前窗口作为新的 tab 打开
noremap <silent> ft <C-W>T

" 新开一个 tab
noremap <silent> tN :tabnew<CR>
" 关闭当前 tab
noremap <silent> tc :tabclose<CR>
" 只保留当前 tab，关闭其他
noremap <silent> to :tabonly<CR>
" 进入前一个 tab
noremap <silent> tp :tabprevious<CR>
" 进入后一个 tab
noremap <silent> tn :tabnext<CR>
" Alt+左右键进入左右 tab
noremap <silent> <A-Left> :tabprevious<CR>
noremap <silent> <A-Right> :tabnext<CR>

"" 三个键需要快速连续按。
""     切换 buffer 的指令需要当前 buffer 要么由其他窗口在打开模式，要么已经保存。
""     如果 autowrite 参数打开的话，会自动保存后再切换
" 列出所有打开的 buffer
noremap <silent> fbb :buffers<CR>
" 删除当前 buffer，并关闭文件
noremap <silent> fbd :bdelete<CR>
" 在当前窗口中访问前一个、后一个 buffer
noremap <silent> fbp :bprevious<CR>
noremap <silent> fbn :bnext<CR>
" 在当前窗口中 访问第一个、最后一个 buffer
noremap <silent> fbf :bfirst<CR>
noremap <silent> fbl :blast<CR>

" 用 /* 和 */ 注释掉当前行
noremap fcom0 I/* <Esc>A */<Esc>

" 用 Alt + 上下键滚动另一个屏幕中的内容
if has("gui_running")
  " gvim 模式下的映射
  noremap <silent> <M-Up> <C-W>p<C-Y><C-W>p
  noremap <silent> <M-Down> <C-W>p<C-E><C-W>p
"else
"  noremap <silent> ^[OA <C-W>p<C-E><C-W>p
"  noremap <silent> ^[OB <C-W>p<C-Y><C-W>p
endif

" 在三种模式下用 CTRL-Tab 切换窗口并最大化。
"     图形状态下，或者在 Windows 里用某个远程终端登陆时，可能会被终端软件拦截而不起作用
noremap <C-Tab> <C-W>w<C-W>_
inoremap <C-Tab> <C-O><C-W>w<C-W>_
cnoremap <C-Tab> <C-C><C-W>w<C-W>_

" 设置 gvim 的表现。不过好久没用 gvim 了，不确定其中某些设置是否还有用，或者是否还需要多此一举
if has("gui_running")
  " 窗口宽高
  set columns=112
  set lines=36

  " 调用外部命令时，是通过伪终端的方式，还是管道
  set guipty
  "set noguipty
endif

" 如果当前窗口允许显示颜色，打开语法高亮开关，并设定前景、背景颜色
if &t_Co > 2 || has("gui_running")
  if has("terminfo")
    set t_Co=16
    set t_AF=<Esc>[%?%p1%{8}%<%t22;%p1%{30}%+%e1;%p1%{22}%+%;%dm
    set t_AB=<Esc>[%?%p1%{8}%<%t25;%p1%{40}%+%e5;%p1%{32}%+%;%dm
    "set t_AF=<Esc>[%?%p1%{8}%<%t3%p1%d%e%p1%{22}%+%d;1%;m
    "set t_AB=<Esc>[%?%p1%{8}%<%t4%p1%d%e%p1%{32}%+%d;1%;m
    set term=xterm
    set background=dark
  else
    set t_Co=16
    set t_Sf=<Esc>[3%dm
    set t_Sb=<Esc>[4%dm
    set background=dark
  endif
  set hlsearch
  syntax on
endif

" 只在编译选项中包含了 autocommands 支持时启用
if has("autocmd")
  if has("gui")
    autocmd WinLeave * set nocursorline nocursorcolumn
    "autocmd WinEnter * set cursorline cursorcolumn
    autocmd WinEnter * set nocursorline nocursorcolumn
  else
    autocmd WinLeave * set nocursorline
    "autocmd WinEnter * set cursorline
    autocmd WinEnter * set nocursorline
  endif

  " load view saved by the mkview command
  autocmd FileType * loadview
  autocmd FileType * set noexpandtab
  "autocmd BufWinEnter * loadview

  " 使能文件类型检测

  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " 根据不同文件设定编辑参数
  " * shiftwidth,sw: 缩进宽度
  " * softtabstop, sts: Tab 的宽度，软设置，并不改变 tabstop 的设定
  " * expandtab, et: 把 tab 键展开成空格
  " * autoindent, ai: 自动缩进
  " * smartindent, si: 智能缩进 
  " * textwidth: 自动格式化时假设的文本最大宽度（列数）
  "autocmd BufEnter *.txt set filetype=text textwidth=78 expandtab shiftwidth=4 softtabstop=4
  autocmd BufEnter *.inc,*.php set filetype=php expandtab tabstop=4 shiftwidth=4 autoindent smartindent softtabstop=4
  autocmd BufEnter *.java,*.jsp set shiftwidth=4 expandtab tabstop=4 softtabstop=4 autoindent smartindent
  "autocmd FileType c,cpp  set expandtab shiftwidth=4 softtabstop=4
  autocmd FileType c,cpp  set noexpandtab shiftwidth=8 softtabstop=8
  autocmd FileType dot  set shiftwidth=4 expandtab softtabstop=4
  "autocmd FileType text set textwidth=78 expandtab softtabstop=4
  autocmd FileType sh set expandtab tabstop=4 shiftwidth=4 expandtab softtabstop=4 autoindent smartindent
  autocmd FileType php set shiftwidth=4 noexpandtab softtabstop=4
  autocmd FileType java,jsp set shiftwidth=4 expandtab softtabstop=4 autoindent smartindent
  autocmd FileType php set shiftwidth=4 expandtab softtabstop=4 autoindent smartindent
  autocmd BufEnter *.html,*.xml set shiftwidth=4 expandtab softtabstop=4 autoindent smartindent
  autocmd FileType html,xml set shiftwidth=4 expandtab softtabstop=4 autoindent smartindent
  autocmd FileType javascript,css set shiftwidth=4 expandtab softtabstop=4 autoindent smartindent
  autocmd FileType python set shiftwidth=4 expandtab softtabstop=4
  autocmd FileType yaml set shiftwidth=4 expandtab softtabstop=4
  "autocmd FileType ruby set shiftwidth=4 expandtab softtabstop=4
  "autocmd FileType eruby set shiftwidth=4 expandtab softtabstop=4
  "autocmd FileType sql set shiftwidth=8 expandtab softtabstop=4

  " 打开文件时，自动跳到上次打开时的位置。如果该位置有错，则不做跳转
  autocmd BufReadPost *
                          \ if line("'\"") > 0 && line("'\"") <= line("$") |
                          \   execute "normal g`\"" |
                          \ endif

  " 关于编程的 自动命令组
  augroup prog
    " Remove all cprog autocommands
    autocmd!

    " When starting to edit a file:
    "   For C and C++ files set formatting of comments and set C-indenting on.
    "   For other files switch it off.
    "   Don't change the order, it's important that the line with * comes first.
    autocmd FileType *      set formatoptions=tcoql nocindent comments&

    "autocmd BufWinLeave *.sh,*.c,*.cpp,*.perl,*.py mkview
    "autocmd BufWinEnter *.sh,*.c,*.cpp,*.perl,*.py silent loadview

    function! CleverTab()
      if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
      else
        return "\<C-N>"
    endfunction
    autocmd FileType c,cpp  noremap! <S-Tab> <C-R>=CleverTab()<CR>
    autocmd FileType c,cpp  noremap! <C-]> <C-X><C-]>
    autocmd FileType c,cpp  noremap! <C-F> <C-X><C-F>
    autocmd FileType c,cpp  noremap! <C-D> <C-X><C-D>
    autocmd FileType c,cpp  noremap! <C-L> <C-X><C-L>

    autocmd FileType c,cpp,sh,perl,python set fileformat=unix

    "autocmd FileType sh     set formatoptions=croql cindent autoindent comments=b:#
    autocmd FileType c,cpp  set formatoptions=croql autoindent cindent smartindent comments=sr:/*,mb:*,el:*/,://
    "autocmd FileType c,cpp  set foldmethod=marker foldmarker=--fb--{{{,--fe--}}} commentstring=\ //\ %s
    autocmd FileType c,cpp  set foldmethod=marker foldmarker={,} commentstring=\ //\ %s
    autocmd FileType c,cpp  set nowrap
    "autocmd FileType perl   set formatoptions=croql cindent comments=b:#
    autocmd FileType python set formatoptions=croql cindent comments=b:#
    autocmd FileType python set foldmethod=indent
    autocmd FileType python set nowrap
    autocmd FileType javascript,css  set formatoptions=croql autoindent cindent smartindent comments=sr:/*,mb:*,el:*/,://
    autocmd FileType javascript  set foldmethod=marker foldmarker={,} commentstring=\ //\ %s
  augroup END
endif " has("autocmd")

" 检查并安装 vim-plug 插件管理器
" Check and Install vim-plug the plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
			  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" 加载插件
" Enable plugins
call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'github/copilot.vim'
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true

  " 检查并加载仅本地可用的插件
  " Check and Enable Plugins only available locally
  if filereadable(glob('~/.vimrc.d/vimrc.plug.local'))
    source  ~/.vimrc.d/vimrc.plug.local
  endif
  
call plug#end()

" -- The End --
"vim:shiftwidth=2 expandtab:
