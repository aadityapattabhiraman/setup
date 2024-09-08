#!/bin/bash

# Check for AUR managers and store the first one found in a variable
aur_manager=""
if command -v yay &> /dev/null; then
  aur_manager="yay"
elif command -v trizen &> /dev/null; then
  aur_manager="trizen"
elif command -v pacaur &> /dev/null; then
  aur_manager="pacaur"
elif command -v pamac &> /dev/null; then
  aur_manager="pamac"
elif command -v pikaur &> /dev/null; then
  aur_manager="pikaur"
fi

# Check if an AUR manager was found
if [ -z "$aur_manager" ]; then
  echo "No AUR manager found. Please install one first."
  exit 1
fi

# List of packages to install
packages=("package1" "package2" "package3")  # Replace with your packages

# Install packages using the found manager
$aur_manager -S "${packages[@]}"
