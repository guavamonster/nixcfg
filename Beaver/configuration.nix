{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ./nginx
    ./planka/docker-compose.nix
    ./tianji/docker-compose.nix
    ./owncloud/docker-compose.nix
    ../shared/sops.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      busybox
      vim
      git
      home-manager
      docker-client
    ];
  };

  programs.zsh.enable = true;
  # set Zsh as the default user shell for all users
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "nixos-beaver-8gb-nbg1-3";
  networking.domain = "";

  services.sslh = {
    enable = true;
    listenAddress = "0.0.0.0";
    verbose = false;
    appendConfig = ''
      protocols:
      (
        { name: "ssh"; service: "ssh"; host: "localhost"; port: "22"; probe: "builtin"; },
        { name: "http"; host: "localhost"; port: "80"; probe: "builtin"; },
        { name: "ssl"; host: "localhost"; port: "4430"; probe: "builtin"; },
      );
    '';
  };

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSO4cOiA8s9hVyPtdhUXdshxDXXPU15qM8xE0Ixfc21'' ];

  system.stateVersion = "23.11";
}
