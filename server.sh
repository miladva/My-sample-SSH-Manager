#!/bin/bash
#

groupadd vpn
echo -e "#<domain>      <type>   <item>          <value>\n@student       -        maxlogins       4" > /etc/security/limits.conf
