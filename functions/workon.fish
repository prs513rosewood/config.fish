function workon
  echo $args[1]
  echo "Activating virtualenv $args[1]"
  source $VENVS/$args[1]/bin/activate.fish
end
