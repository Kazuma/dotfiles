# zshenv

  export TERM="xterm-256color"
  export KERNEL=`uname`
  export LANG=ja_JP.UTF-8
  case ${UID} in
  0)
      LANG=C
      ;;
  esac

## load user .zshrc.mine configuration file

  [ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

## load user perlbrew configuration file

  [ -d ${HOME}/perl5 ] && source ${HOME}/perl5/perlbrew/etc/bashrc

## load user pythonbrew configuration file

  [ -d ${HOME}/.pythonbrew ] && source ${HOME}/.pythonbrew/etc/bashrc
  [ -d ${HOME}/.pythonbrew ] && source ${HOME}/.pythonbrew/pythons/Python-2.6.6/bin/virtualenvwrapper.sh

## load user phantomjs configuration file

  [ -d ${HOME}/phantomjs ] && source ${HOME}/phantomjs/bin/

## load user rbenv configuration file

  if [[ -d $HOME/.rbenv/bin ]]; then # Ubuntu
    export PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init - zsh)"
  elif type rbenv &> /dev/null; then # Homebrew on OSX
    eval "$(rbenv init - zsh)"
    source /usr/local/Cellar/rbenv/0.3.0/completions/rbenv.zsh
  fi

## load user bundlizer configuration file

  [ -d ${HOME}/.bundlizer ] && source ${HOME}/.bundlizer/etc/bashrc

## load user bin/ configuration other file

  local source_dir=${HOME}/bin

## source auto-fu.zsh

  if [ -f $HOME/.zsh/auto-fu.zsh/auto-fu.zsh ]; then
      source ~/.zsh/auto-fu.zsh/auto-fu.zsh
      function zle-line-init () {
          auto-fu-init
      }
      zle -N zle-line-init
  fi

## source zsh-syntax-highlighting.zsh

  if [ -f $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
      source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
