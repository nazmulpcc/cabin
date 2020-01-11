#!/bin/sh

if [ -f startup.sh ]; then
    sh startup.sh
else
    echo "No startup script, exiting"
fi