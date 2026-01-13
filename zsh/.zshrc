# zsh-autocomplete
if [ -f /usr/local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
	source /usr/local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

# mise package manager
if which mise >/dev/null; then
	eval "$(mise activate zsh)"
fi

# set nvim as default editor
if which nvim >/dev/null; then
	export EDITOR='nvim'

	alias v='nvim'
	alias vim='nvim'
fi

# A modern replacement for ‘ls’
if which eza >/dev/null; then
	alias ls='eza'
	alias  l='eza -l'
	alias la='eza -la'
	alias lh='eza -lh'
	alias ll='eza -lah'
	alias lt='eza -lah --tree'
fi

# A smarter cd command.
if which zoxide >/dev/null; then
	eval "$(zoxide init zsh)"
fi

# ✨ Magical shell history
if which atuin >/dev/null; then
	export ATUIN_NOBIND="true"
	eval "$(atuin init zsh)"
	bindkey '^r' atuin-search
fi

# A customizable prompt for shell
if which starship >/dev/null; then
	eval "$(starship init zsh)"
fi

# Rust task runner and build tool.
if which cargo-make >/dev/null; then
	alias cm='cargo make'
fi

# 🌸 A command-line fuzzy finder
if which fzf >/dev/null; then
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
