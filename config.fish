# Setting locale for git
set -x LC_ALL en_US.UTF-8

# Aliases
alias rm='rm -i'
alias backup='rsync -au --delete $HOME /run/media/frerot/LHF\ Data/rsync-backup'
alias ssh-tunnel='ssh -fN -L'
alias open='xdg-open'
alias less='less -R'
alias xclip='xclip -selection c'
alias thesaurus='aiksaurus'
alias tor-browser='$HOME/Applications/tor-browser_en-US/Browser/start-tor-browser --detach'

set -e PYTHONPATH

# Load system variables
if test -e /etc/profile.env
    . /etc/profile.env
end

# Virtual environments
set -x VENVS $HOME/.local/share/virtualenvs

# Cargo/Rust
set -x PATH $HOME/.cargo/bin $PATH

# Tamaas
set -x TAMAAS $HOME/Documents/tamaas

# Akantu
set -x AKANTU $HOME/Documents/akantu

# Editor
set -x EDITOR "/usr/bin/vim"

# Password-store
set -x PASSWORD_STORE_DIR "$HOME/Nextcloud/password-store"
set -x PASSWORD_STORE_ENABLE_EXTENSIONS "true"

# Keybase shortcut
set -x KBFS /keybase/private/hexley/

# SSH key
keychain --quiet

set KEYCHAIN_FILE $HOME/.keychain/(hostname)-fish

if test -f $KEYCHAIN_FILE
  source $KEYCHAIN_FILE
end

ssh-add  < /dev/null > /dev/null 2>&1

# Adding $HOME/.local to paths
set local $HOME/.local
set -x PATH $local/bin $PATH
set -x LD_LIBRARY_PATH "$local/lib:$LD_LIBRARY_PATH"

# Setting number of threads for OMP
set -x OMP_NUM_THREADS 2
