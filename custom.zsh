# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1

# OH MY ZSH (disabled while trying starship; uncomment and remove starship line below to revert)
# [ -f "$HOME/.config/zsh/oh-my-zsh.zsh" ] && source "$HOME/.config/zsh/oh-my-zsh.zsh"

# Starship prompt
eval "$(starship init zsh)"

# Emacs keybindings (Ctrl+A/E/K...); zsh defaults to vi mode since EDITOR=nvim
bindkey -e

# ls / completion colors (same values oh-my-zsh used)
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Make comment lines visible (Kanagawa theme)
# ZSH_HIGHLIGHT_STYLES[comment]='fg=245,bold'

# fzf
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

export FZF_DEFAULT_OPTS='--reverse --border --exact --height=50%'
export FZF_ALT_C_COMMAND='fd --type directory'
[[ $OSTYPE =~ ^darwin.* ]] && export FZF_CTRL_T_COMMAND="mdfind -onlyin . -name ."

# libpq is keg-only
# Need to explicitly included in the path
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Docker completions
FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit

# sccache for rust
export RUSTC_WRAPPER=sccache

# Eza path for themes
export EZA_CONFIG_DIR="$HOME/.config/eza/"

# zoxide
eval "$(zoxide init zsh)"

# kubecolor
alias kubectl=kubecolor

# Ctrl+G: fzf picker over all Claude Code sessions (name | folder); cd there and resume
_claude_sessions() {
  # one grep over all transcripts; title priority: customTitle > agentName > aiTitle > short id
  local files=(~/.claude/projects/*/*.jsonl(om)) open= j
  # ponytail: ~/.claude/sessions/<pid>.json is undocumented Claude Code state; revisit if it moves
  for j in ~/.claude/sessions/*.json(N); do
    kill -0 ${${j:t}%.json} 2>/dev/null && open+=" $(grep -o '"sessionId":"[^"]*"' $j | head -1 | cut -d'"' -f4)"
  done
  grep -o -E '"(customTitle|agentName|aiTitle|cwd|gitBranch)":"[^"]*"' $files 2>/dev/null |
    awk -v home="$HOME" -v now="$(date +%s)" -v open="$open " '
      FNR == NR { mt[substr($0, index($0, " ") + 1)] = $1; next }
      { f = $0; sub(/:"[a-zA-Z]+":".*$/, "", f); split($0, a, "\""); k = a[2]; v = a[4]
        if (!(f in seen)) { seen[f] = 1; order[++n] = f }
        if (k == "cwd") { if (!(f in cwd)) cwd[f] = v } else if (v != "" && v != "HEAD") t[f, k] = v }
      END { for (i = 1; i <= n; i++) { f = order[i]; if (!(f in cwd)) continue
        id = f; sub(/.*\//, "", id); sub(/\.jsonl$/, "", id)
        if (id in shown) continue; shown[id] = 1   # same session copied into another project dir
        name = t[f, "customTitle"]; if (name == "") name = t[f, "agentName"]
        if (name == "") name = t[f, "aiTitle"]; if (name == "") name = substr(id, 1, 8)
        d = cwd[f]; if (index(d, home) == 1) d = "~" substr(d, length(home) + 1)
        s = now - mt[f]
        age = s < 3600 ? int(s / 60) "m" : s < 86400 ? int(s / 3600) "h" : s < 604800 ? int(s / 86400) "d" : int(s / 604800) "w"
        printf "%s %-8s  %-45.45s  %-30.30s  %s\t%s\t%s\n", (index(open, " " id " ") ? "●" : " "), age " ago", name, d, t[f, "gitBranch"], id, cwd[f] } }' <(stat -f '%m %N' $files) -
}
claude-session-widget() {
  local sel
  sel=$(_claude_sessions | fzf --delimiter='\t' --with-nth=1 --border=rounded --border-label=' ● = open in another window (resumes as fork) ' --border-label-pos=0:bottom --header='  age       session                                        folder                          branch' --height=40% --reverse \
    --bind 'start:unbind(j,k,i,q)' \
    --bind 'esc:rebind(j,k,i,q)+change-prompt([browse] j/k move, i search, q quit > )' \
    --bind 'j:down,k:up,q:abort' \
    --bind 'i:unbind(j,k,i,q)+change-prompt(> )') || { zle reset-prompt; return }
  BUFFER="cd ${(q)${sel##*$'\t'}} && claude -r ${${sel#*$'\t'}%%$'\t'*}"
  [[ $sel == ●* ]] && BUFFER+=" --fork-session"
  zle accept-line
}
zle -N claude-session-widget
bindkey '^G' claude-session-widget
