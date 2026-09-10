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

  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/10 * * * *	root	sh /etc/nixos/illchess/deploy-if-change.sh"
      "5-59/10 * * * *	root	sh /etc/nixos/portfolio/deploy-if-change.sh"
    ];
  };

  services.fail2ban = {
    enable = true;
    bantime = "168h";
    maxretry = 5;

    ignoreIP = [
      "127.0.0.1/8"
      "192.168.0.0/16"
      "172.16.0.0/12"
      "10.0.0.0/8"
    ];
  };
}
