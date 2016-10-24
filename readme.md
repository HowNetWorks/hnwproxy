# hnwProxy

hnwProxy is a proxy server you can use to simulate a broken Internet connection. It is being developed as a tool to help HowNetWorks' development.

## Goals
 * codified to the max
   * configuration is not tied to a bulky virtual machine image
   * quick, easy deployment
 * deployable to VirtualBox, Hyper-V, and 1-2 cloud providers (tbd).
 * support a subset of HowNetWorks tests
 
## Features
You can break things with hnwProxy using modules.The command `proxy show` will list available modules, all of these can be called without arguments for usage information. 

 * Broken MTU
 * Port block (drop & tcp rst)
 * DNS redirect

## Usage

1. Install [Vagrant](https://www.vagrantup.com/downloads.html)

2. Install a supported virtualization provider ([VirtualBox](https://www.virtualbox.org/) or Hyper-V)

3. Download hnwProxy: `git clone https://github.com/HowNetWorks/hnwProxy.git`

4. Start hnwProxy: `vagrant up [--provider=hyperv]` (--provider might be necessary with windows/hyperv).

5. Connect via SSH & create a SOCKS5 proxy `vagrant ssh -- -D 6000`

6. Set your browser to proxy requests to localhost:6000.

7. Use the command `proxy` to see what you can break in hnwProxy.
```
PS D:\git\hnwProxy> vagrant ssh -- -D 6000

vagrant@hnwproxy:~$ proxy
USAGE
  proxy <module_name> [options]
  proxy show

OPTIONS
  module_name   Run this module.
  show          List available modules.
vagrant@hnwproxy:~$ proxy  show

 dns-redirect - Redirect DNS requests to another server.
 Usage: proxy dns-redirect <ip>

 mtu - break mtu
 usage: proxy mtu [value]

 port - Filters traffic by outgoing destination port.
 Run without arguments for usage information.

vagrant@hnwproxy:~$ proxy dns-redirect 127.0.0.1
vagrant@hnwproxy:~$ proxy dns-redirect ::0
vagrant@hnwproxy:~$ proxy dns-redirect show
Redirecting IPv4 DNS requests to 127.0.0.1
Redirecting IPv6 DNS requests to ::
vagrant@hnwproxy:~$ ping google.com
ping: unknown host google.com
```