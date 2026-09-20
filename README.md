# dotconfig

Personal configuration files for a consistent command-line and editor environment across macOS, Linux, and Windows.

The repository is designed to live directly at `~/.config`. It uses [Nova](https://github.com/zanglg/nova.nvim) as the shared color source for Neovim, tmux, WezTerm, Alacritty, and Helix.

## Contents

| Path | Description |
| --- | --- |
| `alacritty/` | Alacritty terminal configuration |
| `bat/` | `bat` defaults |
| `git/` | Git identity, aliases, editor, and global ignore rules |
| `helix/` | Helix editor configuration and Nova theme links |
| `mise/` | Development tool versions managed by `mise` |
| `neomutt/` | NeoMutt configuration template |
| `nova.nvim/` | Nova theme Git submodule and cross-application theme assets |
| `nvim/` | Neovim configuration, plugins, keymaps, and tests |
| `starship.toml` | Starship prompt configuration |
| `tmux/` | tmux behavior and custom status-line layout |
| `wezterm/` | WezTerm configuration and custom tab bar |
| `zsh/` | Zsh profile and interactive shell configuration |

## Installation

> Back up any existing configuration before replacing `~/.config`.

Clone the repository with its submodule:

```sh
git clone --recurse-submodules https://github.com/zanglg/dotconfig.git ~/.config
```

For an existing clone, initialize or repair the submodule with:

```sh
git -C ~/.config submodule update --init --recursive
```

After installing `mise`, install the command-line tools declared in `mise/config.toml`:

```sh
cd ~/.config
mise install
```

Zsh does not use the XDG configuration directory by default. Set `ZDOTDIR` early, for example in `~/.zshenv`:

```sh
export ZDOTDIR="$HOME/.config/zsh"
```

Neovim plugins are managed by the native `vim.pack` package manager and are installed from `nvim/lua/packages.lua`. Their revisions are recorded in `nvim/nvim-pack-lock.json`.

## Requirements

The configuration expects recent versions of the applications it configures. The main tools can be installed through `mise` and include:

- Neovim
- tmux
- Helix
- Starship
- `bat`, `eza`, `fd`, `fzf`, `ripgrep`, and `zoxide`
- Node.js, Python, and `uv`

Terminal configurations also expect:

- **Monaspace Argon**
- **Noto Sans CJK SC**
- A Nerd Font-compatible font for prompt and status glyphs

Applications that support XDG paths load their configuration directly from this repository once it is located at `~/.config`.

## Nova theme integration

`nova.nvim` is a first-level Git submodule and is the single source of truth for shared colors. Generated theme files are consumed directly rather than copied into application directories:

- **Neovim** prepends `~/.config/nova.nvim` to `runtimepath`.
- **tmux** sources `nova.nvim/extras/tmux/nova-dark.conf`, then applies the personal layout in `tmux/statusline.conf`.
- **WezTerm** loads its scheme from `nova.nvim/extras/wezterm/`; the custom tab bar reads semantic colors from `extras/palettes/nova.json`.
- **Alacritty** imports `nova.nvim/extras/alacritty/nova-dark.toml`.
- **Helix** uses relative symbolic links in `helix/themes/` that point to `nova.nvim/extras/helix/`.

This keeps color generation in Nova while leaving editor behavior, status-line layout, and tab-bar layout in this repository.

## Updating Nova

Update the submodule deliberately and record the selected commit in this repository:

```sh
cd ~/.config
git -C nova.nvim fetch origin
git -C nova.nvim checkout <desired-commit>
git add nova.nvim
git commit -m "chore(nova): update submodule"
```

After pulling this repository on another machine, synchronize the submodule:

```sh
git submodule update --init --recursive
```

## Validation

Useful checks after changing the configuration:

```sh
git diff --check
nvim --headless '+qa'
git submodule status
```

Validate tmux without affecting an existing server:

```sh
tmux -L config-check -f /dev/null new-session -d -s check
tmux -L config-check source-file "$PWD/tmux/tmux.conf"
tmux -L config-check kill-server
```

When WezTerm is available, validate that it can load the configuration:

```sh
wezterm --config-file "$PWD/wezterm/wezterm.lua" show-keys >/dev/null
```

## Notes

- `neomutt/neomuttrc` intentionally leaves account credentials and mailbox paths empty.
- Machine-local state, histories, sessions, and application-generated files should remain untracked.
- Do not edit generated files under `nova.nvim/extras/` from this repository; make theme-source or generator changes in the Nova repository instead.
