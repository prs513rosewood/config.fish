function _akantu_usage
  echo "usage: akantu command [arguments...]"
  echo ""
  echo "commands:"
  echo '    switch (debug|release)	switch build dir of tamaas'
end

function akantu
  set nargs (count $argv)
  if [ $nargs -eq 0 ]
    _akantu_usage
    return
  end

  # Switch command
  if [ $argv[1] = "switch" ]
    if [ $nargs -eq 1 ]
     _akantu_usage
     return
    end

    pushd $AKANTU
    rm -f build
    ln -s build-$argv[2] build
    popd
  end
end
