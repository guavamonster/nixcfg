{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      poetry
      SDL2
      SDL2_image
      SDL2_gfx
      (python3.withPackages (
        ps: with ps; [
          flask
          hypothesis
          pygame
          psutil
          pygame-sdl2
          psutil
          matplotlib
          numpy
          opencv4
          pandas
          pillow
          pip
          pipenv
          plotly
          pytorch
          requests
          scipy
          seaborn
          transformers
          virtualenv
        ]
      ))
    ];
  };
}
