# Load ssh keys in agent
if command -v keychain
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
alias gs="gs -dQUIET -dNOPAUSE -dBATCH -sDEVICE=pdfwrite"
alias asan="env LD_PRELOAD=(gcc -print-file-name=libasan.so) ASAN_OPTIONS=detect_leaks=0"
alias j2html="jupyter nbconvert --to html"
alias merge-accents="sed -i 's/é/é/g;s/è/è/g;s/à/à/g;s/ù/ù/g;s/ê/ê/g;s/ç/ç/g;s/û/û/g;s/î/î/g;s/À/À/g;s/É/É/g;s/È/È/g'"

# ----------------------------------------------------------

# Loading virtualenv files
function v
  set venv_file bin/activate.fish

  if test (count $argv) -gt 0
      set venv_name $argv[1]
  else
      set venv_name (basename $PWD)
  end

  if test -f $PWD/.venv/$venv_file
    source $PWD/.venv/$venv_file
  else
    source $VENVS/$venv_name/$venv_file
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
function pdfgrayscale
  test (count $argv) -eq 2; or begin
    echo "usage: pdfgrayscale input.pdf output.pdf"
    return 1
  end

  pdfmanip -o $argv[2] \
    -sColorConversionStrategy=Gray \
    -dProcessColorModel=/DeviceGray \
    -dCompatibilityLevel=1.4 \
    $argv[1]
end

# Convert image frames to video
function frame2vid
  test (count $argv) -eq 1; or begin
    echo "usage: frame2vid basename"
    return 1
  end

  set basename $argv[1]
  ffmpeg \
    -f image2 \
    -framerate 25 \
    -i "$basename.%04d.png" \
    -pix_fmt yuv420p \
    "$basename.mp4"
end

# Convert pdf to png
function pdf2png
  test (count $argv) -eq 3; or begin
    echo "usage: pdf2png dpi input.pdf output.png"
    return 1
  end

  set dpi $argv[1]
  set in $argv[2]
  set out $argv[3]

  inkscape \
    --pdf-poppler \
    -b "FFFFFF" \
    -C -d $dpi \
    -o $out \
    $in
end

function wl-color-picker
    function pick
        qdbus6 --literal org.kde.KWin.ScreenShot2 /ColorPicker org.kde.kwin.ColorPicker.pick | sed 's/^[^0-9]*//;s/[^0-9]*$//;'
    end

    function to_argb
        printf "%x" (math $argv[1] - 0xff000000)
    end

    kdialog --inputbox "Your color" "#$(to_argb $(pick))"
end

set -e SSH_ASKPASS

# Pyenv setup
if command -v pyenv >/dev/null 2>&1
    pyenv init - | source
end
