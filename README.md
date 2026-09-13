# dotfiles

Neovim, fish, kitty, and Git configuration for Linux, macOS, and Windows,
managed with [chezmoi](https://www.chezmoi.io). One Neovim configuration
(LazyVim with tokyonight, pinned by `lazy-lock.json`) runs unchanged on every OS.

## Setup

Install chezmoi (`pacman -S chezmoi`, `brew install chezmoi`, or
`winget install twpayne.chezmoi`), then:

```sh
chezmoi init --apply d-tecnolife/dotfiles
```

It asks no questions, so it also runs unattended (add `--no-tty` without a
terminal). On Windows, back up and remove `%LOCALAPPDATA%\nvim` first:
`chezmoi apply` links it to `~/.config/nvim`, so Neovim reads the same
configuration as everywhere else.

## Daily use

| Task | Command |
|---|---|
| Edit a file | Linux/macOS: edit `~/.config/...` directly (a symlink into the repo). Windows: `chezmoi edit <file>` |
| Apply source changes | `chezmoi apply` |
| Pull and apply updates | `chezmoi update` |
| Commit and push | `chezmoi cd`, then `git add`, `git commit`, `git push` |
| See pending changes | `chezmoi diff` |

On Linux and macOS, chezmoi runs in symlink mode, so plain files in `$HOME`
link into the repository. Scripts, executables, and everything on Windows are
copied instead. Updating plugins with `:Lazy update` rewrites `lazy-lock.json`
in the repository; commit it to move every machine to the new versions.

## Layout

`.chezmoiroot` points chezmoi at `home/`, which mirrors `$HOME`: `dot_config`
becomes `.config`, `executable_` marks an executable file, and `symlink_`
creates a symlink whose target is the file's content.

| Path under `$HOME` | Contents | Machines |
|---|---|---|
| `.config/nvim/` | Neovim (LazyVim) | All |
| `.config/git/` | Git global ignore | All |
| `.config/fish/` | Fish shell | Linux, macOS |
| `.config/kitty/` | Kitty terminal and themes | Linux, macOS |
