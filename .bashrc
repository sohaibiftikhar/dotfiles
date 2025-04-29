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

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# setting for reloading history file every time.
export PROMPT_COMMAND="history -a; history -n"

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

export PATH=$PATH:~/.aws/bin/
# Rust package manager.
if [[ -d "~/.cargo/.bin" ]] then
  export PATH=$PATH:~/.cargo/bin/
fi

if [[ -f "~/.cargo/env" ]] then
  source ~/.cargo/env
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if [[ -d /opt/homebrew/opt/node/bin ]]; then
    export PATH=$PATH:/opt/homebrew/opt/node/bin
fi

## Path changes
CODE=$HOME/code/
PATH=$PATH:/opt/cuda/bin
PATH=$PATH:$HOME/scripts
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:/usr/local/opt/llvm/bin:/usr/lib/llvm-13/bin/
PATH=/opt/homebrew/bin/:$PATH

## my-changes
# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GITHUB_AUTHOR="Sohaib Iftikhar <sohaib1692@gmail.com>"
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
export POWERLINE_PROMPT='λ'
source `pip3 show powerline-status | grep -i Location | awk '{print $2}'`/powerline/bindings/zsh/powerline.zsh

## My Bindings
export EDITOR=nvim
export TERM=screen-256color
alias '..=cd ..'
alias '...=cd ..; cd ..'
alias clear_history="clear && tmux clear-history"
alias gr="grep -r"
alias ta="session=${session:-dev} tmux a -t$session"
alias tn="dev-tmux"
alias tk="dev-kill"
alias ts="tmux ls"
alias dev0="hgd dev0"
alias dev1="hgd dev1"
alias h="hg"
alias hl="hg xl"
alias hs="hg status"
alias ha="hg add "
alias hc="hg commit "
alias hcm="hg commit -m "
alias hpr="hg sync"
alias hreset="hg revert -r p4base"
# Same but for Git.
alias g="git "
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m "
alias gpr="git pull --rebase "
alias gr="git rebase "
alias gb="git branch --show-current"
alias gba="git branch"
alias grc="git rebase --continue"
alias gri="git rebase -i"
alias gpush="git push "
alias gpushf="git push --force-with-lease "
alias tf="terraform"
alias vim="nvim"
alias cat="batcat"
alias htop="btop"
alias du="ncdu"
alias df="duf"
alias bb="blaze build"
alias bt="blaze test"
alias runit="blaze run"
# Arch only. Remove orphaned packages.
alias orphans='[[ -n $(pacman -Qdt) ]] && sudo pacman -Rs $(pacman -Qdtq) || echo "no orphans to remove"'

function gco()
{
    $($HOME/scripts/checkout $@)
}

function mk()
{
    make -j15 $@ DEBUG=YES
}

function rmbranch()
{
    for branch in "$@"; do
        echo "Deleting branch '$branch'"
        git branch -D "$branch"
        git push origin --delete "$branch"
    done
}

function gpushu () {
  branch=$(git branch --show-current)
  git push -u origin $branch
}

function print_chain() {
  base=`git branch --show-current`
  gh pr list --search "is:open base:$base"
}

function codot() {
  # dot -T svg <(unzip -p "$1" "*.dot") -o "${2:-graph.svg}"
  # required pacaur -S xdot-git
  test $1 && xdot <(unzip -p "$1" "*.dot")
}

# Format all json files in a directory or a single file if $1 points to file inplace.
function format_json() {
    if [ -d "$1" ]; then
        # outer quote is important to turn into array.
        files=( $(ag -l --nocolor --column -g "\.json" $1) )
        for file in $files; do
            jq . $file > $file.tmp && mv $file.tmp $file
        done
    else
        jq . $1 > $1.tmp && mv $1.tmp $1
    fi
}
# FZF Commands
export FZF_DEFAULT_COMMAND='ag --nocolor --column -g ""'
export FZF_ALT_C_COMMAND='fdfind -t d ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

__fzf_gb__() {
  local cmd branch
  cmd='command git branch --format "%(refname:short)"'
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore\
    $FZF_DEFAULT_OPTS" $(__fzfcmd) -m "$@" | while read -r item; do
    print "$item"
  done
  echo
}

fzf-git-branch() {
  local selected="$(__fzf_gb__)"
  # READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  # READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
  LBUFFER="${LBUFFER}${selected}"
  zle -I
}
# must be in this order for fzf to work.

# if [[ "$OSTYPE" == "darwin"* ]]; then
#     ssh-add --apple-use-keychain < /dev/null
# fi
# TODO how to make this work for zsh on ubuntu?

if [ -v ZSH_VERSION ]; then
    # Package manager for zsh
    ANTIGEN=/opt/homebrew/share/antigen/antigen.zsh
    if [[ -f $ANTIGEN ]]; then
        source /opt/homebrew/share/antigen/antigen.zsh
        antigen bundle zsh-users/zsh-autosuggestions
        antigen apply
    fi
    # Alt-key for mac-zsh.
    autoload -Uz compinit; compinit
    HIGHLIGHT_FILE=/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    if [[ -f $HIGHLIGHT_FILE ]]; then
        source $HIGHLIGHT_FILE
    fi
    zle -N fzf-git-branch # make a widget
    bindkey "\x1bg" fzf-git-branch # bind it to a zshell
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
