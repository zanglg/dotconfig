# homebrew
export 'HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles'
if [[ `uname` == "Darwin" ]]; then
    if [ ! -f /usr/local/Homebrew/bin/brew ]; then
        eval $(/usr/local/Homebrew/bin/brew shellenv)
    fi
fi

# rust toolchain
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

