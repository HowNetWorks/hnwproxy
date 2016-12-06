#!/usr/bin/env bash
# script to configure pptpd

{
  echo 'option /etc/ppp/pptpd-options'
  echo 'logwtmp'
  # randomly chosen subnet
  echo 'localip 172.20.0.1'
  echo 'remoteip 172.20.0.100-200'
} > /etc/pptpd.conf

# set dns servers
sed -i 's/^#ms-dns 10.0.0.1$/ms-dns 8.8.8.8/g' /etc/ppp/pptpd-options
sed -i 's/^#ms-dns 10.0.0.2$/ms-dns 8.8.4.4/g' /etc/ppp/pptpd-options

# configure users
echo "vagrant * $(tr -cd 'a-zA-Z0-9' < /dev/urandom | head -c 14) *" > /etc/ppp/chap-secrets

# iptables rules
iptables -A OUTPUT -p tcp --sport 1723 -j ACCEPT
iptables -A INPUT -p tcp --dport 1723 -j ACCEPT
ip6tables -A OUTPUT -p tcp --sport 1723 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 1723 -j ACCEPT

iptables -t nat -A POSTROUTING -s 172.20.0.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -p tcp --syn -s 172.20.0.0/24 -j TCPMSS --set-mss 1356

service iptables-persistent save
