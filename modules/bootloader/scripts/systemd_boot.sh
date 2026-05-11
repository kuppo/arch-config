#!/usr/bin/env bash
if ! sudo -v; then
  echo "Authentication failed. Exiting."
  exit 1
fi

if sudo bootctl is-installed; then
  sudo bootctl update
else
  sudo bootctl install
fi
