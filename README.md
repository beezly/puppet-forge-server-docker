# Docker image for Puppet Forge Server
Docker image to run a private Puppet Forge Server (https://github.com/unibet/puppet-forge-server)

See the usage section for more details.

## Usage
Generic configuration can be driven by exporting the following enviroment variables:

| Environment variable  | Description |
| ------------- | ------------- |
| PUPPET_FORGE_SERVER_PROXY | Remote forge URL |
| PUPPET_FORGE_SERVER_RAM_CACHE_SIZE | Size of Ram Cache (in entries) | 
| PUPPET_FORGE_SERVER_RAM_CACHE_TTL | TTL of Ram Cache (in seconds) |

## Run
```
docker run -d --restart=always -p 8080:8080 -v <path_to_modules>:/srv/forge/modules beezly/puppet-forge-server-docker
```
