# zsh Options
setopt HIST_IGNORE_ALL_DUPS

# Secrets (interactive shells only; .zshenv is sourced from ~/.zshenv)
[ -f "$HOME/.env" ] && source "$HOME/.env"

# Custom zsh
[ -f "$HOME/.config/zsh/custom.zsh" ] && source "$HOME/.config/zsh/custom.zsh"

# Aliases
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"

# Work
[ -f "$HOME/.config/zsh/work.zsh" ] && source "$HOME/.config/zsh/work.zsh"

export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

eval "$(direnv hook zsh)"
export PATH="/Users/chammika_mannakkara/.pixi/bin:$PATH"


# bun completions
[ -s "/Users/chammika_mannakkara/.oh-my-zsh/completions/_bun" ] && source "/Users/chammika_mannakkara/.oh-my-zsh/completions/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zsh plugins (loaded directly, without oh-my-zsh). syntax-highlighting must stay last.
P="$HOME/.oh-my-zsh/custom/plugins"
[ -f "$P/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$P/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$P/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$P/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
unset P
