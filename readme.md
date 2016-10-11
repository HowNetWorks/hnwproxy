﻿# hnwProxy

hnwProxy is an appliance you can insert between your browser and the Internet to simulate a poorly working network connection. It is being developed as a tool to help HowNetWorks' development, and is intended to be used as a proxy server either locally as a virtual machine or deployed to a cloud provider.

### Goals
 * codified to the max
   * configuration is not tied to a bulky virtual machine image
   * quick, easy deployment
 * deployable to VirtualBox, Hyper-V, and 1-2 cloud providers (tbd).
 * support a subset of HowNetWorks tests
 
### Technology Stack

1. Vagrant to deploy the the virtual machine.
2. Ansible and shell scripts for its configuration. 
3. Various scripts to systematically break the server

### Usage

1. Install [Vagrant](https://www.vagrantup.com/downloads.html)
2. Download hnwProxy: `git clone https://github.com/HowNetWorks/hnwProxy`
