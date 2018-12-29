# Setting locale for git
set -x LC_ALL en_US.UTF-8

# Bootstrapping fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Aliases
alias rm='rm -i'
alias backup='rsync -au --delete $HOME /run/media/frerot/LHF\ Data/rsync-backup'
alias ssh-tunnel='ssh -fN -L'
alias open='xdg-open'
alias less='less -R'

set -e PYTHONPATH

# Load system variables
if test -e /etc/profile.env
    . /etc/profile.env
end

# Cargo/Rust
set -x PATH $HOME/.cargo/bin $PATH

# Tamaas
set -x TAMAAS $HOME/Documents/tamaas
set -x PYTHONPATH "$TAMAAS/build/python:$PYTHONPATH"
set -x LD_LIBRARY_PATH "$TAMAAS/build/src/:$LD_LIBRARY_PATH"

# Akantu
set -x AKANTU $HOME/Documents/akantu
set -x PYTHONPATH "$AKANTU/build/python:$PYTHONPATH"
set -x PYTHONPATH "$AKANTU/test/test_fe_engine:$PYTHONPATH"
set -x PYTHONPATH "$AKANTU/test:$PYTHONPATH"
set -x LD_LIBRARY_PATH "$AKANTU/build/src:$LD_LIBRARY_PATH"

# ContactPP
set -x PYTHONPATH "$HOME/Documents/python/contactpp:$PYTHONPATH"

# Editor
set -x EDITOR "/usr/bin/vim"

# Password-store
set -x PASSWORD_STORE_DIR "$HOME/Nextcloud/password-store"
set -x PASSWORD_STORE_ENABLE_EXTENSIONS "true"

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
