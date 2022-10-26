#!/bin/sh
mkdir -p /shared/plots
if [ ! -f "$FILE" ]; then
    plotfs --init
fi
mount.plotfs -f -o allow_other /shared/plots