#!/bin/bash

# Read commands from file into an array
readarray -t commands < final.sh

# Get a random index from the commands array
rand_index=$((RANDOM % ${#commands[@]}))

# Run the randomly chosen command
eval "${commands[$rand_index]}"

