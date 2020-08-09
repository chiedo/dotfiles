source ~/.git-prompt.sh
source ~/.bash_profile
source ~/.env

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

# Git Prompt
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


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

#Default system editor
export EDITOR=vim

