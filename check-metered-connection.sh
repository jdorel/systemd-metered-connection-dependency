#! /usr/bin/bash

metered_status=$(qdbus --system org.freedesktop.NetworkManager /org/freedesktop/NetworkManager org.freedesktop.NetworkManager.Metered)

if [[ $metered_status =~ (1|3) ]]; then
  echo Current connection is metered
  exit 1
else 
  exit 0
fi
