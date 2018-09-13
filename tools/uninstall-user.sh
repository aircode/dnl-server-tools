#!/bin/bash
#
# uninstall-user.sh

BINDIR="/home/steam/bin"
DATADIR="/home/steam/.local/share/dnlmanager"

for f in "${BINDIR}/dnlmanager" \
         "${DATADIR}/uninstall.sh"
do
  if [ -f "$f" ]; then
    rm "$f"
  fi
done
