######################################
## Environment variable configuration#
######################################
# LANG
#
export TERM="xterm-256color"
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac


## Default shell configuration
#
# set prompt
#
autoload -U colors
colors
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[DarkRed]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# screen時に、タブに最後に打ったコマンド名を表示する
preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}



# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動
#dload zsh/complist
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char


# ディレクトリ名を入力するだけでカレントディレクトリを変更
setopt auto_cd

# 移動した場所を記録し、cd -[TAB] で以前移動したディレクトリの候補を表示。
# 番号を入力することで移動できる。
setopt auto_pushd

# 補完時にスペルチェック
#setopt auto_correct          

# 自動修正機能(候補を表示)
setopt correct

# 補完候補を積めて表示
setopt list_packed

# パスの最後に付くスラッシュを自動的に削除しない
setopt noautoremoveslash

# タブキー連打で補完候補を純に表示
setopt auto_menu

# 補完候補一覧でファイルの種別を識別マーク表示(ls -Fの記号)
setopt list_types

# lsコマンドの補完候補にも色付き表示
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# killの候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# apt-get とかdpkgコマンドをキャッシュを使って速くする
zstyle ':completion:*' use-cache true

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'

# オプション補完で解説部分を表示しない
zstyle ' :completion:*' verbose no

# = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt magic_equal_subst

# ビープ音を消す
setopt no_beep

# 補完候補表示時などにビープ音を鳴らさない
setopt nolistbeep

# 補完候補リストの日本語を正しく表示
setopt print_eight_bit

# rm * を実効する前に確認する
setopt rmstar_wait

# バックグラウンドを高速に
setopt NOBGNICE

# 単語の途中で補完
setopt COMPLETE_IN_WORD

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups      

# 重複するコマンドが保存されるとき、古い方を削除する
setopt hist_save_no_dups

# 補完候補が多いときに尋ねる(0=自動)
LISTMAX=0

## Keybind configuration
# Emacsライクキーバインド
bindkey -e

# カッコの対応などを自動補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash



bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete


## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000              # 記録されるコマンド履歴の数
SAVEHIST=50000              # 保存されるコマンド履歴の数
setopt hist_ignore_dups     # 重複するコマンドが記録されている場合、古い方を削除
setopt share_history        # rootは履歴を保存しない

## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})

# 標準の補完設定
autoload -U compinit
compinit

# zsh editor
autoload zed

## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"
alias w3m="w3m http://www.google.co.jp"
alias termtter="./termtter/bin/termtter"


## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm|xterm-color)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

function ssh_screen(){
 eval server=?${$#}
  screen -t $server ssh "$@"
}
if [ x$TERM = xscreen ]; then
  alias ssh=ssh_screen
fi

if [ "$TERM" = "screen" ]; then
  precmd(){print -n '\ek\e\\'}
fi


## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

