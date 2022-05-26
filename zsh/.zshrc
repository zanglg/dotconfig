# set nvim as default editor
if which nvim >/dev/null; then
    export EDITOR='nvim'

    alias v='nvim'
    alias vim='nvim'
fi

# A modern replacement for ‘ls’
if which exa >/dev/null; then
    alias l='exa'
    alias la='exa -a'
    alias ll='exa -lah'
    alias ls='exa --color=auto'
fi

# A cat(1) clone with wings
if which cat >/dev/null; then
    alias cat='bat'
fi

# Rust task runner and build tool.
if which cargo-make >/dev/null; then
    alias cm='cargo make'
fi

# helper
alias c='clear'
alias g='git'
alias q='exit'
