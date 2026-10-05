function snapshot
    sudo snapper -c root create \
        --cleanup-algorithm number \
        --description "$argv"
end
