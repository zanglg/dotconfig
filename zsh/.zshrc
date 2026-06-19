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

# ✨ Magical shell history
if command -v atuin >/dev/null 2>&1; then
	export ATUIN_NOBIND="true"
	eval "$(atuin init zsh)"
	bindkey '^r' atuin-search
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
		--color=border:bright-black --border\
		--color=bg:black,bg+:bright-black,fg:white,fg+:bright-white\
		--color=header:red,info:yellow,hl:blue,hl+:cyan\
		--color=pointer:red,prompt:magenta,info:yellow,marker:green\
		--height 40% --reverse"
fi

# helper
alias c='clear'
alias g='git'
alias q='exit'
