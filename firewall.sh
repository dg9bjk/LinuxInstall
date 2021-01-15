#!/bin/sh
#
FW="/sbin/iptables"
ETH0='enp0s3'
ETH1='eth1'
WLAN0='wlan0'
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
$FW -P INPUT DROP
$FW -P OUTPUT DROP
$FW -P FORWARD DROP
$FW -N InputNew
$FW -N OutputNew
$FW -N ForwardNew
#

# Standardverhalten NAT-TABLE
# ALT: NICHT MEHR MÖGLICH !!!!
echo -n .
#$FW -t nat -P OUTPUT DROP
#$FW -t nat -P PREROUTING DROP
#$FW -t nat -P POSTROUTING DROP

#$FW -t nat -A OUTPUT -j ACCEPT
#$FW -t nat -A PREROUTING -j ACCEPT
#$FW -t nat -A POSTROUTING -j ACCEPT
#

# Standardverhalten MANGLE-TABLE
echo -n .
$FW -t mangle -P INPUT DROP
$FW -t mangle -P OUTPUT DROP
$FW -t mangle -P FORWARD DROP
$FW -t mangle -P PREROUTING DROP
$FW -t mangle -P POSTROUTING DROP

$FW -t mangle -A INPUT -j ACCEPT
$FW -t mangle -A OUTPUT -j ACCEPT
$FW -t mangle -A FORWARD -j ACCEPT
$FW -t mangle -A PREROUTING -j ACCEPT
$FW -t mangle -A POSTROUTING -j ACCEPT
#

# Basis Input Filter
echo -n .
$FW -A INPUT -i $ETH0 -m state --state RELATED,ESTABLISHED -j ACCEPT # alle aktiven Verbindungen
$FW -A INPUT -i $ETH0 -p icmp --icmp-type 0 -j ACCEPT # Ping Antwort
$FW -A INPUT -i $ETH0 -p icmp --icmp-type 8 -j ACCEPT # Ping Frage
$FW -A INPUT -i $ETH0 -m state --state NEW -j InputNew
$FW -A InputNew -i $ETH0 -p tcp --dport 22 -j ACCEPT # SSH
$FW -A InputNew -i $ETH0 -p tcp --dport 80 -j ACCEPT # Webserver
#
# Basis Output Filter
echo -n .
$FW -A OUTPUT -o $ETH0 -m state --state RELATED,ESTABLISHED -j ACCEPT # alle aktiven Verbindungen
$FW -A OUTPUT -o $ETH0 -p icmp --icmp-type 0 -j ACCEPT # Ping Antwort
$FW -A OUTPUT -o $ETH0 -p icmp --icmp-type 8 -j ACCEPT # Ping Frage
$FW -A OUTPUT -o $ETH0 -m state --state NEW -j OutputNew
$FW -A OutputNew -o $ETH0 -p tcp --dport 53 -j ACCEPT # DNS
$FW -A OutputNew -o $ETH0 -p udp --dport 53 -j ACCEPT # DNS
$FW -A OutputNew -o $ETH0 -p tcp --dport 80 -j ACCEPT # Update 
$FW -A OutputNew -o $ETH0 -j REJECT
#
# Basis Forward Filter
echo -n .
$FW -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT # alle aktiven Verbindungen
$FW -A FORWARD -m state --state NEW -j ForwardNew
$FW -A ForwardNew -o $ETH0 -j REJECT
#

echo .
#