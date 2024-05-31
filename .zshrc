# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory
setopt autocd

# Custom prompt configuration
display_git_branch() {
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo " %F{blue}\ue725 $branch"
  fi
}

display_node_version() {
  if [ -f package.json ]; then
    node_version="$(node -v)"
    echo " %F{green}\ued0d $node_version"
  fi
}

PROMPT='%B%F{green}$(pwd)%b$(display_git_branch)$(display_node_version)
%}%F{white}$ %b%f%k'

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

# Python
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Keybinding
bindkey ";5C" forward-word # ctrl + ->
bindkey ";5D" backward-word # ctrl + <-
#bindkey "^[[3;5~" backward-kill-word # ctrl + backspace (WSL)
bindkey "^H" backward-kill-word # ctrl + backspace (Ubuntu)

# Plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zpm-zsh/clipboard
antigen apply

# Aliases - Tools
alias copy="xsel -ib"
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
alias gcb="git checkout -b"
alias gcm="git rev-parse --abbrev-ref HEAD | trim | sed 's/\//(/g' | sed 's/$/): /g' | tr -d '\n' | copy"
alias gl="git log --pretty=oneline -n 100 --graph --abbrev-commit"
alias gadal="git add --all"
alias gst="git status"
alias gpl="git pull"
# Aliases - Python
alias create-venv="python -m venv venv"
alias website="python run.py website"
alias admin="python run.py admin"
# Aliases - Docker
alias dps="docker ps"
alias ddown="docker compose down"
alias dup="docker compose up -d --force-recreate --remove-orphans"

# Dynamic aliases
for folder in /var/www/cocacola/*; do
  base_folder=$(echo $folder | sed 's/.*\///')
  subfolders=$(ls $folder)
  folder_patterns=("frontend" "frontend-trader" "backend")

  for folder_pattern in ${folder_patterns[@]}; do
    if [ -d "$folder/$folder_pattern" ]; then
      eval "alias $base_folder$folder_pattern=\"cd $folder/$folder_pattern\""
    fi
  done
done
