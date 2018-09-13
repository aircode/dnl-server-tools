#!/bin/bash

configfile="$1"
instancefile="$2"

if ! grep '^dnlSingleInstance=' <"$configfile" >/dev/null 2>&1 && grep "^dnlserverroot=" <"$configfile" >/dev/null 2>&1 && [ ! -f "$instancefile" ]; then
  sed -n '/^#*\(dnl\(\|flag\|opt\)_[^=]*\|dnlserverroot\|serverMap\(\|ModId\)\)=/p' <"$configfile" >"$instancefile"
  sed -i '/^dnl\(serverroot\|_\(RCONPort\|Port\|QueryPort\)\)=/d' "$configfile"
  echo 'defaultinstance="main"' >>"$configfile"
fi
