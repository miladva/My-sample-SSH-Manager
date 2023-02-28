#!/bin/bash
# 

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

while read line; do
  if [[ `ps -u $line | grep sshd | wc -l` -ge 15 ]]
  then
    PROCESSES=`ps -u $line | grep sshd | awk '{ print $1 }'`
    sudo killall -u $line
    userdel -f $line
    kill -9 $PROCESSES
    echo "found user $line with process count: `ps -u $line | grep sshd | wc -l` -- pids: $PROCESSES" >> /root/events.txt
  fi

  if [[ `ps -u $line | grep sshd | wc -l` -ge 3 ]]
  then
    PROCESSES=`ps -u $line | grep sshd | awk '{ print $1 }'`
    echo "found user $line with process count: `ps -u $line | grep sshd | wc -l` -- pids: $PROCESSES" >> /root/dis.txt 
    kill -9 $PROCESSES
  fi

done < /root/users.txt
