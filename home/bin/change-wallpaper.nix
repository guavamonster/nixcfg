{ pkgs, ... }:

pkgs.writeShellScriptBin "change-wallpaper"
  ''
    file=$(ls ~/wallpaper/ | shuf -n 1)
    swww img ~/wallpaper/$file --transition-step 10 --transition-fps 30 --transition-type center &
    wal -i ~/wallpaper/$file &
    sleep 0.01
    eww reload &
    /./home/justalternate/.config/dotfiles/home/rice/pywal/pywal-discord/pywal-discord &
    sleep 0.5
    cp ~/.cache/wal/cava_conf ~/.config/cava/config &
    [[ $(pidof cava) != "" ]] && pkill -USR1 cava &
  ''
