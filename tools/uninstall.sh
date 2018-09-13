#!/bin/bash
#
# uninstall.sh

BINDIR="/usr/bin"
DATADIR="/usr/share/dnlmanager"
LIBEXECDIR="/usr/libexec/dnlmanager"
INITSCRIPT=

if [ -f "/etc/rc.d/init.d/dnlmanager" ]; then
  INITSCRIPT="/etc/rc.d/init.d/dnlmanager"
  if [ -f "/etc/rc.d/init.d/functions" ]; then
    chkconfig dnlmanager off
  fi
elif [ -f "/etc/init.d/dnlmanager" ]; then
  INITSCRIPT="/etc/init.d/dnlmanager"
  if [ -f "/lib/lsb/init-functions" ]; then
    update-rc.d -f dnlmanager remove
  elif [ -f "/sbin/runscript" ]; then
    rc-update del dnlmanager default
  fi
elif [ -f "/etc/systemd/system/dnlmanager.service" ]; then
  INITSCRIPT="/etc/systemd/system/dnlmanager.service"
  systemctl disable dnlmanager.service
fi

if [ -n "$INITSCRIPT" ]; then
  for f in "${INITSCRIPT}" \
           "${BINDIR}/dnlmanager" \
           "${LIBEXECDIR}/dnlmanager.init" \
           "${LIBEXECDIR}/dnlmanager-uninstall.sh"
  do
    if [ -f "$f" ]; then
      rm "$f"
    fi
  done
fi

# remove bash_completion.d
if [ -f "/etc/bash_completion.d/dnlmanager" ]; then
   rm "/etc/bash_completion.d/dnlmanager"
fi
