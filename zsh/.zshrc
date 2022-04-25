# set nvim as default editor
if which nvim >/dev/null; then
    export EDITOR='nvim'

    alias v='nvim'
    alias vim='nvim'
fi

if which exa >/dev/null; then
    alias l='exa'
    alias la='exa -a'
    alias ll='exa -lah'
    alias ls='exa --color=auto'
fi

if which cat >/dev/null; then
    alias cat='bat'
fi

alias c='clear'
alias g='git'
