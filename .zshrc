# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory
setopt autocd

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Load plugin manager
source ~/antigen.zsh

# Load pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Keybinding
bindkey ";5C" forward-word # ctrl + ->
bindkey ";5D" backward-word # ctrl + <-
bindkey "^[[3;5~" backward-kill-word

# Plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zpm-zsh/clipboard
antigen apply

# Aliases - Tools
alias copy="pbcopy"
alias paste="powershell.exe -command 'Get-Clipboard' | head -n -1" # TODO move this to linux solution
# Aliases - Misc
alias hosts="code /mnt/c/Windows/System32/drivers/etc/hosts"
# Aliases - Paths
alias www="/var/www"
alias coca="/var/www/cocacola"
alias tests="/var/www/tests"
alias cwi="/var/www/cwi"
alias site="/var/www/cwi/site-2021"
alias ff="coca; frontend-framework"
alias tools="coca; coca-tools"
# Aliases - Helpers
alias trim="sed -E -e 's/^\s*|\s*$//g'"
# Aliases - Git
alias gcm="git rev-parse --abbrev-ref HEAD | trim | sed 's/\//(/g' | sed 's/$/): /g' | tr -d '\n' | copy"
alias gl="git log --pretty=oneline -n 100 --graph --abbrev-commit"
alias gadal="git add --all"
alias gst="git status"
alias gpl="git pull"
# Aliases - Python
alias create-venv="python -m venv venv"
# Aliases - Docker
alias dps="sudo docker ps"
alias ddown="sudo docker compose down"
alias dup="sudo docker compose up -d --force-recreate --remove-orphans"
