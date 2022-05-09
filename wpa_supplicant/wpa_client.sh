#!/bin/bash

if [[ $# -ne 4 ]]; then
  echo "Usage: `basename $0` iface ssid passphrase channel"
  exit 1
fi

if [[ $UID -ne 0 ]]; then
  echo "Not root"
  exit 1
fi

IFACE="$1"
SSID="$2"
PASSPHRASE="$3"
CHANNEL="$4"

if [[ $CHANNEL -lt 10 ]]; then
  CHANNEL="0${CHANNEL}"
fi

PSK_LINE=`wpa_passphrase "$SSID" "$PASSPHRASE" | grep "\spsk"`
FREQ=`iwlist $IFACE frequency | grep "\sChannel ${CHANNEL} " | awk '{sub(/\./,X,$4);print $4}'`

CONF_FILE=`mktemp`
cat << EOF > $CONF_FILE
network={
	ssid="$SSID"
$PSK_LINE
}

# Specify outside network to apply to scan
freq_list=$FREQ
EOF

./wpa_supplicant -D wext -i $IFACE -c $CONF_FILE &
WPASUP_PID=$!

sleep 1
rm $CONF_FILE

stop() {
  echo "Terminating..."
  kill $WPASUP_PID
  wait $WPASUP_PID
  exit 0
}

trap stop SIGINT SIGTERM SIGHUP

tail -f /dev/null
exit 0
