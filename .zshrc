export EDITOR=nvim
export PATH="/usr/local/bin:$HOME/bin:$PATH"
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=1;33:fi=1;32:ex=4;32:ln=1;45'

autoload -Uz vcs_info
autoload -Uz colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
autoload -U compinit; compinit

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
setopt histverify
setopt sharehistory
setopt incappendhistory
setopt noclobber
setopt autoparamkeys
setopt printeightbit
setopt nonomatch
setopt extendedglob
setopt mark_dirs
setopt noautoremoveslash
setopt listpacked
setopt magicequalsubst
setopt promptsubst
setopt pushdignoredups
setopt nobeep
setopt transientrprompt

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
  /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':vcs_info:git:*' formats '%b'

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
PROMPT='
 %F{magenta}function%f%F{cyan}(%f%F{yellow}${vcs_info_msg_0_}%f%F{cyan})%f %F{034}{ %F{222}"%~"%f %F{034}}%f 
 %F{reset-color}👉 '
RPROMPT='⌚%F{cyan}[$(date +"%m/%d|%H:%M")]%f'
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

xmodmap -e "keycode 102 = Zenkaku_Hankaku"
xmodmap -e "keycode 49 = End"

alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gco="git checkout"
alias gc="git commit"
alias gca="git commit --amend"
alias gdf="git diff"
alias gf="git fetch"
alias glog="git log"
alias gcs="git log --oneline"
alias gmerge="git merge"
alias gpull="git pull"
alias gpush="git push"
alias grb="git rebase"
alias gri="git rebase -i"
alias grf="git reflog"
alias gremote="git remote"
alias gorigin="git remote origin"
alias greset="git reset"
alias gstash="git stash"
alias gst="git status"

alias dcon='docker container'
alias dcm='docker-compose'
alias dim='docker image'

alias .token="less ~/.token | clip"
alias ...='../..'
alias clip='xsel --clipboard --input'
alias grep="rg"
alias less="less -N"
alias ls="exa -al --icons"
alias ps="procs"
alias q="exit"
alias vi='nvim'

alias .files="~/dotfiles/"
alias dl="~/Downloads/"
alias idea="~/MyStorage/IdeaProjects/"
alias steamapps="~/.local/share/Steam/steamapps/common/"

zinit ice wait'!0'
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light chrissicool/zsh-256color
zinit light arzzen/calc.plugin.zsh
zinit light ael-code/zsh-colored-man-pages
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light QuarticCat/zsh-smartcache
zinit light brymck/print-alias
zinit light zsh-users/zsh-autosuggestions

# my cmd

# ffmpeg convert mp4 alias
function cm4 () {
    file=$1
    l=$#file
    while true; do
        flag=$file[$l]
        file=${file[1, $((l-1))]}
        l=$((l - 1))
        if [ "$flag" = "." ]; then
            break
        fi
    done
    nfile="$file.mp4"
    file=$1
    shift
    ffmpeg -i $file $@ $nfile
}

# dictionary sort
function dsort () {
    tx=""
    for a in "$@"; do
        tx="$tx\n$a"
    done
    echo $tx | sort -f
}

# auto ls
function chpwd () {
    exa -a --icons
}

# my cmd end

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

# dotnet 8
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
