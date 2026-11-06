#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit 1
[ -x ./wolfram ] || make -s || exit 1

esc=$(printf '\033')
tmp=$(mktemp -d)
tput civis
trap 'tput cnorm; rm -rf "$tmp"' EXIT
clear

draw() {
    local screen
    screen=$(printf '%s' "$1" | sed -E "s/rule +[0-9]+/${esc}[1m&${esc}[0m/g; s/\$/${esc}[K/")
    printf '\033[H%s\n\033[J' "$screen"
}

if (( $# > 0 )); then
    for rule in "$@"; do
        lines=$(( $(tput lines) - 3 ))
        width=$(( $(tput cols) - 1 ))
        draw "$(printf 'rule %d\n\n' "$rule"; ./wolfram --rule "$rule" --lines "$lines" --window "$width")"
        sleep "${DELAY:-2}"
    done
    exit 0
fi

cell=21
lines=10
cols=$(( $(tput cols) / cell ))
rows=$(( ($(tput lines) - 1) / (lines + 2) ))
(( cols < 1 )) && cols=1
(( rows < 1 )) && rows=1

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
    draw "$screen"
    sleep "${DELAY:-0.75}"
done
