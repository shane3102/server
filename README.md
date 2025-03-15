# Server

Server configuration for my personal projects based on [NixOS](https://nixos.org/).

### Usage
Clone or add origin to repository and include `server-configuration.nix` in your `configuration.nix` then rebuild your system via: 
```
nixos-rebuild switch
```
Run any of available apps by entering corresponding folder and running:
```
docker compose up -d
```

### Info
Each app is run via docker compose with images available on public [Docker Hub](https://hub.docker.com). Mapping urls to specific services is done via [Caddy](https://caddyserver.com). At the moment each site is available under `shane3102.pl` domain.

### Apps
Currentlly available deployed apps are:
* Illchess - [link](https://illchess.shane3102.pl), [repository](https://github.com/shane3102/illchess)
* Leon - [link](https://leon.shane3102.pl), [repository](https://github.com/shane3102/leon)
* Portfolio - [link](https://bartlomiej.kucharczyk.shane3102.pl), [repository](https://github.com/shane3102/portfolio)
* Nexus - [link](https://nexus.shane3102.pl)
