# Generic path
set -x PATH                        \
  /opt/texlive/bin/x86_64-linux/   \
  /usr/local/bin                   \
  /usr/lib{,64}/ccache             \
  /usr/lib/ccache                  \
  /usr/sbin                        \
  /usr/bin                         \
  /sbin                            \
  /bin                             \
  /usr/games                       \
  /usr/local/games

set local $HOME/.local

# User environment variables
set -x EDITOR (command -v vim)
set -x VENVS $local/share/venv/
set -x PASSWORD_STORE_ENABLE_EXTENSIONS "true"
set -x LESS "-RX"

# Locale variables
## Note: avoid setting LC_ALL, as it overrides
## everything, making things hard to debug
set -x LANG       "C.UTF-8"  # fallback if undefined
set -x LANGUAGE   "C.UTF-8"  # english for command output
set -x LC_NUMERIC "C.UTF-8"  # dot for numbers

# Compilers
set -x CC gcc-12
set -x CXX g++-12

# User paths
set local $HOME/.local
set -x PATH $local/bin $PATH
set -x LD_LIBRARY_PATH "$local/lib:/usr/local/lib64:/usr/local/lib:$LD_LIBRARY_PATH"

# Erase any previously set PYTHONPATH
set -e PYTHONPATH

# Parallel scons builds
set -x SCONSFLAGS -j\ 4

# TeXLive config
set -x TEXMFHOME $HOME/.config/texmf

# Add /usr/local/lib/python{version}/site-packages
set python_version (python3 -V | cut -d " " -f 2 | cut -d '.' -f 1,2)
set -x PYTHONPATH "$local/lib/python$python_version/site-packages:/usr/local/lib/python$python_version/site-packages"

# Set OMP_NUM_THREADS to 1: avoids scipy running in parallel on all cores
set -x OMP_NUM_THREADS 1
