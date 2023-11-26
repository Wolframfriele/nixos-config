# nixos-simple
My simple setup for nixos from the ground up.


Build the laptop with:

```
sudo nixos-rebuild switch --flake .#laptop
```

Update all flake inputs with:

```
sudo nix flake update
```

Update certain inputs with:
```
sudo nix flake lock --update-input anyrun
```

## Desktop environment

- Display Manager: gdm
- Window manager: Hyprland
- Status bar: Waybar
- Launcher: fuzzel
- notification daemon: mako
- wallpaper setter: swww
- Lockscreen: swaylock-effects
- clipboard manager: copyq + xclip
- shutdown menu: wlogout
- screenshot tool: grim + Slurp
- brightness control: brightnessctl
- Audio control: pamixer + pavucontrol
- Bluetooth control: bluez + bluez-utils + blueman
- network control: network-manager-applet
- File manager: Thunar

## System apps

- killall
- wget
- curl
- gnome-keyring

## Terminal apps

- Editor: Neovim
- Filebrowser: lf
- ripgrep
- starship
- btop
- fzf
- tree
- w3m

## Applications

- Firefox
- Obsidian
- VSCodium
- Lapce
- Docker
- Celium

## Programming languages
- rust
- python
- Go
- C#
- C

## Interesting articles

https://www.maxwellrules.com/misc/nvim_jupyter.html using jupyter notebooks in neovim

## Workspace idea's

- Workspace 1: Communication and music (Dashboard like) [Discord, Teams, Spotify, Signal]
- Workspace 2: Main Work
- Workspace 3: Chill / Personal
- Workspace 4: Overflow
