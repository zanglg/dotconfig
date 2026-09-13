# zsh-autocomplete
if [ -f /usr/local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
	source /usr/local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

# mise package manager
if command -v mise >/dev/null 2>&1; then
	eval "$(mise activate zsh)"
fi

# set nvim as default editor
if command -v nvim >/dev/null 2>&1; then
	export EDITOR='nvim'

	alias v='nvim'
	alias vim='nvim'
fi

# A modern replacement for ‘ls’
if command -v eza >/dev/null 2>&1; then
	alias ls='eza'
	alias  l='eza -l'
	alias la='eza -la'
	alias lh='eza -lh'
	alias ll='eza -lah'
	alias lt='eza -lah --tree'
fi

# A smarter cd command.
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
fi

# A customizable prompt for shell
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init zsh)"
fi

# Rust task runner and build tool.
if command -v cargo-make >/dev/null 2>&1; then
	alias cm='cargo make'
fi

# 🌸 A command-line fuzzy finder
if command -v fzf >/dev/null 2>&1; then
	export FZF_DEFAULT_OPTS="\
		--border --height 40% --reverse"
	export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }--color=fg:#b6bac9,fg+:#b6bac9,bg:#1c2131,bg+:#2d354e,hl:#afcf59,hl+:#d49d5e,info:#6c7693,marker:#68bb6c,prompt:#5e8eed,spinner:#56b6c2,pointer:#66becc,header:#8f79d2,border:#323c57,label:#6c7693,query:#b6bac9,gutter:#1c2131,preview-border:#323c57,list-border:#323c57,input-border:#323c57,header-border:#323c57"
	source <(fzf --zsh)
fi

# helper
alias c='clear'
alias g='git'
alias q='exit'
