# Generic path
set -x PATH          \
  /usr/local/bin     \
  /usr/lib/ccache    \
  /usr/sbin          \
  /usr/bin           \
  /sbin              \
  /bin               \
  /usr/games         \
  /usr/local/games

# User environment variables
set -x EDITOR (command -v vim)
set -x VENVS $local/share/virtualenvs
set -x PASSWORD_STORE_ENABLE_EXTENSIONS "true"
set -x LESS "-RX"
set -x LC_ALL en_US.UTF-8

# User paths
set local $HOME/.local
set -x PATH $local/bin $PATH
set -x LD_LIBRARY_PATH "$local/lib:$LD_LIBRARY_PATH"

# Erase any previously set PYTHONPATH
set -e PYTHONPATH
