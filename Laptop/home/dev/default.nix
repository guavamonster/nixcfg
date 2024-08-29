{ pkgs
, ...
}:
{
  imports = [
    ./R
    ./python
  ];

  home = {
    packages = with pkgs;
      [
        # Developpment
        nodePackages.node2nix
        openssh
        scdoc
        git
        gcc
        lua
        go
        cmake
      ];
  };
}