# Load system variables
if test -e /etc/profile.env
  source /etc/profile.env
end

# Generic path
set -x PATH /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games

# User environment variables
set local $HOME/.local
set -x LC_ALL en_US.UTF-8
set -x PATH $local/bin $PATH
set -x LD_LIBRARY_PATH "$local/lib:$LD_LIBRARY_PATH"
set -x EDITOR (command -v vim)
set -x VENVS $local/share/virtualenvs
set -x PASSWORD_STORE_ENABLE_EXTENSIONS "true"
set -x LESS "-RX"
set -e PYTHONPATH

# ----------------------------------------------------------

# SSH key
if test -n (command -v keychain)
  keychain --quiet
  set KEYCHAIN_FILE $HOME/.keychain/(hostname)-fish
  if test -f $KEYCHAIN_FILE
    source $KEYCHAIN_FILE
  end
end

# ----------------------------------------------------------

# Aliases
alias re='source $__fish_config_dir/config.fish'
alias rc='$EDITOR $__fish_config_dir/config.fish'
alias rm='rm -i'
alias open='xdg-open'
alias xclip='xclip -selection c'
alias thesaurus='aiksaurus'
alias sqlite3='sqlite3 -header -column'
alias scons3="env python3 (command -v scons)"
alias whereami="curl -s 'https://api.myip.com' | jq -r '\"\(.ip) \(.country)\"'"
alias pvpn="protonvpn-cli"
alias hl="source-highlight -f esc256 -o STDOUT"
#
# ----------------------------------------------------------

# Loading virtualenv files
function v
  set venv_file bin/activate.fish
  if test -f $PWD/.venv/$venv_file
    source $PWD/.venv/$venv_file
  else
    source $VENVS/(basename $PWD)/$venv_file
  end
end

# Looking up cheat-sheets
function cheat
  curl -s https://cheat.sh/$argv[1] | less -E
end
complete -c cheat.sh -xa '(curl -s https://cheat.sh/:list)'

# Pulling from pre-made gitignore
function gitignore
  curl -sL https://www.toptal.com/developers/gitignore/api/$argv
end

# Tunnel for jupyter notebook
function jupyter-tunnel
  argparse 'p/local-port=' 'j/jupyter-port=' -- $argv

  set port "$_flag_p"
  if test -z "$port"
    set port 8080
  end

  set jport "$_flag_j"
  if test -z "$jport"
    set jport 8989
  end

  set server $argv[1]
  set node (ssh $server 'squeue -u $USER' | awk '/jupyter/ { print $(NF); }')

  if test -n "$node"
    ssh -L $port:$node:$jport $server -fN
  else
    echo "Did not find a node running jupyter on $server"
  end
end

# Convert pdf to greyscale
function pdfgreyscale
  gs \
    -sOutputFile=$argv[2] \
    -sDEVICE=pdfwrite \
    -sColorConversionStrategy=Gray \
    -dProcessColorModel=/DeviceGray \
    -dCompatibilityLevel=1.4 \
    -dNOPAUSE \
    -dBATCH \
    $argv[1]
end

# Convert image frames to video
function frame2vid
  set basename $argv[1]

  ffmpeg \
    -f image2 \
    -framerate 25 \
    -i "$basename.%04d.png" \
    -pix_fmt yuv420p \
    "$basename.mp4"

end
