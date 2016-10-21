# hnwProxy

hnwProxy is a proxy server you can use to simulate a broken Internet connection. It is being developed as a tool to help HowNetWorks' development.

## Goals
 * codified to the max
   * configuration is not tied to a bulky virtual machine image
   * quick, easy deployment
 * deployable to VirtualBox, Hyper-V, and 1-2 cloud providers (tbd).
 * support a subset of HowNetWorks tests
 
## Supported tests

 * Broken MTU
 * Port block (silently drop)
 
Todo:
 * Port block (tcp rst & icmp unreachable)
 * DNS Redirect (iptables DNAT maybe)
 

## Usage

1. Install [Vagrant](https://www.vagrantup.com/downloads.html)

2. Install a supported virtualization provider ([VirtualBox](https://www.virtualbox.org/) or Hyper-V)

3. Download hnwProxy: `git clone https://github.com/HowNetWorks/hnwProxy.git`

4. Start hnwProxy: `vagrant up [--provider=hyperv]` (--provider might be necessary with windows/hyperv).

5. Connect via SSH & create a SOCKS5 proxy `vagrant ssh -- -D 6000`

6. Set your browser to proxy requests to localhost:6000.

7. Use the command `proxy` to see what you can break in hnwProxy.
```
vagrant@hnwproxy:~$ proxy
USAGE
  proxy <module_name> [options]
  proxy <show>

OPTIONS
  module_name   Run this module.
  show          List available modules.
vagrant@hnwproxy:~$ proxy show

Available modules:

 mtu - break mtu
 usage: proxy mtu [value]

 port-drop - silently drop packets going to a port
 usage: proxy port-drop <single|rangeStart:rangeEnd>

vagrant@hnwproxy:~$ proxy port-drop
USAGE
  proxy port-drop <single|rangeStart:rangeEnd>
  proxy port-drop <flush>
  proxy port-drop <show>

OPTIONS
  single                A single port. E.g. 8080
  rangeStart:rangeEnd   A range of ports. E.g. 560:570
  flush                 Flush active rules.
  show                  Show active rules.
vagrant@hnwproxy:~$ proxy port-drop 560:570
vagrant@hnwproxy:~$ proxy port-drop show
Active rules:
IPv4
tcp 560:570 DROP
udp 560:570 DROP
IPv6
tcp 560:570 DROP
udp 560:570 DROP
```