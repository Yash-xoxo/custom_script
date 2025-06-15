#!/bin/bash

# Number Guessing Game

echo "🧠 Welcome to the Number Guessing Game!"
echo "I'm thinking of a number between 1 and 100..."

# Generate a random number between 1 and 100
secret=$(( RANDOM % 100 + 1 ))
attempts=0

while true; do
    read -p "Enter your guess: " guess
    ((attempts++))

    if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
        echo "❌ That's not a number!"
        continue
    fi

    if (( guess < secret )); then
        echo "📉 Too low!"
    elif (( guess > secret )); then
        echo "📈 Too high!"
    else
        echo "🎉 Correct! You guessed it in $attempts tries."
        break
    fi
done
