#!/bin/bash
# Based on https://github.com/LukeSmithxyz/voidrice/blob/9f9f1e3fbc7f30f58975a1ac93fdbd36e9317a04/.scripts/i3cmds/dmenuunicode

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH

if [ ! -f UnicodeChars.txt ]; then
    echo "UnicodeChars not found! Running gen.py..."
    python gen.py
fi

chosen=$(rofi -dmenu \
    -i \
    -scroll-method 1 \
    -lines 20 \
    -width 100 \
    -location 2 \
    -font "Monospace 10" \
    -p "uchar" \
     < UnicodeChars.txt)

[ "$chosen" != "" ] || exit

codepoint=$(sed -E "s/.+; U\+()//" <<< "$chosen")
char=$(echo -ne "\U$codepoint")
codepoint_str="U+$codepoint"

echo -n "$char" | xclip -selection clipboard
notify-send -a "unicode dmenu" "'$char' copied to clipboard."

echo -n "$codepoint_str" | xclip
notify-send -a "unicode dmenu" "'$codepoint_str' copied to primary."
