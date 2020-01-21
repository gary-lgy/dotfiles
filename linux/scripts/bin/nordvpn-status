#!/usr/bin/env bash

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
  echo -n " "; nordvpn status | grep -P -o '(?<=Current server: ).*?(?=.nordvpn.com)'
elif [[ "$STATUS" =~ ^.*onnecting$ ]]; then
  echo -n "$STATUS"
else
  echo " NordVPN"
fi
