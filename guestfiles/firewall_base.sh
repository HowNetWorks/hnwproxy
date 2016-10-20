#!/usr/bin/env bash
# script to configure base firewall settings

set -e

### IPv4 ###
iptables -F

# exclude ssh from further mangling
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

### IPv6 ###
ip6tables -F

# exclude ssh from further mangling
ip6tables -A OUTPUT -p tcp --sport 22 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT

############

service iptables-persistent save