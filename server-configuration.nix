{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    tmux
    docker
    docker-compose
    git
    bash
    cron
  ];

  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 22 ];
  networking.firewall.enable = true;

  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *	root	sh /etc/nixos/illchess/deploy-if-change.sh"
    ];
  };
}
