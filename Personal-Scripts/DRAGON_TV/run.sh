#!/bin/bash

while true
do
  # Run the script
  ./randomize.sh

  # Check the exit status
  exit_status=$?

  # If the exit status is 0 (success), exit the loop
  if [ $exit_status -eq 0 ]
  then
    break
  fi

  # If the script was closed (exit status 130), exit the loop
  if [ $exit_status -eq 130 ]
  then
    break
  fi

  # Wait for a few seconds before re-running the script
  sleep 5
done
