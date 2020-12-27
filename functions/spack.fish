function spack
  if test -f $SPACK_ROOT/share/spack/setup-env.fish
    source $SPACK_ROOT/share/spack/setup-env.fish
  end

  $SPACK_ROOT/bin/spack $argv
  functions --erase spack
end
