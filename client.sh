#!/bin/bash
#

useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' "$2") $1
chown -R root:root /home/$1/
usermod -a -G vpn $1
usermod -e `date --date='+$3 days' '+%Y-%m-%d'` $1

echo $1 >> /root/users.txt


# run command:
# ssh root@194.5.157.162 bash /root/client.sh xxx 1
