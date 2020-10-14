function _tamaas_usage
  echo "usage: tamaas command [arguments...]"
  echo ""
  echo "commands:"
  echo '    switch (debug|release|profiling)	switch build dir of tamaas'
  echo '    docker image_name			launch tamaas docker environment (requires sudo)'
end

function tamaas
  set nargs (count $argv)
  if [ $nargs -eq 0 ]
    _tamaas_usage
    return
  end

  # Switch command
  if [ $argv[1] = "switch" ]
    if [ $nargs -eq 1 ]
     _tamaas_usage
     return
    end

    pushd $TAMAAS
    rm -rf build-$argv[2]
    rm -f compile_commands.json
    tmc build_type=$argv[2]
    scons dev
    python3 -c 'import tamaas; print(tamaas.TamaasInfo.build_type); print(tamaas.__file__)'
    popd

  else if [ $argv[1] = "docker" ]
    if [ $nargs -eq 1 ]
      echo "List of docker images"
      sudo docker image ls --all
      echo ""
      _tamaas_usage
      return
    end

    sudo docker run -v $HOME/Documents/tamaas_extra/tamaas-docker/tamaas:/app/tamaas -w /app -it $argv[2] bash
  end
end
