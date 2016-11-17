## Proxy CLI

Proxy CLI is a tool to run and discover modules under proxy_modules.

Running `proxy module_name [args]` will run proxy_modules/module_name/module_name along with any parameters.

Files:
````bash
# required
proxy_modules/module_name              # directory
proxy_modules/module_name/module_name  # executable
proxy_modules/module_name/description  # plaintext description

# optional
proxy_modules/module_name/setup        # executable, run during server provisioning
````
`description` is read by proxy cli when listing modules, it should be concise and end with a blank line.


