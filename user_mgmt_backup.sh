#!/bin/bash

# User Management and Backup Script

# Function to add a user
add_user() {
  read -p "Enter username to add: " username
  if id "$username" &>/dev/null; then
    echo "User '$username' already exists."
  else
    sudo useradd -m "$username"
    echo "User '$username' added."
  fi
}

# Function to delete a user
delete_user() {
  read -p "Enter username to delete: " username
  if id "$username" &>/dev/null; then
    sudo userdel -r "$username"
    echo "User '$username' deleted."
  else
    echo "User '$username' does not exist."
  fi
}

# Function to backup a user's home directory
backup_user() {
  read -p "Enter username to backup: " username
  if id "$username" &>/dev/null; then
    backup_dir="/backup"
    mkdir -p $backup_dir
    timestamp=$(date +"%Y%m%d%H%M%S")
    tar -czvf "$backup_dir/${username}_home_$timestamp.tar.gz" "/home/$username"
    echo "Backup created at $backup_dir/${username}_home_$timestamp.tar.gz"
  else
    echo "User '$username' does not exist."
  fi
}

# Main menu
while true; do
  echo -e "\nUser Management and Backup Script"
  echo "1. Add User"
  echo "2. Delete User"
  echo "3. Backup User Home Directory"
  echo "4. Exit"
  read -p "Choose an option [1-4]: " choice

  case $choice in
    1) add_user ;;
    2) delete_user ;;
    3) backup_user ;;
    4) echo "Exiting."; exit 0 ;;
    *) echo "Invalid option. Please try again." ;;
  esac
done
