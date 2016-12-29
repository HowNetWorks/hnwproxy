# hnwProxy
[![CircleCI](https://circleci.com/gh/HowNetWorks/hnwproxy.svg?style=shield)](https://circleci.com/gh/HowNetWorks/hnwproxy)

hnwProxy is a proxy server you can use to simulate a broken Internet connection. It is being developed as a tool to help HowNetWorks' development.

## Features
hnwProxy uses a simple module system to run scripts that break things. The command `proxy show` will list available modules, all of these can be called without arguments for usage information. (more info about modules under guestfiles/proxy_cli)  

 * Broken MTU
 * Port block (drop & tcp rst)
 * DNS redirect
 * Transparent proxy (http & https)

## Usage

 1. Install [Vagrant](https://www.vagrantup.com/downloads.html)
 2. Download hnwProxy: `git clone https://github.com/HowNetWorks/hnwProxy.git`
 3. Start hnwProxy with a supported [provider](#providers).
 4. [Connect](#connecting-to-hnwproxy).
 5. Use the command `proxy` to see what you can break in hnwProxy.


## Providers
hnwProxy supports 3 providers:

### VirtualBox
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. (optional) Enable bridged networking in `settings.yaml`if you have a wired NIC available.
3. Run `vagrant up`

### Hyper-V
1. Ensure you have one `external` type external switch configured in Hyper-V.
2. Run  `vagrant up` (include `--provider=hyperv` if vagrant doesn't recognize this automatically)

### DigitalOcean
1. Install DO plugin: `vagrant plugin install vagrant-digitalocean`
2. Create API token: https://cloud.digitalocean.com/settings/api/tokens
3. Add token to `settings.yaml`
4. (optional) Change DO region in `settings.yaml`.
5. `vagrant up --provider=digital_ocean`

## Connecting to hnwProxy

### SOCKS
1. `vagrant ssh -- -D 6000`
2. Set localhost:6000 as your socks5 proxy.

### PPTP VPN
1. Connect via SSH (`vagrant ssh`).
2. `proxy pptp`
3. Connect with the shown settings.

## misc

### Vagrant Commands

 * Stop VM: `vagrant halt`
 * Delete VM: `vagrant destroy`
 * Update VM: `vagrant halt && vagrant up --provision` (fast and works most of the time)
 * Update VM: `vagrant destroy && vagrant up`

### Example
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
