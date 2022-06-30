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

# Locale variables
set -x LANG "C.UTF-8"      # fallback if undefined
set -x LANGUAGE "C.UTF-8"  # english for command output
# Note: avoid setting LC_ALL, as it overrides
# everything, making things hard to debug

# User paths
set local $HOME/.local
set -x PATH $local/bin $PATH
set -x LD_LIBRARY_PATH "$local/lib:$LD_LIBRARY_PATH"

# Erase any previously set PYTHONPATH
set -e PYTHONPATH

# Parallel scons builds
set -x SCONSFLAGS -j\ (math (nproc)/2)

# TeXLive config
set -x TEXMFHOME $HOME/.config/texmf
