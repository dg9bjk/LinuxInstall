#!/bin/sh
#
FW="/sbin/iptables"
#

# Tabellen löschen
echo -n .
$FW -F
$FW -t nat -F
$FW -t mangle -F
$FW -X
#

# Standardverhalten BASIS
echo -n .
$FW -P INPUT ACCEPT
$FW -P OUTPUT ACCEPT
$FW -P FORWARD ACCEPT
#

# Standardverhalten NAT-TABLE
# ALT: NICHT MEHR MÖGLICH !!!!
echo -n .
$FW -t nat -P OUTPUT ACCEPT
$FW -t nat -P PREROUTING ACCEPT
$FW -t nat -P POSTROUTING ACCEPT
#

# Standardverhalten MANGLE-TABLE
echo -n .
$FW -t mangle -P INPUT ACCEPT
$FW -t mangle -P OUTPUT ACCEPT
$FW -t mangle -P FORWARD ACCEPT
$FW -t mangle -P PREROUTING ACCEPT
$FW -t mangle -P POSTROUTING ACCEPT
#

echo .
#