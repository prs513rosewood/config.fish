function home_snap
    sudo btrfs subvolume snapshot /home /home/.snapshots/(date --rfc-3339=seconds | tr ' ' '_')
end
