# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# setting for reloading history file every time.
export PROMPT_COMMAND="history -a; history -n"
# setup ssh agent askpass
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/ssh-agent.socket
export GPG_TTY="$(tty)"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH=$PATH:~/.aws/bin/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/home/siftikhar/python/bin:$PATH"

## Path changes
GOHOME=/usr/local/go
GOPATH=$HOME/go
ROCKPATH=$HOME/code/recogni/rock
PATH=$PATH:/opt/cuda/bin
PATH=$PATH:$HOME/scripts
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:/usr/local/opt/llvm/bin:/usr/lib/llvm-13/bin/
PATH=$GOHOME/bin:$PATH
PATH=$GOPATH/bin:$PATH
PATH=$PATH:$ROCKPATH/out


## my-changes
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export XDG_HOME=$HOME/.config
export GITHUB_AUTHOR="Sohaib Iftikhar <sohaib1692@gmail.com>"
$HOME/.local/bin/powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
export POWERLINE_PROMPT='$'
source $HOME/.local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh

## My Bindings
export EDITOR=nvim
export TERM=screen-256color
alias '..=cd ..'
alias '...=cd ..; cd ..'
alias clear_history="clear && tmux clear-history"
alias dr="cd ~/code/recogni/rock"
alias gr="grep -r"
alias ta="session=${session:-dev} tmux a -t$session"
alias tn="dev-tmux"
alias tk="dev-kill"
alias ts="tmux ls"
alias g="git "
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m "
alias gco="git checkout "
alias gpull="git pull origin"
alias gpr="git pull --rebase origin "
alias gr="git rebase "
alias gb="git branch --show-current"
alias grc="git rebase --continue"
alias gri="git rebase -i"
alias queue="gh pr comment -b 'bueller r+'"
alias gpush="git push "
alias gpushf="git push --force-with-lease "
alias tf="terraform"
alias vim="nvim"
alias cat="bat"
alias jfmt="java -jar ~/.local/lib/java/google-java-format-1.7-all-deps.jar"
alias bz_compdb="/home/siftikhar/code/external/bazel-compilation-database/generate.sh"
alias cquery="/home/siftikhar/code/external/cquery/build/release/bin/cquery"
alias myprs="gh pr list --author='@me'"
alias mklscconfig="bear -- make -j15 all pyrock test-unit DEBUG=yes"
alias mkrock="make -j rock DEBUG=YES"
alias fix="make -j format-diff"
alias testall="make -j15 test DEBUG=YES"
alias testrock="make -j15 test-unit DEBUG=YES"
alias e2ereport="typora $ROCKPATH/staging/test/e2e/report.md &> /dev/null"
alias cleanrock="make librock-clean rock-clean roll-clean strip-clean test-clean"
# Arch only. Remove orphaned packages.
alias orphans='[[ -n $(pacman -Qdt) ]] && sudo pacman -Rs $(pacman -Qdtq) || echo "no orphans to remove"'

function e2etest()
{
    make -j15 test-e2e DEBUG=YES NAME=$1
}

function gpushu () {
  branch=$(git branch --show-current)
  git push -u origin $branch
}

function awssh () {
  ssh `aws ec2 describe-instances --filter Name=tag:Name,Values=$1 | jq -r '.Reservations[].Instances[] | select(.State.Name=="running") | .PrivateIpAddress'`
}

function clang_tidy () {
  bazel build --config=clang-tidy //$1
}

function print_chain() {
  base=`git branch --show-current`
  gh pr list --search "is:open base:$base"
}

# Rebases all PRs that have the current branch as their target branch.
function rebase_all() {
  base=`git branch --show-current`
  chain=`gh pr list --search "is:open base:$base" | awk '{ print $(NF-1) }'`
  for branch in $chain; do
    git checkout $branch && git pull --rebase origin $base && gpush -f
  done
  git checkout $base
}

# FZF Commands
export FZF_DEFAULT_COMMAND='ag --nocolor --column -g ""'
export FZF_ALT_C_COMMAND='fdfind -t d ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

__fzf_gb__() {
  local cmd branch
  cmd='command git branch --format "%(refname:short)"'
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore \
    $FZF_DEFAULT_OPTS" $(__fzfcmd) -m "$@" | while read -r item; do
    printf '%q ' "$item"
  done
  echo
}
fzf-git-branch() {
  local selected="$(__fzf_gb__)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

function codot() {
  dot -T svg <(unzip -p "$1" "*.dot") -o "${2:-graph.svg}"
}

# must be in this order for fzf to work.
ssh-add < /dev/null
[[ $- == *i* ]] && source /usr/share/blesh/ble.sh
# bind Alt-G to search for git branches in locally checked out branches. Must happen after sourcing ble.sh.
bind -x '"\eg": fzf-git-branch'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/home/siftikhar/.sdkman"
# [[ -s "/home/siftikhar/.sdkman/bin/sdkman-init.sh" ]] && source "/home/siftikhar/.sdkman/bin/sdkman-init.sh"

