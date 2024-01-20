# homebrew
if [[ $(uname) == "Darwin" ]]; then
	export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
	if [ -f /usr/local/Homebrew/bin/brew ]; then
		eval $(/usr/local/Homebrew/bin/brew shellenv)
	fi
fi

# rust toolchain
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
if [ -f "$HOME/.cargo/env" ]; then
	source "$HOME/.cargo/env"
fi

# add local executable to PATH
if [ -d "$HOME/.local/bin" ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# override default TERM
export TERM=xterm-256color
