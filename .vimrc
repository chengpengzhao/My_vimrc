syntax enable

"解决乱码问题
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,latin1

"设置数字为十进制，防止<C-a><C-x>修改时出现不希望的结果
set nrformats=

"依文件类型设置自动缩进
filetype plugin on
filetype indent on
"显示当前的行号列号：
set number
set relativenumber
""set ruler
""autocmd InsertEnter * :set norelativenumber "插入模式下撤下相对行号
""autocmd InsertLeave * :set relativenumber   "普通模式下加上相对行号            

"需要记住多少次历史操作
set history=1000

"命令模式下，底部操作指令按下 Tab 键自动补全。第一次按下 Tab，会显示所有匹配的操作指令的清单；第二次按下 Tab，会依次选择各个指令。
set wildmenu
set wildmode=longest:list,full

set noswapfile " 不要生成swap文件，当buffer被丢弃的时候隐藏它

set showmatch " 高亮显示匹配的括号
set incsearch " 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set hlsearch "高亮搜索结果

"将制表符扩展为空格
set expandtab
"设置编辑时制表符占用空格数
set tabstop=4
"设置格式化时制表符占用空格数
set shiftwidth=4
"让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

"开启自动缩进
set ai
"开启智能对齐
set smartindent

"设置大小写不敏感/当前为大写字母时调整为敏感/自动改动字母大小写
set ignorecase
set smartcase
set infercase

"设置文件间复制粘贴，访问系统剪切板
set clipboard=unnamedplus

"单词自动补全功能,写博客时用"
""set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/engspchk-dict
set completeopt+=noinsert
inoremap <C-@> <C-x><C-k>

"==============================================================================================="
"快捷键相关：
"映射上下左右的光标移动
noremap  i   k
noremap  j   h
noremap  k  j
noremap  gk  gj
noremap  gi  gk

"行光标移动
noremap H   ^
noremap E   $




"文件保存与退出
nnoremap <C-w>  :w<CR>
nnoremap  qw    :wq<CR>
nnoremap  qq    :q!<CR>

"宏名称统一用a，简化按键
nnoremap  @  @a

"快速输入命令
noremap <space> :
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
"插入模式下移动光标
inoremap <C-i> <up>
inoremap <C-j> <left>
inoremap <C-l> <right>
inoremap <C-k> <down>
inoremap <C-d> <Delete>

"自动插入完整括号
inoremap ( ()<Left>
inoremap（ （）<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>
"超级用户权限编辑
cnoremap sw w !sudo tee >/dev/null %


"==============================================================================================="
autocmd BufNewFile,BufRead *.Md set filetype=markdown
"Markdown快捷键   ——来自一位Typora用户
autocmd Filetype markdown inoremap /f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap /1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap /2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap /3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap /4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap /5 #####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap /c ```<Enter><++><Enter>```<Enter><++><Enter><Esc>4kA
autocmd Filetype markdown inoremap /m $$<Enter><Enter> \tag{<++>}$$<Enter><++><Esc>2kA
autocmd Filetype markdown inoremap /e $$<++><Esc>F$i
autocmd Filetype markdown inoremap /q $$\begin{equation}<Enter><Enter>\end{equation}$$<Enter><++><Esc>2kA
autocmd Filetype markdown inoremap /b ****<++><Esc>F*hi
autocmd Filetype markdown inoremap /u <u></u><++><Esc>F/i<Left>
autocmd Filetype markdown inoremap /i **<++><Esc>F*i
autocmd Filetype markdown inoremap /d ~~~~<++><Esc>F~hi
autocmd Filetype markdown inoremap /s ``<++><Esc>F`i
autocmd Filetype markdown inoremap /n [^]:<++><Esc>F]i
autocmd Filetype markdown inoremap /p ![](<++>)<++><Esc>F]i
autocmd Filetype markdown inoremap /a [](<++>)<++><Esc>F]i
autocmd Filetype markdown inoremap /l --------<Enter>
autocmd Filetype markdown inoremap // &emsp;<Esc>a
autocmd Filetype markdown inoremap /<CR> <br><Esc>a
"==============================================================================================="
"vundle插件管理"
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
set nocompatible              " 去除VI一致性,必须要添加
filetype off                  " 必须要添加

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'chengpengzhao/vim-OpenFoam-syntax'
Plugin 'nathanaelkane/vim-indent-guides'

" 以下范例用来支持不同格式的插件安装.
" 请将安装插件的命令放在vundle#begin和vundle#end之间.
" Github上的插件
" 格式为 Plugin '用户名/插件仓库名'
"Plugin 'tpope/vim-fugitive'
" 来自 http://vim-scripts.org/vim/scripts.html 的插件
" Plugin '插件名称' 实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
"Plugin 'L9'
" 由Git支持但不再github上的插件仓库 Plugin 'git clone 后面的地址'
""Plugin 'git://git.wincent.com/command-t.git'
" 本地的Git仓库(例如自己的插件) Plugin 'file:///+本地插件仓库绝对路径'
""Plugin 'file:///home/gmarik/path/to/plugin'
" 插件在仓库的子目录中.
" 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
""Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
""Plugin 'ascenator/L9', {'name': 'newL9'}

" 你的所有插件需要在下面这行之前
call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进,可以使用以下替代:
"filetype plugin on
"
" 常用的命令
" :PluginList       - 列出所有已配置的插件
" :PluginInstall  	 - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
"通过命令行直接安装 vim +PluginInstall +qall
" vim +BundleInstall! +BundleClean +q
" 查阅 :h vundle 获取更多细节和wiki以及FAQ
" 将你自己对非插件片段放在这行之后
"==============================================================================================="
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1,
            \ 'sequence_diagrams': {}
            \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'
"==============================================================================================="
"显示缩进"
let g:indent_guides_enable_on_vim_startup = 1

let g:ibus#layout = 'xkb:us::eng'
let g:ibus#engine = 'sunpinyin'
