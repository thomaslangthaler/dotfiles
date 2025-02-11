source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle Zsh-users/zsh-completions
# antigen bundle oldratlee/hacker-quotes

# Load the theme
antigen theme agnoster

# Tell antigen that you're done
antigen apply

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias c='xsel --clipboard --input'
alias p='xsel --clipboard --output'
