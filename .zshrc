## My Changes
# set colored directories
export CLICOLOR=1
export CLICOLOR_FORCE=1

# lang settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


## Path changes
GOHOME=/usr/local/go
GOPATH=$HOME/go
LLVM_HOME=/usr/local/opt/llvm
PATH=$PATH:$HOME/scripts
PATH=$PATH:$HOME/.local/bin
PATH=$GOHOME/bin:$PATH
PATH=$GOPATH/bin:$PATH
PATH=$GOPATH/bin:$PATH
PATH=$LLVM_HOME/bin:$PATH

export XDG_HOME=$HOME/.config
export AV_CACHE=$HOME/.cache/bazel/_bazel_siftikhar/5290b2948b376bde6190d6c97c8f2aac
export GITHUB_AUTHOR="Sohaib Iftikhar <sohaib1692@gmail.com>"
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
export POWERLINE_PROMPT='$'
source $(dirname `which python3`)/../lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh
powerline-daemon -q
## End my-changes

## My Bindings
export TERM=screen-256color
alias '..=cd ..'
alias '...=cd ..; cd ..'
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
alias grc="git rebase --continue"
alias gri="git rebase -i"
alias gpush="git push "
alias gpush="git push "
alias gpushf="git push --force-with-lease "
alias tf="terraform"
alias vim="nvim"
alias jfmt="java -jar ~/.local/lib/java/google-java-format-1.7-all-deps.jar"
# alias buildifier="/home/siftikhar/code/bazel/buildtools/bazel-bin/buildifier/linux_amd64_stripped/buildifier"
alias bz_compdb="/home/siftikhar/code/external/bazel-compilation-database/generate.sh"
alias cquery="/home/siftikhar/code/external/cquery/build/release/bin/cquery"
alias ll="ls -alh"

function gpushu () {
  branch=$(git branch --show-current)
  git push -u origin $branch
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

# bind Alt-G to search for git branches in locally checked out branches.
zle -N fzf-git-branch{,}
bindkey "\eg" "fzf-git-branch"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/siftikhar/.sdkman"
