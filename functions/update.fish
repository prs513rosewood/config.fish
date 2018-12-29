function update --description 'Update the packages using APT'
  sudo apt update
  sleep 5
  sudo apt upgrade $argv
end
