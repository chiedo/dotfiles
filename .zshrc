source ~/.bash_profile
#source ~/.git-completion.bash
source ~/.git-prompt.sh
source ~/.env

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add VS Code to PATH so I can launch it via 'code' in the terminal
export PATH="$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"


# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

# Git Prompt
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '


#TERM=xterm-256color

# Better colors for directories and executables
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad


# Golang
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/projects/golang
export PATH=$PATH:$GOPATH/bin

#MAMP Mysql
export PATH=$PATH:/Applications/MAMP/Library/bin

# AWS CLI
export PATH=$PATH:~/Library/Python/2.7/bin

#PHP CS Fixer
export PATH=$PATH:/usr/local/sbin/php-cs-fixer

#Override system PHP with MAMP PHP
 export PATH=/Applications/MAMP/bin/php/php7.3.1/bin:$PATH


# Generates a random password
# Generate a 256 char long password: passgen 256
# Will default to a 16 char password: passgen
passgenfunc() {
  len=${1-16}
  cat /dev/urandom | env LC_CTYPE=C tr -dc a-zA-Z0-9'@#*()+={}/?~;,.-_' | head -c $len; echo
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
  echo -n $1 | base64
}
alias base64=base64func

#alias start-openvpn='sudo openvpn ~/.vpn/chiedo-labs-chiedo.ovpn'
#alias stop-openvpn='sudo killall openvpn'

#YARN
export PATH="$HOME/.yarn/bin:$PATH"

#Default system editor
export EDITOR=vim

#Tmuxinator
# source ~/.tmux/tmuxinator.zsh

#NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# added by Anaconda3 2019.10 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/chiedo/opt/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/chiedo/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/chiedo/opt/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/chiedo/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
