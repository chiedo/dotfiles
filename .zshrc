#source ~/.bash_profile
#source ~/.git-completion.bash
if [ -d ~/.env ]; then
  source ~/.env
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add VS Code to PATH so I can launch it via 'code' in the terminal
#export PATH="$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

# Golang
#export PATH=$PATH:/usr/local/opt/go/libexec/bin
#export GOPATH=$HOME/projects/golang
#export PATH=$PATH:$GOPATH/bin

#MAMP Mysql
#export PATH=$PATH:/Applications/MAMP/Library/bin

# AWS CLI
#export PATH=$PATH:~/Library/Python/2.7/bin

#PHP CS Fixer
#export PATH=$PATH:/usr/local/sbin/php-cs-fixer

#Override system PHP with MAMP PHP
#export PATH=/Applications/MAMP/bin/php/php7.3.1/bin:$PATH

#Tmuxinator
# source ~/.tmux/tmuxinator.zsh

#NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="awesomepanda"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Generates a random password
# Generate a 256 char long password: passgen 256
# Will default to a 16 char password: passgen
passgenfunc() {
  len=${1-20}
  cat /dev/urandom | LC_ALL=C tr -dc A-Za-z0-9 </dev/urandom | head -c $len; echo
}
alias passgen=passgenfunc

# Generates a random word based password
# Generate a 7 word long password: wordpassgen 7
# Will default to a 4 word password: wordpassgen
wordpassgenfunc() {
  wordCount=${1-4}
  COUNTER=0
  while [  $COUNTER -lt $wordCount ]; do
    x=$(sed `perl -e "print int rand(99999)"`"q;d" /usr/share/dict/words)
    if [ $(($wordCount)) = $(($COUNTER + 1)) ]; then
      echo $x
    else
      echo -n $x
      echo -n ' '
    fi
    let COUNTER=COUNTER+1
  done
}
alias wordpassgen=wordpassgenfunc

base64func() {
  echo -n $1 | openssl base64
}
alias base64=base64func

#Default system editor
#export EDITOR=vim
export EDITOR=code

alias vim=code
