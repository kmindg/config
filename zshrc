source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

#zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:path color cyan

#export PATH=$PATH
export EDITOR='vim'
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt extended_history
setopt inc_append_history_time
setopt hist_find_no_dups
setopt interactive_comments

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias gst="git status"
alias gsb="git status -sb"
alias gf="git fetch"
alias gco="git checkout"
alias gl="git log"
alias gd="git diff"
alias gdca="git diff --cached"
alias gb="git branch"
alias ll="ls -lh"

PURE_GIT_PULL=0

# autocomplete from middle of directory name
# https://unix.stackexchange.com/questions/259287/how-can-i-get-zshs-completion-working-in-the-middle-of-the-filename
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
# git completion
autoload -Uz compinit && compinit

# See https://github.com/jeffreytse/zsh-vi-mode/issues/24
# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
    ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
ZVM_CURSOR_STYLE_ENABLED=false

# Disable bracketed paste in tmux to avoid paste issue, see https://github.com/tmux/tmux/issues/223
if [[ ${TMUX} ]]; then
    unset zle_bracketed_paste
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

precmd() {
    echo -n -e "\a" >$TTY
}
