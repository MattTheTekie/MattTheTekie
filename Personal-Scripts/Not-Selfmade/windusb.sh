#!/usr/bin/env bash

# Author: Broly
# License: GNU General Public License v3.0
# https://www.gnu.org/licenses/gpl-3.0.txt

# Function to welcome user and check if running as root
welcome() {
  clear
  printf "Please enter your password: "
  # Check if running as root
  if [[ "$(whoami)" != "root" ]]; then
    exec sudo -- "$0" "$@"
  fi

  # Set shell to exit on error
  set -e
}

# Function to prompt user to select a USB drive
getthedrive() {
  clear
  printf "Please select a USB drive from the following list:\n"

  # Get a list of USB drives connected to the system
  readarray -t lines < <(lsblk -p -no name,size,MODEL,VENDOR,TRAN | grep "usb")

  # Prompt user to select a USB drive from the list
  select choice in "${lines[@]}"; do
    # Check if selection is valid
    [[ -n $choice ]] || {
      printf ">>> Invalid selection!\n" >&2
      continue
    }
    break
  done

  # Extract the drive name from the user's selection
  read -r drive _ <<<"$choice"

  # Check if no USB drive was selected
  if [[ -z "$choice" ]]; then
    printf "No usb-drive found please insert the usb drive and try again.\n"
    exit 1
  fi
}

# Function to install required dependencies for WindUSB
dependencies() {
  clear
  printf "Installing required dependencies...\n"

  # Check which Linux distribution is being used and install dependencies accordingly
  if [[ -f /etc/debian_version ]]; then
    apt install -y wimtools rsync
  elif [[ -f /etc/fedora-release ]]; then
    dnf install -y wimlib-utils rsync
  elif [[ -f /etc/arch-release ]]; then
    pacman -Sy --noconfirm --needed wimlib rsync
  else
    printf "Your distro is not supported!'\n"
    exit 1
  fi
}

# Function to format the selected USB drive and create a FAT32 partition
partformat() {
  clear
  printf "Formatting the selected USB drive and creating a FAT32 partition...\n"

  # Unmount any partitions on the selected drive
  umount "$drive"* || :

  # Wipe all existing filesystem signatures from the selected drive
  wipefs -af "$drive"

  # Create a new partition on the selected drive
  sgdisk -e "$drive" --new=0:0: -t 0:0700 && partprobe

  # Wait 3 seconds to ensure the new partition is available
  sleep 3s

  # Unmount any partitions on the selected drive
  umount "$drive"* || :

  # Format the new partition with the FAT32 filesystem and label it as "WINDUSB"
  mkfs.fat -F32 -n WINDUSB "$drive"1

  # Mount the new partition on /mnt/
  mount "$drive"1 /mnt/
}

# Function that prompts the user to confirm if they want to erase the disk, install dependencies, and format the partition
format_drive() {
  while true; do
    # Using printf to format the prompt string, allowing the variable $drive to be included in the string
    printf "Disk %s will be erased. Wimlib and Rsync will be installed. Do you wish to continue [y/n]? " "$drive"
    read -r yn
    case $yn in
    # If the user types "y" or "Y", run the dependencies() and partformat() functions, and break out of the loop
    [Yy]*)
      dependencies "$@"
      partformat "$@"
      break
      ;;
    # If the user types "n" or "N", exit the script
    [Nn]*)
      exit
      ;;
    # If the user types anything else, print an error message and loop back to the top of the loop
    *)
      printf "Please answer yes or no.\n"
      ;;
    esac
  done
}

# Function that extracts the contents of a Windows ISO to a specified location, excluding the install.wim file
extract() {
  # Check if the /run/media/winiso directory exists. If it doesn't, create it
  if [ ! -d "/run/media/winiso" ]; then
    mkdir /run/media/winiso
  else
    # If the directory already exists, unmount any existing filesystems and remove the directory and its contents
    umount /run/media/winiso || :
    rm -rf /run/media/winiso
    mkdir /run/media/winiso
    mount -o loop Win*.iso /run/media/winiso
  fi

  # Mount the Windows ISO file using the loopback device and copy its contents to the /mnt directory, excluding the install.wim file
  printf "Copying Windows ISO contents to /mnt directory...\n"
  rsync -a --info=progress2 --no-links --no-perms --no-owner --no-group --exclude sources/install.wim /run/media/winiso/ /mnt/

  # Export the install.wim file to an install.esd file using wimlib-imagex
  printf "Exporting install.wim file to install.esd file...\n"
  wimlib-imagex export /run/media/winiso/sources/install.wim all /mnt/sources/install.esd --solid

  # Unmount the Windows ISO file and remove the temporary directory
  umount /run/media/winiso || :
  rm -rf /run/media/winiso

  # Unmount the drive partition
  printf "Unmounting drive partition %s1...\n" "$drive"
  umount "$drive"1

  # Print a message indicating that the installation has finished
  printf "Windows installation complete!\n"
}

main() {
  welcome "$@"
  getthedrive "$@"
  format_drive "$@"
  extract "$@"
}

main "$@"
