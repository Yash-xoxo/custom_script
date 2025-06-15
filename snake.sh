#!/bin/bash

# Snake Game in Bash (Terminal-based)

cols=$(tput cols)
rows=$(tput lines)

# Snake initial position
x=$((cols / 2))
y=$((rows / 2))
length=5
score=0

# Direction (WASD keys)
dir="RIGHT"

# Setup trap to catch arrow keys
stty -echo -icanon time 0 min 0

draw() {
    clear
    echo "🐍 Snake Game (Score: $score)"
    tput cup $y $x
    echo -n "O"
}

move() {
    case $dir in
        "UP") ((y--));;
        "DOWN") ((y++));;
        "LEFT") ((x--));;
        "RIGHT") ((x++));;
    esac
}

read_input() {
    read -rsn1 key
    case "$key" in
        w) dir="UP";;
        s) dir="DOWN";;
        a) dir="LEFT";;
        d) dir="RIGHT";;
        q) echo -e "\n❌ Game Over. Final Score: $score"; stty sane; exit;;
    esac
}

while true; do
    draw
    read_input
    move

    # Boundary check
    if (( x <= 0 || y <= 1 || x >= cols || y >= rows )); then
        echo -e "\n💥 You hit the wall! Final Score: $score"
        stty sane
        break
    fi

    ((score++))
    sleep 0.1
done
