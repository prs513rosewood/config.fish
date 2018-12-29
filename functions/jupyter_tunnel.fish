function jupyter_tunnel
  set nargs (count $argv)
  if [ $nargs -ne 2 ]
    echo "usage: jupyter-tunnel hostname port"
    return
  end

  set port $argv[2]
  set hostname $argv[1]
  ssh -fN -L $port:localhost:$port $hostname
  ssh -A $hostname "./tunnel-jupyter.sh $port"
end
