# System
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias suspend='sudo pm-suspend'
alias sleepnow='pmset sleepnow'
alias c='clear'
alias e='exit'
alias ep="echo ${PATH} | sed -e $'s/:/\\\n/g'"
alias cat=bat

# Eza alias
alias ll='eza -l -s modified --no-user --icons=auto'
alias lt='eza -lTg --no-user --icons=auto'
alias lta='eza -lTag --no-user --icons=auto'
alias lt1='eza -lTg --level=1 --no-user --icons=auto'
alias lt2='eza -lTg --level=2 --no-user --icons=auto'
alias lt3='eza -ltg --level=3 --no-user --icons=auto'
alias lta1='eza -lTag --level=1 --no-user --icons=auto'
alias lta2='eza -lTag --level=2 --no-user --icons=auto'
alias lta3='eza -lTag --level=3 --no-user --icons=auto'

# Kubernetes
alias k='kubectl'
