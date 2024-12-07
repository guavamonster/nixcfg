# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."portainer" = {
    image = "portainer/portainer-ce:latest";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/root/nixcfg/Beaver/portainer/portainer-data:/data:rw"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    ports = [ "9000:9000/tcp" ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=portainer"
      "--network=portainer_default"
      "--security-opt=no-new-privileges:true"
    ];
  };
  systemd.services."docker-portainer" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [ "docker-network-portainer_default.service" ];
    requires = [ "docker-network-portainer_default.service" ];
    partOf = [ "docker-compose-portainer-root.target" ];
    wantedBy = [ "docker-compose-portainer-root.target" ];
  };

  # Networks
  systemd.services."docker-network-portainer_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f portainer_default";
    };
    script = ''
      docker network inspect portainer_default || docker network create portainer_default
    '';
    partOf = [ "docker-compose-portainer-root.target" ];
    wantedBy = [ "docker-compose-portainer-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-portainer-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
