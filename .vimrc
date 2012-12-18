" NeoBundle の設定
set nocompatible
filetype off

if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" plugin
NeoBundle 'tags'
NeoBundle 'perl'
NeoBundle 'Rykka/riv.vim'
NeoBundle 'tukkee/unite-help'
NeoBundle 'tpope/vim-markdown'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'othree/html5-syntax.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'timcharper/textile.vim'
" vim-scripts plugin
NeoBundle 'vim-scripts/L9'
NeoBundle 'vim-scripts/VOoM'
NeoBundle 'vim-scripts/auto_mkdir'
NeoBundle 'vim-scripts/Markdown-syntax'
NeoBundle 'vim-scripts/PHP-dictionary'
" Shougo's plugin
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
" mattn's plugin
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/togetter-vim'
NeoBundle 'mattn/benchvimrc-vim'
NeoBundle 'mattn/learn-vimscript'
" thinca's plugin
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-template'

" ソフトタブの設定
set expandtab

" ファイル中の<TAB>文字を指定文字分で表示する
set tabstop=4

" vim が挿入するインデントやシフトオペレータで挿入/削除されるインデントの幅
set shiftwidth=4

" <TAB>を押した時に挿入される空白数
set softtabstop=4

" インデントを使えるようにする
filetype plugin indent on

" スマートインデントを有効にする
set smartindent

" if(){} などのインデント
set cindent 

" 入力中のコマンドをステータス行に表示
set showcmd

" ステータスラインを常に表示
set laststatus=2

" ステータスラインに表示する情報の指定
"set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%{synIDattr(synID(line('.'),col('.'),1),'name')}\ %l/%L(%P)%m

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" テキストの1行最大数を無効にする
set textwidth=0

" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" マウスを有効にする
set mouse=a

" ターミナルでマウスを使用可能にする
set ttymouse=xterm2

" 256 Colors
set t_Co=256

" スキーマ指定
colorscheme BlackSea

"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase

"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 最後まで検索したら先頭へ戻る
set wrapscan

" 検索結果文字列のハイライトを有効にする
set hlsearch

"検索時にインクリメンタルサーチを行う
set incsearch

" 現在のモードを表示
set showmode

" 置換に正規表現を使えるようにする
set magic

" シンタックスハイライトを有効にする
syntax on

" 文字列中のSQLをハイライトする
let php_sql_query=1 

" 文字列中のHTMLをハイライトする
let php_htmlInStrings=1 

" 起動時のメッセージを表示しない
set shortmess+=I

" 行番号を表示
set number

" 閉じ括弧が入力されたとき、対応する括弧を表示
set showmatch

" クリップボードをWindowsと連携
set clipboard=unnamed

" 折りたたみ
set foldmethod=manual

" ファイルを開いた時点での折りたたみの状態
set foldlevel=0

" 折りたたみの情報を保存
"set viewdir=~/.vim/view

" 折りたたみの情報を自動で保存・読込
"autocmd BufWritePost * :mkview
"autocmd BufReadPost * :loadview

" 改行コードの自動認識
set fileformats=unix,dos,mac

" ルーラー(右下に表示される行・列の番号)を表示
set ruler

" viとの互換性をなくす
set nocompatible

" ビープ音を鳴らさない
set vb t_vb=

" コマンドライン補完を拡張モードにする
set wildmenu

" コマンドラインを補完入力するキー
set wildchar=<Tab>

" バックアップファイルを作成しない
set nobackup

" ファイルの上書きの前にバックアップを作成して、上書きできたらバックアップを消す
set writebackup

" 文字コードの設定
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp

" バックスペースですべて消せるように
set backspace=indent,eol,start

" カーソル行をハイライト
set cursorline

" カーソル行を反転させる
hi clear CursorLine
hi CursoLine gui=underline
highlight CursorLine term=reverse cterm=none ctermbg=234

" Enterを押したときに補完のポップアップを消す
inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>":"\<CR>"

" <TAB>で補完
function! InsertTabWrapper()
    let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
            return "\<TAB>"
        else
            if pumvisible()
                return "\<C-N>"
            else
                return "\<C-N>\<C-P>"
            end
        endif
endfunction

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
 
" 行末の不要なスペースを削除する
function! RTrim()
%s/\s\+$//e
endfunction
autocmd BufWritePre *.php,*.rb,*.js,*.tpl,*.ihtml,*.bat,*.pl,*.pm call RTrim()

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/

" ; と : を入れ替える(コマンドモードに入るときに楽！)
noremap ; :

" マッチ文字列が画面の真ん中にくるようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" ビジュアルモードで選択した行を連番にする
nnoremap <silent> <C-a> :ContinuousNumber <C-a><CR>
vnoremap <silent> <C-a> :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" gf で HTML から JavaScript ファイルを開く(スラッシュで始まる相対 URL に対応)
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/

