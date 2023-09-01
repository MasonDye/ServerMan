#!/bin/bash

# ---Server Manage Script---
# Author : Mason https://blog.almondnet.cn/
# wget https://raw.githubusercontent.com/MasonDye/ServerMan/main/ServerMan.sh && chmod 777 ServerMan.sh && bash ServerMan.sh

# Print gui
print_menu() {
  clear
  echo "---Server Manage Script---"
  echo "Author : Mason https://blog.almondnet.cn/"
  echo "------------------------------"
  echo "1. Set root password"
  echo "2. Edit ssh port"
  echo "3. Allow ssh root login"
  echo "4. Allow ssh password login"
  echo "------------------------------"
  echo "0. Quit"
  echo "------------------------------"
  echo -n "Please choose : "
}

# Set root password
set_root_password() {
  echo -n "Enter new root password: "
  read -s new_password
  echo "root:$new_password" | chpasswd
  echo -e "\nRoot password updated successfully."
  read -n 1 -s -r -p "Press any key to continue..."
}

# Edit ssh port
edit_ssh_port() {
  echo -n "Enter new SSH port: "
  read new_port
  sed -i "s/Port [0-9]*/Port $new_port/" /etc/ssh/sshd_config
  systemctl restart ssh
  echo "SSH port updated to $new_port."
  read -n 1 -s -r -p "Press any key to continue..."
}

# Allow ssh root login
allow_ssh_root_login() {
  sed -i "s/PermitRootLogin .*/PermitRootLogin yes/" /etc/ssh/sshd_config
  systemctl restart ssh
  echo "SSH root login allowed."
  read -n 1 -s -r -p "Press any key to continue..."
}

# Allow ssh password login
allow_ssh_password_login() {
  sed -i "s/PasswordAuthentication .*/PasswordAuthentication yes/" /etc/ssh/sshd_config
  systemctl restart ssh
  echo "SSH password login allowed."
  read -n 1 -s -r -p "Press any key to continue..."
}

# Main while
while true; do
  print_menu
  read choice

  case $choice in
    1) set_root_password ;;
    2) edit_ssh_port ;;
    3) allow_ssh_root_login ;;
    4) allow_ssh_password_login ;;
    0) exit 0 ;;
    *) echo "Invalid choice. Please choose again." ;;
  esac
done
