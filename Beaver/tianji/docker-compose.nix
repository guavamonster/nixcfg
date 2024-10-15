# Auto-generated using compose2nix v0.2.3-pre.
{ pkgs, lib, ... }:
let
  # POSTGRES_PASSWORD = builtins.readFile "/run/secrets/TIANJI/POSTGRES_PASSWORD";
  # JWT_SECRET = builtins.readFile "/run/secrets/TIANJI/JWT_SECRET";
in
{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."tianji-postgres" = {
    image = "postgres:15.4-alpine";
    environment = {
      "POSTGRES_DB" = "tianji";
      "POSTGRES_PASSWORD" = "tianji";
      "POSTGRES_USER" = "tianji";
    };
    volumes = [
      "tianji_tianji-db-data:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=pg_isready -U \${POSTGRES_USER} -d \${POSTGRES_DB}"
      "--health-interval=5s"
      "--health-retries=5"
      "--health-timeout=5s"
      "--network-alias=postgres"
      "--network=tianji_default"
    ];
  };
  systemd.services."docker-tianji-postgres" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-tianji_default.service"
      "docker-volume-tianji_tianji-db-data.service"
    ];
    requires = [
      "docker-network-tianji_default.service"
      "docker-volume-tianji_tianji-db-data.service"
    ];
    partOf = [
      "docker-compose-tianji-root.target"
    ];
    wantedBy = [
      "docker-compose-tianji-root.target"
    ];
  };
  virtualisation.oci-containers.containers."tianji-tianji" = {
    image = "moonrailgun/tianji";
    environment = {
      "ALLOW_OPENAPI" = "true";
      "ALLOW_REGISTER" = "false";
      "DATABASE_URL" = "postgresql://tianji:tianji@postgres:5432/tianji";
      "JWT_SECRET" = "AEAZEAZEAZEAZAZEAZEAEAZEAZEAZ";
    };
    ports = [
      "12345:12345/tcp"
    ];
    dependsOn = [
      "tianji-postgres"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=tianji"
      "--network=tianji_default"
    ];
  };
  systemd.services."docker-tianji-tianji" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-tianji_default.service"
    ];
    requires = [
      "docker-network-tianji_default.service"
    ];
    partOf = [
      "docker-compose-tianji-root.target"
    ];
    wantedBy = [
      "docker-compose-tianji-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-tianji_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f tianji_default";
    };
    script = ''
      docker network inspect tianji_default || docker network create tianji_default
    '';
    partOf = [ "docker-compose-tianji-root.target" ];
    wantedBy = [ "docker-compose-tianji-root.target" ];
  };

  # Volumes
  systemd.services."docker-volume-tianji_tianji-db-data" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect tianji_tianji-db-data || docker volume create tianji_tianji-db-data
    '';
    partOf = [ "docker-compose-tianji-root.target" ];
    wantedBy = [ "docker-compose-tianji-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-tianji-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
