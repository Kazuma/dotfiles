" vundle の設定
set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

" Bundle
Bundle 'gtd'
Bundle 'tags'
Bundle 'perl'
Bundle 'jQuery'
Bundle 'qfixapp'
Bundle 'vim-ref'
Bundle 'pathogen'
Bundle 'auto_mkdir'
Bundle 'quicklaunch'
Bundle 'vim-markdown'
Bundle 'neocomplcache'
Bundle 'PHP-dictionary'
Bundle 'GoogleSuggest-Complete'
Bundle 'bw.vim'
Bundle 'php.vim'
Bundle 'perl.vim'
Bundle 'unite.vim'
Bundle 'calendar.vim'
Bundle 'quickrun.vim'
Bundle 'javascript.vim'
Bundle 'googletasks-vim'
Bundle 'GoogleReader.vim'
Bundle 'howm-calendar.vim'
Bundle 'git://github.com/mattn/webapi-vim.git'

" ソフトタブの設定
set expandtab

" ファイル中の<TAB>文字を指定文字分で表示する
set tabstop=4

" vim が挿入するインデントやシフトオペレータで挿入/削除されるインデントの幅
set shiftwidth=4

" <TAB>を押した時に挿入される空白数
set softtabstop=4

" インデントを使えるようにする
filetype indent on

" スマートインデントを有効にする
set smartindent

" if(){} などのインデント
set cindent

" 入力中のコマンドをステータス行に表示
set showcmd

" ステータスラインを常に表示
set laststatus=2

" ステータスラインに表示する情報の指定
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%{synIDattr(synID(line('.'),col('.'),1),'name')}\ %l/%L(%P)%m

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" テキストの1行最大数を無効にする
set textwidth=0

" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" マウスを使用可能にする
set mouse=a

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

" 折りたたみの情報を保存
set viewdir=~/.vim/view

" 折りたたみの情報を自動で保存・読込
autocmd BufWritePost * :mkview
autocmd BufReadPost * :loadview

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

" Enterを押したときに補完のポップアップを消す
inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>":"\<CR>"

" プラグインを使えるようにする
filetype plugin on

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
 
" 画面分割時に自動で幅を決める
nnoremap <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<Cr>
function! s:good_width()
    if winwidth(0) < 84
        vertical resize 84
    endif
    endfunction

" 行末の不要なスペースを削除する
function! RTrim()
%s/\s\+$//e
endfunction
autocmd BufWritePre *.php,*.rb,*.js,*.tpl,*.ihtml,*.bat,*.pl,*.pm call RTrim()

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/

" マッチ文字列が画面の真ん中にくるようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"バッファを開いた時に、カレントディレクトリを自動で移動
":au BufEnter *.pl,*.pm,*.cgi,*.yaml,*.json,*.txt,*.tt execute ":lcd " .
"expand("%:p:h")


"===============================================
" Plugin
"===============================================

" Markdown の拡張子設定
autocmd BufRead,BufNewFile *.md       setfiletype mkd
autocmd BufRead,BufNewFile *.mkd      setfiletype mkd
autocmd BufRead,BufNewFile *.mkdn     setfiletype mkd
autocmd BufRead,BufNewFile *.mdown    setfiletype mkd
autocmd BufRead,BufNewFile *.markdown setfiletype mkd

