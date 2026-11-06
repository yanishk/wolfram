#!/usr/bin/env bash
#
# Run every elementary rule, from 0 to 255, one screen each.
#
# usage: scripts/all_rules.sh [delay_in_seconds]

cd "$(dirname "$0")/.." || exit 1
[ -x ./wolfram ] || make -s || exit 1

delay=${1:-0.15}
lines=$(( $(tput lines) - 3 ))
width=$(( $(tput cols) - 1 ))
eol=$(printf '\033[K')

tput civis
trap 'tput cnorm' EXIT
clear

for rule in $(seq 0 255); do
    screen=$(./wolfram --rule "$rule" --lines "$lines" --window "$width")
    # Draw over the previous screen instead of clearing it, so it never blinks.
    frame=$(printf '\033[1mrule %3d\033[0m / 255\n\n%s' "$rule" "$screen" | sed "s/\$/$eol/")
    printf '\033[H%s\n\033[J' "$frame"
    sleep "$delay"
done
