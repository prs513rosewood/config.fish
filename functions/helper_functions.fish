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

# Wrapper function on gs
function pdfmanip
  argparse -i 'o/output=+' -- $argv
  set output "$_flag_o[1]"

  gs \
    -dNOPAUSE -dQUIET -dBATCH \
    -sDEVICE=pdfwrite \
    -sOutputFile="$output" \
    $argv
end 

# Convert pdf to greyscale
function pdfgreyscale
  pdfmanip -o $argv[2] \
    -sColorConversionStrategy=Gray \
    -dProcessColorModel=/DeviceGray \
    -dCompatibilityLevel=1.4 \
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