" qfixapp の設定
set runtimepath+=~/.vim/bundle/qfixapp/ftplugin/qfixapp          " qfixapp に runtimepath を通す
let QFixHowm_Key = 'g'                                           " キーマップリーダー
let QFixHowm_RootDir = '~/Dropbox/howm'                          " howm_dir ルートディレクトリ
lef howm_dir = '~/Dropbox/howm'                                  " howm_dir ホームディレクトリ
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M.howm'                   " ファイル名
let QFixHowm_DiaryFile = 'Diary/%Y/%m/%Y-%m-%d-000000.howm'      " 日記ファイル名
let howm_fileencoding = 'utf-8'                                  " 文字コード
let MyGrep_ShellEncoding = 'utf-8'                               " シェルの文字コード
let howm_fileformat = 'unix'                                     " ファイルフォーマット
let mygrepprg = 'grep'                                           " 内蔵 grep
let QFixHowm_SchedulePreview = 0                                 " 予定・TODO でのプレビュー表示 ON/OFF
let QFixHowm_ReminderSortMode = 1                                " 予定・TODOソートの昇順/降順
let QFixHowm_VimEnterCmd = 'y'                                   " 初回起動時に実行したいコマンド
let QFixHowm_VimEnterMsg = '今日の予定です'                      " 自動起動コマンド表示の確認用メッセージ
let QFixHowm_VimEnterFile = '~/Dropbox/howm/.vimenter.qf'        " 初回起動時間を保存するファイル名
let SubWindow_Title = '~/__submenu__.howm'                       " サブメニューで表示するファイル名
let SubWindow_Width = 30                                         " サブメニューの幅指定
let QFixHowm_ShowTodayLine = 2                                   " 予定や TODO に現在日付行や現在時刻行、境界行を表示する
let QFixHowm_RemovePriority  = -1                                " アクティブ化されていない予定や TODO を表示
let QFixHowm_FoldingPattern = '^[=.*[]'                          " 折りたたみのパターン
let QFixHowm_Folding = 0                                         " 折りたたみを(有効:1, 無効:0)にする
" 予定・TODOのソート優先度
let QFixHowm_ReminderPriority = {'@' : 1, '!' : 1, '+' : 3, '-' : 4, '~' : 5, '.' : 6}
" 休日名
let QFixHowm_ReminderHolidayName = '元日\|成人の日\|建国記念の日\|昭和の日\|憲法記念日\|みどりの日\|こどもの日\|海の日\|敬老の日\|体育の日\|文化の日\|勤労感謝の日\|天皇誕生日\|春分の日\|秋分の日\|振替休日\|国民の休日\|土曜日\|日曜日'
" 曜日を日本語表示
let QFixHowm_DayOfWeekDic = {'Sun' : "日", 'Mon' : "月", 'Tue' : "火", 'Wed' : "水", 'Thu' : "木", 'Fri' : "金", 'Sat' : "土"}
let QFixHowm_DayOfWeekReg = "\(日\|月\|火\|水\|木\|金\|土\)"

" calendar.vim の設定
nnoremap g,q :Calendar<CR>
let calendar_action = "QFixHowmCalendarDiary"
let calendar_sign   = "QFixHowmCalendarSign"

" Neocomplcache の設定
let g:neocomplcache_enable_at_startup = 1                       " Neocomplcache の自動起動設定
let g:neocomplcache_max_list = 50                               " Neocomplcache のリスト表示件数
let g:neocomplcache_max_filename_width = 15                     " Neocomplcache の表示文字数
let g:neocomplcache_auto_completion_start_length = 1            " Neocomplcache のリスト表示開始文字数
let g:neocomplcache_enable_smart_case = 1                       " Use smartcase.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '' ,
    \ 'php' : $HOME.'/.vim/bundle/PHP-dictionary/php.dict'
    \ }

" GoogleReader.vim の設定
let g:googlereader_email = 'muramatu.k@gmail.com'
let g:googlereader_passwd = '*****'


"===============================================
" PHP
"===============================================

" php の関数辞書
autocmd FileType php  :set dictionary=~/.vim/bundle/php/dict/php.dict
autocmd FileType php  :nmap ,l :call PHPLint()<CR>

function PHPLint()
    let result = system( &ft . ' -l ' . bufname(""))
        echo result
endfunction


"===============================================
" Perl
"===============================================

" perltidy
map ,pt <ESC>:%! perltidy<CR>
map ,ptv <ESC>:%'<, '>! perltidy<CR>
" Perl 辞書ファイル読み込み
autocmd FileType perl :set dictionary+=~/.vim/bundle/perl/dict/perl_functions.dict
