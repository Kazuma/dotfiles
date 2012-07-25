# zshrc

## set autoload

  autoload zed
  autoload history-search-end
  autoload -U add-zsh-hook
  autoload -U compinit && compinit
  autoload -U colors && colors
  autoload -Uz vcs_info && vcs_info


## set prompt configuration

  zstyle ':vcs_info:*' enable git svn
  zstyle ':vcs_info:*' actionformats '%{'${fg[blue]}'%}(%s)-[%b|%a][%r] %c%u'
  zstyle ':vcs_info:*' formats '%{'${fg[cyan]}'%}(%s)-[%b][%r] %{'${fg[green]}'%}%c%{'${fg[red]}'%}%u'
  zstyle ':vcs_info:*' user-simple true
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr ✔
  zstyle ':vcs_info:git:*' unstagedstr ✘
  zstyle ':vcs_info:svn:*' branchformat '%b:r%r'

  PROMPT_USERHOST='%{'${fg[red]}'%}[%m]%{'${reset_color}'%}'
  PROMPT_KAOMOJI='%{'${fg[yellow]}'%}[ :-D ]'
  PROMPT_STATUS='%{'${fg[green]}'%}[%B%/%#]%{'${reset_color}'%}'
  PROMPT_INPUT_LINE='%{'${fg[green]}'%}✈ '
  CODE_TOP='%{'${fg[white]}'%}╭ '
  CODE_BOTTOM='%{'${fg[white]}'%}╰ '

  if which rbenv &> /dev/null; then
      RUBY_VERSION="%{$fg[magenta]%}[$(rbenv version | sed -e 's/ (set.*$//')]"
  fi

  prompt_precmd () {
      LANG=en_US.UTF-8 vcs_info 
      PROMPT="$CODE_TOP$PROMPT_USERHOST$PROMPT_KAOMOJI$PROMPT_STATUS$RUBY_VERSION$vcs_info_msg_0_
$CODE_BOTTOM$PROMPT_INPUT_LINE"
  }

  add-zsh-hook precmd prompt_precmd


## screen 時に、タブに最後に打ったコマンド名を表示する

  preexec () {
    [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
  }

## 補完候補が多いときに尋ねる(0=自動)

  LISTMAX=0


## setopt

  setopt auto_cd                          ### ディレクトリ名を入力するだけでカレントディレクトリを変更
  setopt auto_menu                        ### タブキー連打で補完候補を順に表示
  setopt auto_pushd                       ### cd したら自動的に pushd する
  setopt auto_param_keys                  ### カッコの対応などを自動補完
  setopt auto_param_slash                 ### 末尾の / を自動的に付加し、次の補完に備える
  setopt auto_remove_slash                ### / の2重入力を回避する
  setopt complete_aliases                 ### aliased ls needs if file/dir completions work
  setopt complete_in_word                 ### 単語の途中で補完
  setopt correct                          ### 自動修正機能(候補を表示)
  setopt hist_ignore_dups                 ### 直前と同じコマンドラインはヒストリに追加しない
  setopt hist_ignore_space                ### スペースから始まるコマンド行はヒストリに残さない
  setopt hist_reduce_blanks               ### ヒストリに保存する時に余分なスペースを削除する
  setopt hist_save_nodups                 ### 重複するコマンドが保存されるとき、古い方を削除する
  setopt list_types                       ### 補完候補一覧でファイルの種別を識別マーク表示(ls -Fの記号)
  setopt list_packed                      ### 補完候補を積めて表示
  setopt magic_equal_subst                ### = 以降でも補完できるようにする( --prefix=/usr 等の場合)
  setopt nobgnice                         ### バックグラウンドを高速に
  setopt nolistbeep                       ### 補完候補表示時などにビープ音を鳴らさない
  setopt no_beep                          ### ビープ音を消す
  setopt no_flow_control                  ### フローコントロールを無効にする
  setopt print_eight_bit                  ### 補完候補リストの日本語を正しく表示
  setopt pushd_ignore_dups                ### 重複したディレクトリを追加しない
  setopt rmstar_wait                      ### rm * を実効する前に確認する
  setopt share_history                    ### root は履歴を保存しない
  #setopt noautoremoveslash               ### パスの最後に付くスラッシュを自動的に削除しない


## 補完

  zstyle ':completion:*' verbose no                                ### オプション補完で解説部分を表示しない
  zstyle ':completion:*' use-cache true                            ### キャッシュを使って速くする
  zstyle ':completion:*' list-separator '-->'                      ### セパレータを設定する
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'              ### 補完の時に大文字小文字を区別しない
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}    ### ls コマンドの補完候補にも色付き表示
  ### kill の候補にも色付き表示
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
  ### sudo の後ろでコマンド名を補完する
  zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin


## 履歴

  HISTFILE=${HOME}/.zsh_history
  HISTSIZE=50000               
  SAVEHIST=50000               


## bindkey

  bindkey "^[[1~" beginning-of-line                                ### Home gets to line head
  bindkey "^[[4~" end-of-line                                      ### End gets to line end
  bindkey "^[[3~" delete-char                                      ### Del
  bindkey -e                                                       ### Keybind configuration
  bindkey "\e[Z" reverse-menu-complete                             ### reverse menu completion binded to Shift-Tab
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  bindkey "^p" history-beginning-search-backward-end
  bindkey "^n" history-beginning-search-forward-end
  bindkey "\\ep" history-beginning-search-backward-end
  bindkey "\\en" history-beginning-search-forward-end


## Alias configuration

  alias where="command -v"

  if [ $KERNEL = Linux ]; then

      alias rm="trash" ### ファイル削除時にすぐ削除ではなく,ゴミ箱へ移動する(trash-cli 要インストール)

      alias ls="ls -F --color"
      alias du="du -h"
      alias df="df -h"
      alias su="su -l"
      alias w3m="w3m http://www.google.co.jp"
      alias termtter="./termtter/bin/termtter"
      alias gnome-terminal="VTE_CJK_WIDTH=auto; gnome-terminal --disable-factory"
      alias git='hub'
      alias s4='sshfs wm4-dev.es.occ.co.jp: /home/kazuma/mnt/wm4-dev -o workaround=rename -o follow_symlinks -o Cipher=arcfour256'

  elif [ $KERNEL = Darwin ]; then

      export LSCOLORS=gxfxcxdxbxegedabagacad
      export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
      zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
      alias ls="ls -G"

      alias safari="open -a Safari"
      alias chrome="open -a Chrome"

  fi


## terminal configuration

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


## set terminal title including current directory

  case "${TERM}" in
  xterm|xterm-color|kterm|kterm-color)
      precmd() {
          echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
      }
      ;;
  esac
