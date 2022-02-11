# Load ssh keys in agent
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
alias gs="gs -dQUIET -dNOPAUSE -dBATCH -sDEVICE=pdfwrite"
