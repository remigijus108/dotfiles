#!/bin/sh 

WANIFACE=${1:-wlan0}

/sbin/ifconfig $WANIFACE 2>/dev/null >/dev/null || exit 1
mail=$(/usr/bin/fetchmail -c -f ~/fetchmail/.fetchmailrc 2>/dev/null) 
ec=$?;[ $ec -gt 1 ] && exit $ec
all=$(echo "$mail" | /bin/sed -nr 's/^([0-9]*).*/\1/p') 
seen=$(echo "$mail" | /bin/sed -nr 's/[^\(]*.([^ ]*) seen.*/\1/p')
if [ ! -z "$all" ]; then
  if [ ! -z "$seen" ]; then
    echo "$((all-seen))"
  else 
    echo "$all"
  fi
else
  echo "0"
fi

