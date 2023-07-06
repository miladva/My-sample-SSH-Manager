#!/bin/bash
#
password=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 5 | head -n 1)

file_path="/root/userpass.txt"


if id "$1" >/dev/null 2>&1; then
    usermod -p $(perl -e 'print crypt($ARGV[0], "password")' "$password") $1
    sed -i "/$1/c\\$1 $password $2" "$file_path"
else
    useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' "$password") $1
    echo $1 >> /root/users.txt
    echo $1 $password $2 >> /root/userpass.txt

fi

chown -R root:root /home/$1/
usermod -a -G vpn $1

days=$2
new_date=$(date --date="+${days} days" "+%Y-%m-%d")

# Update user account with new date
usermod -e "$new_date" "$1"
echo $1 $password $2
