# zshenv

  export TERM="xterm-256color"
  export KERNEL=`uname`
  export LANG=ja_JP.UTF-8
  case ${UID} in
  0)
      LANG=C
      ;;
  esac

## .zshrc.mine configuration file

  [ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

## perlbrew configuration file

  [ -d ~/perl5 ] && source ~/perl5/perlbrew/etc/bashrc

## pythonbrew configuration file

  [ -d ~/.pythonbrew ] && source ~/.pythonbrew/etc/bashrc
  [ -d ~/.pythonbrew ] && source ~/.pythonbrew/pythons/Python-2.6.6/bin/virtualenvwrapper.sh

## phantomjs configuration file

  [ -d ~/phantomjs ] && source ~/phantomjs/bin/

## rbenv configuration file

  if [[ -d ~/.rbenv/shims ]]; then
    export PATH=${HOME}/.rbenv/shims:$PATH
    eval "$(rbenv init - zsh)"
  fi

  if [[ -d /opt/boxen/rbenv/bin ]]; then # Boxen
    export PATH=/opt/boxen/rbenv/shims:$PATH
    eval "$(rbenv init - zsh)"
  fi

## Bundlizer configuration file

  [ -d ~/.bundlizer ] && source ~/.bundlizer/etc/bashrc

## Heroku toolbelt

  export PATH="/usr/local/heroku/bin:$PATH"

## Load user $HOME/bin configuration other file

  if [[ -d ${HOME}/bin ]]; then
    export PATH=${HOME}/bin:$PATH
  fi
