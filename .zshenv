[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Locale settings
export LANG="en_US.UTF-8" # Sets default locale for all categories
export LC_ALL="en_US.UTF-8" # Overrides all other locale settings
export LC_CTYPE="en_US.UTF-8" # Controls character classification and case conversion

# Use Neovim as default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Add /usr/local/bin to the beginning of the PATH environment variable.
# This ensures that executables in /usr/local/bin are found before other directories in the PATH.
export PATH="/usr/local/bin:$PATH"

# Only allow unique entries in the PATH variable
# Add ~/.local/bin and ~/bin to the PATH variable
path+=(
  "/opt/homebrew/opt/node@22/bin"
  "${HOME}/bin"
  "${HOME}/.local/bin"
)

# Remove duplicates from the PATH variable
typeset -U path

export TMPDIR="${HOME}/.tmp"
