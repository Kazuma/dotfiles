# set LANG
export TERM="xterm-256color"
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac


# set autoload
autoload zed
autoload history-search-end
autoload -U add-zsh-hook
autoload -U compinit && compinit
autoload -U colors && colors
autoload -Uz vcs_info && vcs_info


# set prompt configuration
zstyle ':vcs_info:*' actionformats \
    '%{$c8%}(%f%s)%{$c7%}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
    "%{$c8%}%s%%{$c7%}❨ %{$c9%}%{$c11%}%b%{$c7%} ❩%{$reset_color%}%f "
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git

add-zsh-hook precmd prompt_jnrowe_precmd

prompt_jnrowe_precmd () {
  if [ "${vcs_info_msg_0_}" = "" ]; then
      PROMPT="${fg[red]}%B%/%#%{${reset_color}%}%{${fg[yellow]}%}[ (<ゝω・)綺羅星! ]
%{${fg[green]}%}♪ "
  fi
}


# load user .zshrc.mine configuration file
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine


# load user perlbrew configuration file
[ -d ${HOME}/perl5 ] && source ${HOME}/perl5/perlbrew/etc/bashrc


# load user .zsh/ configuration other file
local source_dir=$HOME/.zsh
for source in `ls $source_dir/*.zsh`; do
    source $source
done


# screen 時に、タブに最後に打ったコマンド名を表示する
preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}


# 補完候補が多いときに尋ねる(0=自動)
LISTMAX=0


# ディレクトリ名を入力するだけでカレントディレクトリを変更
setopt auto_cd

# cd したら自動的に pushd する
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

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

# カッコの対応などを自動補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# / の2重入力を回避する
setopt auto_remove_slash

# aliased ls needs if file/dir completions work
setopt complete_aliases


# ls コマンドの補完候補にも色付き表示
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# apt-get とか dpkg コマンドをキャッシュを使って速くする
zstyle ':completion:*' use-cache true

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'

# オプション補完で解説部分を表示しない
zstyle ' :completion:*' verbose no

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin


# Command history configuration
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000                    # 記録されるコマンド履歴の数
SAVEHIST=50000                    # 保存されるコマンド履歴の数
setopt hist_ignore_dups           # 重複するコマンドが記録されている場合、古い方を削除
setopt share_history              # rootは履歴を保存しない
setopt hist_ignore_space          # スペースから始まるコマンド行はヒストリに残さない

# カーソル移動
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line       # End gets to line end
bindkey "^[[3~" delete-char       # Del

# Keybind configuration
bindkey -e

# reverse menu completion binded to Shift-Tab
bindkey "\e[Z" reverse-menu-complete


# historical backward/forward search with linehead string binded to ^P/^N
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


# Alias configuration
alias where="command -v"

alias rm="trash"                  # ファイル削除時にすぐ削除ではなく,ゴミ箱へ移動する(trash-cli 要インストール)
alias ls="ls -F --color"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias w3m="w3m http://www.google.co.jp"
alias termtter="./termtter/bin/termtter"
alias gnome-terminal="VTE_CJK_WIDTH=auto; gnome-terminal --disable-factory"


# terminal configuration
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
case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# set ssh servername on screen
function ssh_on_screen() {
    if [ $WINDOW ]; then
        cd $HOME
        eval server=\${$#}
        screen -t $server ssh "$@"
        cd -
    else
        command ssh "$@"
    fi
}

# cdd で screen の別 Window のカレントディレクトリへ移動する
function chpwd() { _reg_pwd_screennum }

# cd を実行後 ls する
function chpwd() { ls --color=auto }
