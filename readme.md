# hnwProxy

hnwProxy is a proxy server you can use to simulate a broken Internet connection. It is being developed as a tool to help HowNetWorks' development.
 
## Features
hnwProxy uses a simple module system to run scripts that break things. The command `proxy show` will list available modules, all of these can be called without arguments for usage information. (more info about modules under guestfiles/proxy_cli)  

 * Broken MTU
 * Port block (drop & tcp rst)
 * DNS redirect
 * Transparent proxy (http & https)

## Providers
hnwProxy supports 3 providers:

### Virtualbox

1. (optional) Enable bridged networking in `settings.yaml`if you have a wired NIC available.
2. Run `vagrant up`

### Hyper-V

1. Ensure you have one `external` type external switch configured in Hyper-V. 
2. Run  `vagrant up` (include `--provider=hyperv` if vagrant doesn't recognize this automatically)

### DigitalOcean
1. Install DO plugin: `vagrant plugin install vagrant-digitalocean`
2. Create API token: https://cloud.digitalocean.com/settings/api/tokens
3. Add token to `settings.yaml`
4. (optional) Change DO region in `settings.yaml`.
5. `vagrant up --provider=digital_ocean`


## Usage

1. Install [Vagrant](https://www.vagrantup.com/downloads.html)

2. Download hnwProxy: `git clone https://github.com/HowNetWorks/hnwProxy.git`

3. Start hnwProxy using one of the providers above ^.

4. Connect via SSH & create a SOCKS5 proxy `vagrant ssh -- -D 6000`

5. Set your browser to proxy requests to localhost:6000.

6. Use the command `proxy` to see what you can break in hnwProxy.

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
