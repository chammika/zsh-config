# zsh-config

Personal zsh config with a starship prompt. Live at `~/.config/zsh` via symlink:

```sh
git clone git@github.com:chammika/zsh-config.git ~/misc/zsh-config
ln -s ~/misc/zsh-config ~/.config/zsh
ln -s ~/.config/zsh/.zshrc ~/.zshrc
ln -s ~/misc/zsh-config/starship.toml ~/.config/starship.toml
printf '[ -f "$HOME/.config/zsh/.zshenv" ] && source "$HOME/.config/zsh/.zshenv"\n' > ~/.zshenv
```

## Load order

| File | When | Contents |
|---|---|---|
| `~/.zshenv` | every zsh | one line sourcing `.zshenv` here |
| `.zshenv` | every zsh | cargo, locale, `EDITOR`, `PATH`, `TMPDIR` |
| `.zshrc` | interactive | `~/.env` secrets, then `custom.zsh`, `aliases.zsh`, `work.zsh`, plugins |
| `custom.zsh` | interactive | brew, starship, fzf, completions, zoxide, Claude session picker (`Ctrl+G`) |
| `aliases.zsh` | interactive | aliases |

## Local-only files (not in the repo)

- `~/.env`: secrets
- `work.zsh`: company setup (gcloud, Netskope certs), gitignored and skipped if missing
