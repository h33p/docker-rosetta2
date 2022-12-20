#!/bin/bash

echo "Do you want the script to run 'softwareupdate --install-rosetta' to fetch 'RosettaUpdateAuto.pkg' automatically? If you choose not to, please place RosettaUpdateAuto.pkg in the current directory."

echo

read -e -p "Fetch RosettaUpdateAuto.pkg? [Y/n] " choice

if [ -z "$choice" ] || [ "$choice" == [Yy]* ]; then
  softwareupdate --install-rosetta
  rosetta_path=$(grep RosettaUpdateAuto.pkg /var/log/install.log | tail -n1 | sed -nr "s/.*file:\/\/(.*)#RosettaUpdateAuto.*/\1/p")
  echo "Copy from: $rosetta_path"
  cp "$rosetta_path" ./RosettaUpdateAuto.pkg
fi

rm -rf RosettaUpdateAuto.pkg-expanded

pkgutil --expand-full RosettaUpdateAuto.pkg RosettaUpdateAuto.pkg-expanded

if ! shasum -c rosetta.sum; then
  echo "Incompatible rosetta binary! Exiting..."
  exit 1
fi

cp RosettaUpdateAuto.pkg-expanded/RosettaUpdateAuto.pkg/Payload/Library/Apple/usr/libexec/oah/RosettaLinux/rosetta ./rosetta

dd if=<(printf '\x1f\x20\x03\xd5') of='rosetta' bs=1 seek=170828 conv=notrunc
dd if=<(printf '\x1f\x20\x03\xd5') of='rosetta' bs=1 seek=170856 conv=notrunc
