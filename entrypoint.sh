#!/bin/sh
trap 'umount /shared/plots' SIGTERM

mkdir -p /shared/plots
if [ ! -f "/var/local/plotfs/plotfs.bin" ]; then
    plotfs --init
fi
mount.plotfs -o allow_other /shared/plots

sleep infinity &
wait $!
