# You probably need to symlink this file to where the actual bindings are.
FZF_HOME=$HOME/.config/fzf
# if shell is bash then source bash files
# if shell is zsh then source zsh files
if [[ -v BASH ]]; then
    eval $(fzf --bash)
elif [[ -v ZSH_VERSION ]]; then
    source <(fzf --zsh)
fi
