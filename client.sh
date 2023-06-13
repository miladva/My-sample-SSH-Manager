#!/bin/bash
#

useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' "$2") $1
chown -R root:root /home/$1/
usermod -a -G vpn $1

days = 31

# Calculate the new date
new_date=$(date --date="+${days} days" "+%Y-%m-%d")

# Update user account with new date
usermod -e "$new_date" "$1"
echo $1 >> /root/users.txt
echo $1 $2 >> /root/userpass.txt
echo $1 $2


# run command:
# ssh root@194.5.157.162 bash /root/client.sh xxx 1
