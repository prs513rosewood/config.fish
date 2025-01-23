function home_snap
    sudo btrfs subvolume snapshot -r /home /home/.snapshots/(date --rfc-3339=seconds | tr ' ' '_')
end
