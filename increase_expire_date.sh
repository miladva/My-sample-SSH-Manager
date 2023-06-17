#!/bin/bash
#
days=$2

# Calculate the new date
new_date=$(date --date="+${days} days" "+%Y-%m-%d")

# Update user account with new date
usermod -e "$new_date" "$1"
echo $1 $2 >> /root/extended_users.txt
