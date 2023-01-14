#!/bin/bash

TARGET="${DISCOCSS_PATH:-$HOME/.local/bin/discocss}"
mkdir -p "$(dirname $TARGET)"
rm -f "$TARGET"
curl -fsSL \
  "https://github.com/mlvzk/discocss/raw/master/discocss" \
  -o "$TARGET"
sed -i '/exec "\$discordBin"$/ s/$/ $*/' "$TARGET"
chmod +x ~/.local/bin/discocss