"===============================================
" Plugin
"===============================================

" vim-powerline
" パッチフォントを使用する
let g:Powerline_symbols = 'fancy'

" Markdown.vim
autocmd BufRead,BufNewFile *.md if &ft == 'modula2' | set ft=markdown | endif
autocmd BufRead,BufNewFile *.md       setfiletype markdown
autocmd BufRead,BufNewFile *.mkd      setfiletype markdown
autocmd BufRead,BufNewFile *.mkdn     setfiletype markdown
autocmd BufRead,BufNewFile *.mdown    setfiletype markdown
autocmd BufRead,BufNewFile *.markdown setfiletype markdown

" textile.vim
autocmd BufRead,BufNewFile *.textile  setfiletype textile

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1                       " 自動起動設定
let g:neocomplcache_max_list = 50                               " リスト表示件数
let g:neocomplcache_max_filename_width = 15                     " 表示文字数
let g:neocomplcache_auto_completion_start_length = 1            " リスト表示開始文字数
let g:neocomplcache_enable_underbar_completion = 1              " _ 区切りの補完を有効化
let g:neocomplcache_min_syntax_length = 3                       " シンタックスのキャッシュの最小文字長
let g:neocomplcache_enable_smart_case = 1                       " Use smartcase.
let g:neocomplcache_enable_camel_case_completion = 1            " Use camelcase.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '' ,
    \ 'php' : $HOME.'/.vim/bundle/PHP-dictionary/php.dict',
    \ 'pl' : $HOME.'/.vim/bundle/perl/perl_functions.dict',
    \ }
"" Ctrl + l で Snippet を展開
imap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)

" vim-textmanip
"" 選択したテキストの移動
vmap <C-j> <Plug>(Textmanip.move_selection_down)
vmap <C-k> <Plug>(Textmanip.move_selection_up)
vmap <C-h> <Plug>(Textmanip.move_selection_left)
vmap <C-l> <Plug>(Textmanip.move_selection_right)
"" 行の複製
vmap <M-d> <Plug>(Textmanip.duplicate_selection_v)
nmap <M-d> <Plug>(Textmanip.duplicate_selection_n)

" open-browser.vim
nmap <Space>op <Plug>(openbrowser-smart-search)
vmap <Space>op <Plug>(openbrowser-smart-search)

" quickrun
let g:quickrun_config = {}
let g:quickrun_config['*'] = {'split': 'below'}
let g:quickrun_config['markdown'] = { 'command': 'marpet', 'outputter': 'browser', 'exec': ['%c %s'], }
let g:quickrun_config['conf']     = { 'command': 'marpet', 'outputter': 'browser', 'exec': ['%c %s'], }
let g:quickrun_config['textile']  = { 'command': 'redcloth', 'outputter': 'browser', 'exec': ['%c %s'], }
let g:quickrun_config['rst']      = { 'command': 'rst2html', 'outputter': 'browser', 'tempfile': '%{tempfile()}.html', }
let g:quickrun_config['html']     = { 'command': 'google-chrome', 'outputter': 'browser', }
let g:quickrun_config['coffee']   = { 'command' : 'coffee', 'exec' : ['%c -cbp %s'] }

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_edit_action = 'split'
call vimfiler#set_execute_file('vim', 'vim')
call vimfiler#set_execute_file('txt', 'vim')
nnoremap <silent> <C-u>f :VimFilerSplit -buffer-name=explorer -split -winwidth=35 -toggle -no-quit<CR>
nnoremap <silent> <C-u>c :VimFilerClose explorer<CR>

" unite.vim
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
let g:unite_source_file_mru_filename_format = ''
let g:unite_winheight= 10

" syntastic
let g:syntastic_enable_signs  = 1
let g:syntastic_auto_loc_list = 2

" memolist.vim
"" メモを新規作成
nmap ,mc :MemoNew<CR>
"" メモ一覧
nmap ,ml :MemoList<CR>
"" メモ検索
nmap ,mg :MemoGrep<CR>
let g:memolist_path = "~/Dropbox/howm/memo"                    " ディレクトリを指定
let g:memolist_template_dir_path = "~/.vim/template/memolist"  " テンプレートファイルパス
let g:memolist_memo_suffix = "markdown"                        " ファイルタイプ
let g:memolist_memo_date = "%Y-%m-%d %H:%M"                    " 日付形式
let g:memolist_prompt_tags = 1                                 " タグ
let g:memolist_prompt_categories = 0                           " カテゴリ
let memolist_vimfiler = 1                                      " vimfiler 使用有無

" vim-indent-guides
set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

" vim-coffee-script
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!


"===============================================
" Perl
"===============================================

" perltidy
map ,pt <ESC>:%! perltidy<CR>
map ,ptv <ESC>:%'<, '>! perltidy<CR>
