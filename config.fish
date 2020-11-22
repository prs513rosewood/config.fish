# Fish-specific settings
set -xU fish_features stderr-nocaret qmark-noglob

# Load system variables
if test -e /etc/profile.env
  source /etc/profile.env
end

# User environment variables
set local $HOME/.local
set -x LC_ALL en_US.UTF-8
set -x PATH $local/bin /opt/ovito/bin $HOME/.cargo/bin $PATH
set -x LD_LIBRARY_PATH "$local/lib:$LD_LIBRARY_PATH"
set -x EDITOR (which vim)
set -x VENVS $local/share/virtualenvs
set -x PASSWORD_STORE_ENABLE_EXTENSIONS "true"
set -x KBFS /keybase/private/hexley/
set -e PYTHONPATH

set SPACK_ROOT $HOME/Documents/repos/spack
if test -f $SPACK_ROOT/share/spack/setup-env.fish
  source $SPACK_ROOT/share/spack/setup-env.fish
end

# ----------------------------------------------------------

# SSH key
keychain --quiet
set KEYCHAIN_FILE $HOME/.keychain/(hostname)-fish
if test -f $KEYCHAIN_FILE
  source $KEYCHAIN_FILE
end
ssh-add  < /dev/null > /dev/null 2>&1

# Aliases
alias re='source $HOME/.config/fish/config.fish'
alias rm='rm -i'
alias open='xdg-open'
alias xclip='xclip -selection c'
alias thesaurus='aiksaurus'
alias sqlite3='sqlite3 -header -column'
alias scons3="/usr/bin/env python3 (which scons)"
alias whereami="curl -s 'ipinfo.io'; echo"
alias p2p="sudo protonvpn c 'CH#10'; and whereami"

# Loading virtualenv files
function v
  set venv_file bin/activate.fish
  if test -f $PWD/.venv/$venv_file
    source $PWD/.venv/$venv_file
  else
    source $VENVS/(basename $PWD)/$venv_file
  end
end
