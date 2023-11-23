# You probably need to symlink this file to where the actual bindings are.
FZF_HOME=$HOME/.config/fzf
# if shell is bash then source bash files
# if shell is zsh then source zsh files
if [[ "$SHELL" == *"bash"* ]]; then
    source $FZF_HOME/key-bindings.bash
    source $FZF_HOME/completion.bash
elif [[ "$SHELL" == *"zsh"* ]]; then
    source $FZF_HOME/key-bindings.zsh
    source $FZF_HOME/completion.zsh
fi
