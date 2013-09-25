# zshenv

  export TERM="xterm-256color"
  export KERNEL=`uname`
  export LANG=ja_JP.UTF-8
  case ${UID} in
  0)
      LANG=C
      ;;
  esac

## WebMagic ENV

  export WEBMAGIC_SRC_PATH=${HOME}/webmagic-dev/webmagic

## load user .zshrc.mine configuration file

  [ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

## load user perlbrew configuration file

  [ -d ~/perl5 ] && source ~/perl5/perlbrew/etc/bashrc

## load user pythonbrew configuration file

  [ -d ~/.pythonbrew ] && source ~/.pythonbrew/etc/bashrc
  [ -d ~/.pythonbrew ] && source ~/.pythonbrew/pythons/Python-2.6.6/bin/virtualenvwrapper.sh

## load user phantomjs configuration file

  [ -d ~/phantomjs ] && source ~/phantomjs/bin/

## load user rbenv configuration file

  if [[ -d ~/.rbenv/bin ]]; then # Ubuntu
    export PATH=${HOME}/.rbenv/bin:$PATH
    eval "$(rbenv init - zsh)"
  fi

## load user bundlizer configuration file

  [ -d ~/.bundlizer ] && source ~/.bundlizer/etc/bashrc

## load user $HOME/bin configuration other file

  if [[ -d ${HOME}/bin ]]; then
    export PATH=${HOME}/bin:$PATH
  fi
