#!/usr/bin/env bash
#
# Run every elementary rule, from 0 to 255, as many per screen as the
# terminal can hold (a grid of small windows).
#
# usage: scripts/all_rules.sh [delay_in_seconds]

cd "$(dirname "$0")/.." || exit 1
[ -x ./wolfram ] || make -s || exit 1

delay=${1:-0.75}
cell=21                         # width of one rule, gap included
lines=10                        # generations shown per rule
cols=$(( $(tput cols) / cell ))
rows=$(( ($(tput lines) - 1) / (lines + 2) ))
(( cols < 1 )) && cols=1
(( rows < 1 )) && rows=1
esc=$(printf '\033')
tmp=$(mktemp -d)

tput civis
trap 'tput cnorm; rm -rf "$tmp"' EXIT
clear

# One rule as a block of lines exactly $cell characters wide.
block() {
    printf '%-*s\n' "$cell" "rule $1"
    ./wolfram --rule "$1" --lines "$lines" --window $((cell - 1)) |
        while IFS= read -r line; do printf '%-*.*s\n' "$cell" "$cell" "$line"; done
    printf '%-*s\n' "$cell" ""
}

rule=0
while (( rule <= 255 )); do
    screen=""
    for (( r = 0; r < rows && rule <= 255; r++ )); do
        files=()
        for (( c = 0; c < cols && rule <= 255; c++ )); do
            block "$rule" > "$tmp/$c"
            files+=("$tmp/$c")
            rule=$((rule + 1))
        done
        screen+=$(paste -d '' "${files[@]}")$'\n'
    done
    # Bold headers, then draw over the previous screen instead of clearing it.
    screen=$(printf '%s' "$screen" | sed -E "s/rule +[0-9]+/${esc}[1m&${esc}[0m/g; s/\$/${esc}[K/")
    printf '\033[H%s\n\033[J' "$screen"
    sleep "$delay"
done
