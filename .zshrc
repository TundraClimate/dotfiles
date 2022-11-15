export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(
    git
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

PROMPT='%F{green}%n%F{white}@%F{cyan}%~#%F{reset-color} '
xmodmap -e "keycode 102 = Zenkaku_Hankaku"
autoload -Uz colors ; colors
export EDITOR=vim
export PATH="/usr/local/bin:$HOME/bin:$PATH"
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_param_keys
setopt print_eight_bit
setopt mark_dirs
setopt correct
setopt correct_all
setopt no_clobber
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
setopt noautoremoveslash

autoload -Uz compinit ; compinit
setopt correct
zstyle ':completion:*' menu select
setopt list_packed
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion::complete:*' use-cache true
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:manuals' separate-sections true
setopt magic_equal_subst
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000
setopt histignorealldups
setopt share_history
setopt hist_ignore_all_dups
alias h='fc -lt '%F %T' 1'
setopt inc_append_history
setopt hist_verify

if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zsh-users/zsh-autosuggestions"
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi
zplug load
