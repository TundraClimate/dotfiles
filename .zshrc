# Enviroment
export EDITOR=nvim
export PATH="/usr/local/bin:$HOME/bin:$PATH"
export LESS="-g -i -M -N -R"
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=1;33:fi=1;32:ex=4;32:ln=1;45'

# Autoload zsh-module
autoload -Uz vcs_info
autoload -Uz colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
autoload -U compinit; compinit

# Options
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

# Style
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
  /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':vcs_info:git:*' formats '%b'

# VCS
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Zsh variable
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
PROMPT='
 %F{171}fn%f %F{38}prompt%f%F{252}(%f$([ "${vcs_info_msg_0_}" != "" ] && vcs="%F{178}${vcs_info_msg_0_}%f: %F{41}Branch%f" && echo $vcs)%F{252})%f %F{034}{ %F{171}let%f %F{159}pwd%f = %F{222}"%~"%f; %F{034}}%f 
 %F{reset-color}👉 '
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# xmodmap
xmodmap -e "keycode 102 = Zenkaku_Hankaku"
xmodmap -e "keycode 49 = End"
xmodmap -e "keycode 66 = Return"

# Aliases

# Git
alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gco="git checkout"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gdf="git diff"
alias gf="git fetch"
alias glog="git log"
alias gcs="git log --oneline"
alias gmerge="git merge"
alias gpull="git pull"
alias gpush="git push origin"
alias grb="git rebase"
alias gri="git rebase -i"
alias grf="git reflog"
alias gremote="git remote"
alias gorigin="git remote add origin"
alias greset="git reset"
alias gstash="git stash"
alias gst="git status"

# Docker
alias dcon='docker container'
alias dcm='docker-compose'
alias dim='docker image'

# Other
alias .token="less $HOME/.token | clip"
alias ...='../..'
alias clip='xsel --clipboard --input'
alias f="touch"
alias fd="fd -Hi"
alias grep="rg"
alias ls="exa -al --icons"
alias mkdir="mkdir -p"
alias ps="procs"
alias q="exit"
alias vi='nvim'

# Shortcut
alias -g .files="$HOME/dotfiles/"
alias -g disps="$HOME/.local/share/applications/"
alias -g dl="$HOME/Downloads/"
alias -g idea="$HOME/MyStorage/IdeaProjects/"
alias -g steamapps="$HOME/.local/share/Steam/steamapps/common/"

# Global
alias -g C="| xsel --clipboard --input"
alias -g G="| rg"
alias -g L="| less"

# Zinit
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
cm4 () {
    from=$1
    to="${1%.*}.mp4"
    shift
    ffmpeg -i $from $@ $to
}

# dictionary sort
dsort () {
    tx=""
    for a in "$@"; do
        tx="$tx\n$a"
    done
    echo $tx | sort -f
}

# auto ls
chpwd () {
    exa -a --icons
}

# show zsh colors
zcolor () {
    for COLOR in {0..255}; do
        for STYLE in "38;5"; do 
            TAG="\033[${STYLE};${COLOR}m"
            STR="${STYLE};${COLOR}"
            echo -ne "${TAG}${STR}${NONE}  "
        done
    echo
    done
}

# rm command
rm () {
    mv -f $1 $HOME/.local/share/Trash/files/
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
