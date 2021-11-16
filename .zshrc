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
alias dotfiles='/usr/bin/git --git-dir=/home/pantokrator/.cfg/ --work-tree=/home/pantokrator'

alias bitwarden='flatpak run com.bitwarden.desktop'
alias spotify='flatpak run com.spotify.Client'
alias atom='flatpak run io.atom.Atom'
alias joplin='flatpak run net.cozic.joplin_desktop'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
