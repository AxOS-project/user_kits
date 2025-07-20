#!/bin/bash

set -e
echo "==> Setting up BlackArch repository..."

if ! grep -q "\[blackarch\]" /etc/pacman.conf; then
  curl -O https://blackarch.org/strap.sh
  chmod +x strap.sh
  ./strap.sh
else
  echo "BlackArch repo already exists."
fi

echo
echo "==> Available BlackArch Tools Groups:"
pacman -Sg | grep '^blackarch-' | cut -d: -f1 | sort -u | nl

echo
read -p "Enter space-separated BlackArch groups to install ( or press Enter to Skip): " groups
if [[-n "$groups"]]; then
  sudo pacman -Sy --noconfirm $groups
else
  echo "No BlackArch groups selected."
fi
