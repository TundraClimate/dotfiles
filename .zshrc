export EDITOR=vi
export PATH="/usr/local/bin:$HOME/bin:$PATH"
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=1;33:fi=1;32:ex=4;32:ln=1;45'

setopt autocd
setopt autopushd
setopt alwaystoend
setopt globcomplete
setopt completeinword
setopt menucomplete
setopt histfcntllock
setopt histignorealldups
setopt histignorespace
setopt histreduceblanks
setopt histsavenodups
setopt sharehistory
setopt noclobber
setopt autoparamkeys
setopt printeightbit
setopt nonomatch
setopt extendedglob
setopt mark_dirs
setopt noautoremoveslash
setopt listpacked
setopt inc_append_history
setopt hist_verify
setopt magicequalsubst
setopt promptsubst
setopt pushdignoredups
setopt nobeep

autoload -Uz vcs_info
autoload -Uz colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
autoload -U compinit; compinit

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
  /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':vcs_info:git:*' formats '%b'

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
PROMPT='%F{cyan}%n %F{034}{ %~ }%f %F{yellow}${vcs_info_msg_0_}%k
%F{reset-color}%# '
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

xmodmap -e "keycode 102 = Zenkaku_Hankaku"
xmodmap -e "keycode 49 = End"

alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gpush='git push'
alias gmerge='git merge'
alias gco='git checkout'
alias gb='git branch'
alias gfetch='git fetch'
alias gpull='git pull'
alias grebase='git rebase'
alias gremote='git remote'
alias greset='git reset'
alias gref='git reflog'
alias glog='git log'
alias gstash='git stash'
alias gstatus='git status'
alias gdiff='git diff'

alias dim='docker image'
alias dcon='docker container'
alias dcm='docker-compose'

alias clip='xsel --clipboard --input'
alias vi='nvim'
alias vim='nvim'

zinit ice wait'!0'
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light babarot/enhancd

# pnpm
export PNPM_HOME="/home/tundra/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
