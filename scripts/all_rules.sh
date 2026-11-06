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

for rule in $(seq 0 255); do
    screen=$(./wolfram --rule "$rule" --lines "$lines" --window "$width")
    printf '\033[H\033[J\033[1mrule %3d\033[0m / 255\n\n%s\n' "$rule" "$screen"
    sleep "$delay"
done
