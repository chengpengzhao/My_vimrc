"status line settings{{{

"总是显示状态栏"
set laststatus=2

"显示当前搜索时是否高亮
function! HighlightSearch()
    if &hls
        return 'H'
    else
        return 'noH'
    endif
endfunction

"显示当前是否开启了paste模式
function! HighlightPaste()
    if &paste
        return 'P'
    else
        return 'noP'
    endif
endfunction

"计算buffer总数
function! Buf_total_num()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

"文件大小计算

function! File_size(f)
    let l:size = getfsize(expand(a:f))
    if l:size == 0 || l:size == -1 || l:size == -2
        return ''
    endif
    if l:size < 1024
        return l:size.' bytes'
    elseif l:size < 1024*1024
        return printf('%.1f', l:size/1024.0).'K'
    elseif l:size < 1024*1024*1024
        return printf('%.1f', l:size/1024.0/1024.0) . 'M'
    else
        return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'G'
    endif
endfunction

"状态栏格式设置"
set statusline=%1*\ %F\ %*%2*\ %{File_size(@%)}\ %*%3*\ %m%r%w%y\ %7*[B%-n]/%{Buf_total_num()}\ %6*\%{HighlightSearch()}\|\%{HighlightPaste()}\%=%5*\ %{synIDattr(synID(line('.'),col('.'),1),'name')}%*%4*\ %{&ff}\ \|\ %{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\ \|\"}\ %-14.(row:%l/%L\(%p%%)\ col:%c\ %{wordcount().words}words%)%*
"上面是总的设置，位置可能有所变化

"文件位置
"set statusline+=%1*\ %F\ %*
"文件大小
"set statusline+=%2*\ %{File_size(@%)}\ %*
"文件修改状态及文件名
"set statusline+=%3*\ %m%r%w%y\ %*
""语言 & 是否高亮，H表示高亮?
"set statusline+=%6*\ %{&spelllang}\\|\%{HighlightSearch()}\  
"光标当前区域类型，写博客时能很容易分辨当前区域为数学或代码或...
"set statusline+=%=%5*\ %{synIDattr(synID(line('.'),col('.'),1),'name')}%*
"文件类型、编码、当前行列、总字数
"set statusline+=%=%4*\ %{&ff}\ \|\ %{\"\".(&fenc==\"\"?&enc:&FENC).((EXISTS(\"+BOMB\")\ &&\ &BOMB)?\",b\":\"\").\"\ \|\"}\ %-14.(ROW:%L/%l\(%P%%)\ COL:%C%)%*

"设置各区域颜色
hi User1 cterm=bold ctermfg=232 ctermbg=179
hi User2 cterm=None ctermfg=214 ctermbg=242
hi User3 cterm=bold ctermfg=15 ctermbg=9
hi User4 cterm=None ctermfg=7 ctermbg=33
hi User5 cterm=None ctermfg=11 ctermbg=240
hi User7 cterm=None ctermfg=208 ctermbg=238
" }}}
"=========================================================================="
"基础设置{{{

"设置功能键超时检测为 50 毫秒，加快vim速度
set ttimeout ttimeoutlen=50
set timeout ttimeoutlen=1000

"ctags 配置，使用：输入 ctags -R生成tag文件
set tags=./.tags;,.tags

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

silent! colorscheme molokai

"开启高亮
syntax on

"允许针对每个文件进行文件级别的设置
"用法举例：# vim:set et sw=4 ts=4:
set modeline
set modelines=10

" 光标样式
set gcr=a:blinkon0

"光标上下可见行数
set scrolloff=3

"Automatically enable mouse usage
set mouse=a

"Hide the mouse cursor while typing
set mousehide

"有时候在windows下编写的python脚本在linux下不能运行，因为^M的原因,设置格式为unix能够自动清除多余的^M
set fileformat=unix

"Enable hidden buffers, 不保存修改也能跳转buffers
set hidden

" 去除VI一致性,必须要添加
set nocompatible

"激活/取消paste模式，粘贴出现自动缩进时用,按键为Alt-p
set pastetoggle=p

"一般关闭paste模式，该模式下有的map会出问题
set nopaste

" 解决插入模式下delete/backspce键失效问题(Mac用户)
set backspace=indent,eol,start

"将工作目录自动切换到正在编辑的文件的目录。
set autochdir

set autoread        " auto read when file is changed from outside

set showmatch " 高亮显示匹配的括号

set showmode        " Show current mode

"不要开启这项！！！会让vim保存几次后变得贼卡,辣鸡设置一个
"让vimrc配置变更立即生效
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

cnoremap sss source $MYVIMRC

"Right mouse button pops up a menu
set mousemodel=popup

"外观设置
set background=dark

set t_Co=256          " 256 color mode

set cursorline        " 显示cursorline但最好不要高亮，容易把其他高亮覆盖掉

"下面两行是有次vim出问题，每次打开都有按下Enter时设置的，好像没啥用
set shortmess=filmnrxoOtT       " Abbrev. of messages (avoids 'hit enter')
set cmdheight=2

" the cursor can be positioned where there is no actual character
"set virtual edit=all
set virtualedit=block "还是不让光标位置无限制了

"让隐藏字符完全隐藏,好像是哪个插件要设置的（Snippets？)
set conceallevel=2

"不自动分行(但可以分行显示）
set wrap
set textwidth=0

"切换是否拼写检查,markdown默认开启，Fa切换
autocmd Filetype markdown setlocal spell
nnoremap <F3> : setlocal spell!<CR>
set spelllang=en_us,en_gb,cjk

"方便拼写检查在单词间跳转
autocmd Filetype markdown nnoremap [ [s
autocmd Filetype markdown nnoremap ] ]s

"来自那位用Vim上课记笔记的大佬，insert模式<C-o>自动更正前一个单词
"zg     把当前单词添加到拼写文件中    
"zw     把当前单词从拼写文件中删除    
"z=     为当前单词提供更正建议    
"插入模式下使用 <Ctrl-x>-s 获得的自动补全单词列表 
inoremap <C-o> <c-g>u<Esc>[s1z=`]a<c-g>u
"<c-g>u的含义 ：don't break undo with next left/right cursor *i_CTRL-G_U* movement (but only if the cursor stays within same the line)

"设置标记，三个{定义为标记，可用za折叠展开
set foldenable
set foldmethod=marker
autocmd FileType c,cpp,python set foldmethod=indent nofoldenable

"解决乱码问题
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,latin1
set langmenu=zh_CN.UTF-8
set helplang=cn

set ttyfast        "a fast terminal connection.

"设置数字为十进制，防止<C-a><C-x>修改时出现不希望的结果
set nrformats=

"依文件类型设置自动缩进
filetype plugin on
filetype indent on

"增强%命令功能，可以在配对关键字间跳转
runtime macros/matchit.vim

"显示当前的行号(相对)：
set ruler
set number
set relativenumber

""autocmd InsertEnter * :set norelativenumber "插入模式下撤下相对行号
""autocmd InsertLeave * :set relativenumber   "普通模式下加上相对行号

"需要记住多少次历史操作
set history=1000

"命令模式下，底部操作指令按下 Tab 键自动补全。第一次按下 Tab，会显示所有匹配的操作指令的清单；第二次按下 Tab，会依次选择各个指令。
set wildmenu        " wild char completion menu

set wildmode=longest:list,full
set wildchar=<TAB>  " start wild expansion in the command line using <TAB>

set nobackup        " no *~ backup files

set noswapfile " 不要生成swap文件，当buffer被丢弃的时候隐藏它

"保留撤销历史，使得重新打开一个文件，可以撤销上一次编辑时的操作。
set undofile

"这三个好像没啥效果，默认就开着？先放这反正不碍事
set showcmd     " Show partial commands in status line and selected characters/lines in visual mode
set showmode     " Display the current mode

set incsearch " 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set hlsearch  " 高亮搜索结果

set autoread        " auto read when file is changed from outside

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"显示行尾多余空格与tab符号
set listchars=tab:»-,trail:■
set list

"将制表符扩展为空格
set expandtab

"设置编辑时制表符占用空格数
set tabstop=4

"设置格式化时制表符占用空格数
set shiftwidth=4

" 关闭softtabstop 永远不要将空格和tab混合输入
set softtabstop=0

"开启自动缩进
set autoindent   " Indent at the same level of the previous line

"开启智能对齐
set smartindent

"设置使用 C/C++ 语言的自动缩进方式
set cindent
"设置命令行的高度
set cmdheight=1

"设置大小写不敏感/当前为大写字母时调整为敏感/自动改动字母大小写
set ignorecase
set smartcase
set infercase
set smarttab        " insert tabs on the start of a line according to context

"虽然不知道有啥用但help里面推荐设置默认的magic(正则表达式相关)
set magic

"在执行宏命令时，不进行显示重绘；在宏命令执行完成后，一次性重绘，以便提高性能
set lazyredraw

"设置文件间复制粘贴，访问系统剪切板(这个还是算了，会托慢Vim反应速度）
"set clipboard=unnamedplus

"单词自动补全功能,写博客时用,自定义词典可参考网上教程
""set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/engspchk-dict
set completeopt+=noinsert

"Ctrl+Space单词补全"
"WSL系统中此快捷键不管用，故换成下面一条
"inoremap <C-@> <C-x><C-k>
inoremap <C-f> <C-x><C-k>
"}}}
"=========================================================================="
"快捷键相关{{{

"定义全局<Leader>
let mapleader = ","

"设置ESC切换搜索结果是否高亮
"关闭高亮直到下一次查找
cnoremap hl  nohlsearch<CR>

"buffer前后跳转
noremap <Leader>j :bnext<CR>
noremap <Leader>k :bpre<CR>

"选择全文
noremap a <Esc>ggVG<CR>

"Tabs，各窗口间切换
"WSL系统可以使用S-tab切换了，故修改为更方便的快捷键
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"普通模式用<C-y>复制到系统剪切板，<C-y>y也可用
noremap <C-y> "+y

"空格快速进入命令模式
noremap  <Space> :

"打开OpenFOAM相关文件时为了方便输入命令加了下面这个映射,!表示输入系统shell命令
autocmd Filetype foam256* noremap  <Space> :!

"映射上下左右的光标移动,刚开始用着还行，但和一些插件快捷键冲突，而且i本身是进入插入模式，不改为好
"noremap  i   k
"noremap  j   h
"noremap  k  j
"noremap  gk  gj
"noremap  gi  gk

"行光标移动,这个挺方便的，header与end，也没见有冲突
noremap H   ^
noremap E   $

"文件保存与退出quick write ,quick quit的缩写，很实用
nnoremap <Leader>w  :w<CR>
nnoremap  qw    :wq<CR>
nnoremap  qq    :q!<CR>

"宏名称统一用a，简化按键,qa开始记录，q结束，再按@即可
nnoremap  @  @a

"模仿shell快捷键
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"插入模式下移动光标
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>

"向后删除 *为向前删除，shell通用
"在WSL中发现C-8(Backspace)无法删除了,只能用backspace
inoremap <C-d> <Delete>

"自动插入完整括号,用了一段时间，加了snippet插件后发现不自动补全比较好
""inoremap ( ()<Left>
""inoremap（ （）<Left>
""inoremap [ []<Left>
""inoremap { {}<Left>
""inoremap " ""<Left>

"超级用户权限编辑，出现权限不够无法保存时命令模式输入sw即可
cnoremap sw w !sudo tee >/dev/null %

"快速编辑vim配置文件,在其他文件界面里呼出配置文件，并方便地source以立即适用改动
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"}}}
"=========================================================================="
" markdown settings---------------------- {{{

" 计算某个pattern从startline到光标处出现的次数
function! Count(pattern,startline)
  let l:cnt = 0
  silent! exe a:startline . ',.s/' . a:pattern . '/\=execute(''let l:cnt += 1'')/gn'
  return l:cnt
endfunction

"计算markdown中一级标题出现的次数，用来给公式自动编号
function! Findtitle()
    for i in range(line('.'))
        if matchstr(getline(line('.')-i),'^# \+')!=#''
            let l:latesttitleline=line('.')-i
            break
        else
            let l:latesttitleline=line('.')
        endif
    endfor
    return l:latesttitleline
endfunction

".Md文件也能被识别为markdown
autocmd BufNewFile,BufRead *.Md set filetype=markdown

"*****************************************************************************
"Markdown快捷键
"*****************************************************************************

"定义本地<Leader>键
let maplocalleader = "/"

"减少手的移动，映射回车为<C-/>
autocmd Filetype markdown inoremap  <CR>
"寻找标记，实现光标快速跳转
"其中/实际上为Alt+/键的组合，输入方式为先按<C-v>，再Alt-/
autocmd Filetype markdown inoremap / <Esc>/<++><CR>:nohlsearch<CR>i<Del><Del><Del><Del>

"h1~h5标题
autocmd Filetype markdown inoremap <localLeader>1 <ESC>o#<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <localLeader>2 <ESC>o##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <localLeader>3 <ESC>o###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <localLeader>4 <ESC>o####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <localLeader>5 <ESC>o#####<Space><Enter><++><Esc>kA

"代码块
autocmd Filetype markdown inoremap <localLeader>c ```<Enter><++><Enter>```<Enter><++><Enter><Esc>4kA

"辅助实现自动编号,特意找了平时不用的键
autocmd Filetype markdown inoremap <expr> <localLeader><F11> Count('^# \+',1)
autocmd Filetype markdown inoremap <expr> <Leader><localLeader><F11> Count(' \\tag{\d\+-\d\+}',Findtitle())+1
autocmd Filetype markdown inoremap <expr> <localLeader><F12> eval(Count('\[\^\d\+\]',1)+1)

"行间公式，带自动编号
autocmd Filetype markdown imap <localLeader>q <ESC>o$$<Enter><Enter> \tag{<localLeader><F11>-<Leader><localLeader><F11>}$$<Enter><BS><++><Esc>2kA

"行内公式，由snippets取代，不再用这里的定义，快捷键不变
"autocmd Filetype markdown inoremap <localLeader>e $$<++><Esc>F$i

"也是公式，基本不用
autocmd Filetype markdown inoremap <localLeader>m $$\begin{equation}<Enter><Enter>\end{equation}$$<Enter><++><Esc>2kA

"粗体
autocmd Filetype markdown inoremap <localLeader>b ****<++><Esc>F*hi

"下划线
autocmd Filetype markdown inoremap <localLeader>u <u></u><++><Esc>F/i<Left>

"斜体
autocmd Filetype markdown inoremap <localLeader>i **<++><Esc>F*i

"删除线
autocmd Filetype markdown inoremap <localLeader>d ~~~~<++><Esc>F~hi

"行内代码
autocmd Filetype markdown inoremap <localLeader>s ``<++><Esc>F`i

"插入时间戳
autocmd Filetype markdown inoremap <F2> <br><br><Esc>o> *以下内容更新于<r-R>=strftime('%Y-%m-%d %H:%M:%S')<C-M>*<Down><Esc>o<CR>

"插入自动编号的引用
autocmd Filetype markdown inoremap <localLeader>n [^<localLeader><F12>]<Esc>ya[Go<Esc>pA: <++><Esc><C-o>f]a

"WSL下Vim无法直接访问Windows剪切板，故无法自动复制网址,改用snippet实现
"插入图片，自动复制剪切板网址
"autocmd Filetype markdown inoremap <localLeader>p ![](<C-R>+ "<++>")<++><Esc>F]i
"
""插入地址，使用前确保剪切板已复制url
"autocmd Filetype markdown inoremap <localLeader>a [](<C-R>+ "<++>")<++><Esc>F]i

"分隔线
autocmd Filetype markdown inoremap <localLeader>l <ESC>o--------<Enter>

"这两个该到snippets中实现，因为用的不是很多
"空格符号
"autocmd Filetype markdown inoremap <localLeader>/ &emsp;<Esc>a
"
""空行
"autocmd Filetype markdown imap <localLeader><CR> <br><Esc>a
"
" }}}
"=========================================================================="
"vim-plug插件管理{{{

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes


"markdown实时预览
"WSL中不需要
"Plug 'iamcco/markdown-preview.nvim'

"用的自己fork的版本，做了点小改动让界面看起来更舒服
Plug 'chengpengzhao/vim-OpenFoam-syntax'

"显示缩进
Plug 'Yggdroot/indentLine'
"超级强大的插件，两个配合使用；第一个为引擎，第二个为snippets集合，自定义功能很棒！
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"让vim支持很多markdown显示，我基本不用这些功能，安装只因为它能识别markdown中的公式区域，方便snippets使用
Plug 'plasticboy/vim-markdown'

"自动保存插件，免得每次退出编辑模式都要按下保存
Plug '907th/vim-auto-save'

"文件目录树显示插件，非常强大！！！
Plug 'scrooloose/nerdtree'

"强大的文件搜索插件，快速定位文件
Plug 'Yggdroot/LeaderF'


"用于高效操作与括号、引号或html、xml标签相关的配对符号(surrounding)
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

"自动补全改用youcompleteme，安装详见github
Plug 'ycm-core/YouCompleteMe'

"自动补全括号，引号的插件
Plug 'Raimondi/delimitMate'

"格式化代码插件
"sudo apt install clang-format
"clang-format -dump-config -style=Google > .clang-format
Plug 'rhysd/vim-clang-format'

"检查语法错误插件
Plug 'dense-analysis/ale'

"c++高亮插件
Plug 'octol/vim-cpp-enhanced-highlight'

" 文本对象
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

"Tags管理
Plug 'ludovicchabant/vim-gutentags'

"异步编译
Plug 'skywind3000/asyncrun.vim'

" Initialize plugin system
call plug#end()


" }}}
"=========================================================================="
"其他插件设置{{{

"*****************************************************************************
" indentline

let g:indentLine_enabled = 1
let g:indentLine_color_term = 202
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"*****************************************************************************
" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
"*****************************************************************************
"Vim-markdown设置
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_level = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_strikethrough = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_math = 1
"*****************************************************************************
"autosave
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_events = ["CursorHold"] " 改为普通模式下光标updatetime时间不动时保存一次，默认4000ms
"*****************************************************************************
"NERDTree

"vim不指定文件名时，自动打开NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-n> :NERDTreeToggle<CR>
let NERDTreeWinSize = 30
let NERDTreeShowBookmarks = 1

"高亮当前行
let NERDTreeHighlightCursorline = 1

"从NERDTree打开文件后自动关闭NERDTree
let NERDTreeQuitOnOpen = 1

"显示隐藏文件
"let g:NERDTreeShowHidden = 1

"忽略特定文件和目录
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]

"显示行号
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1

"自动打开NERDTree
"autocmd vimenter * NERDTree

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"*****************************************************************************
" LeaderF
"By default, <Up> and <Down> are used to recall last/next input pattern from history. If you want to use them to navigate the result list just like <C-K> and <C-J>:
"let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1

let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

"搜索文件,ff
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
"*****************************************************************************
"YouCompleteMe 设置

"触发补全所需字符数
let g:ycm_min_num_of_chars_for_completion = 1

"自动开启补全
let g:ycm_auto_trigger = 1

"映射
let g:ycm_key_list_stop_completion = ['o']
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_filetype_blacklist = {
      \'foam256_bC': 1,
      \'foam256_changeDictionaryDict': 1,
      \'foam256_thermodynamicProperties': 1,
      \'foam256_general': 1,
      \}
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
"*****************************************************************************
"vim-clang-format设置
let g:clang_format#command = 'clang-format'
nmap <F2> :ClangFormat<cr>
autocmd FileType c ClangFormatAutoEnable
let g:clang_format#detect_style_file = 1
"*****************************************************************************
"ale 设置
"let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" use quickfix list instead of the loclist
nmap <silent> [ <Plug>(ale_previous_wrap)
nmap <silent> ] <Plug>(ale_next_wrap)
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
"*****************************************************************************
"gutentags配置

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"*****************************************************************************
"Asyncrun
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 Alt+q 打开/关闭 Quickfix 窗口
nnoremap q :call asyncrun#quickfix_toggle(6)<cr>

" GSL安装过程：
" 1. 下载相关文件到本地，解压缩
" 2. ./configure && make && sudo make install
" 3. 添加环境变量到bashrc：
"export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
"export CFLAGS="-I/usr/local/include"
"export LDFLAGS="-L/usr/local/lib"

" 编译单文件,加上了GSL库
nnoremap <silent> c :AsyncRun gcc -lm -lgsl -lgslcblas -lstdc++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"nnoremap <silent> c :AsyncRun gcc -lstdc++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

"运行单文件
nnoremap <silent> r :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"}}}
"=========================================================================="
"" Functions{{{
"*****************************************************************************
if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wm=2
        set textwidth=79
    endfunction
endif
"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END


set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

"*****************************************************************************
"" Custom configs
"*****************************************************************************
" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

"}}}
"=========================================================================="
" WSL设置{{{
"适配Linux子系统，能够正常和windows复制粘贴文本
"利用/mnt/c/Windows/System32/clip.exe
func! GetSelectedText()
    normal gv"xy
    let result = getreg("x")
    return result
endfunc
"if !has("clipboard") && executable("/mnt/c/Windows/System32/clip.exe")
"复制
noremap <silent><C-y> :call system('/mnt/c/Windows/System32/clip.exe', GetSelectedText())<CR>
"剪切
noremap <silent><C-x> :call system('/mnt/c/Windows/System32/clip.exe', GetSelectedText())<CR>gvx
"粘贴<Ctrl+Shift+v>
" }}}
"=========================================================================="
