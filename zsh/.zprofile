# homebrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles
if [[ `uname` == "Darwin" ]]; then
    if [ ! -f /usr/local/Homebrew/bin/brew ]; then
        eval $(/usr/local/Homebrew/bin/brew shellenv)
    fi
fi

# rust toolchain
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi