---
slug: i3-setup
date: 2020-11-23
tags: [nixos, mtsa]
---

:::{.ui .message}
The first step of the [[Make Tech Simple Again]] project is to go back to [[i3]]. Why i3, and not [[GNOME]]? Because I have come to believe that i3's workflow **encourages focus & simplicity** (more on this later). This note is just a historical record of what I did to get i3 working on both of my machines.
:::

First, **consult the [NixOS wiki][wiki]** for basic instructions on seting up i3 on a NixOS machine. This note will focus on the various little things that must be configured for an acceptable user experience on Thinkpads, mainly [[P71]] and [[X1C7]].

[wiki]: https://nixos.wiki/wiki/I3

## Declarative i3 config

i3 will autogenerate the config file when you first login. You will want to put this in your Nix configuration. Move the generated config file (in `~/.config/i3/config`) to your Nix repository, and use `configFile = ./i3.conf` under `windowManager.i3`[^w1] in order to declaratively specify it.

[^w1]: ... assuming you used the NixOS wiki instructions linked above 

## HiDPI displays

If any of your screens have 4k+ resolution, you'll want to change the pixel density (DPI) so that text and UI elements don't appear too tiny. One way to do this is to specify the DPI in the [`.Xresources`](https://wiki.archlinux.org/index.php/x_resources) file, which can be declaratively done using [home-manager](https://github.com/nix-community/home-manager):

```nix
home.file = {
  ".Xresources".text = ''
    Xft.dpi: 196
  '';
};
```

You will also have to instruct X to merge these resources using `xrdb` on startup. When configuring i3 using configuration.nix (not home-manager) configuration, you can do this as follows:

```nix
windowManager.i3.extraSessionCommands = ''
  ${pkgs.xorg.xrdb}/bin/xrdb -merge ~/.Xresources
''
```

Cursor size will still be tiny, which can be fixed using home-manager configuration:

```nix
  # High DPI cursor fix
  # https://github.com/NixOS/nixpkgs/issues/34603
  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
  };
```

## Automatic screen lock

Various solutions exist, but one way to configure automatic screen locking is to use the `xautolock` program. nixpkgs provides a systemd service for it:

```nix
# Auto-lock
xautolock = {
  enable = true;
  time = 5; # mins

  # Suspend after sometime
  killtime = 20; # mins
  killer = "/run/current-system/systemd/bin/systemctl suspend";
};
```

Disable autosuspend if you experience the [[System freeze on wake-up with Thunderbolt]] bug. You can manually suspend by running `systemctl suspend`.

## Monitor plug and play

Unlike GNOME, in i3 you will explicitly have to configure external screens when docking or undocking the laptop. While `arandr` can be used to do this manually, it is better to use a service like `autorandr` to automatically switch configuration when docking state changes. 

```nix
# Monitor plug n play
# https://github.com/phillipberndt/autorandr/blob/v1.0/README.md#how-to-use
services.autorandr = {
  enable = true;
};
```

Read the link for initial setup; in particular you will have to use `autorandr --save` for each docked state to tell autorandr what screen configuration to automatically switch to.

## Trackpad & trackpoint configuration

Having used to macOS, I prefer "natural scrolling" direction. On HiDPI displays (such as the 4k of X1C7 and 5k of [[LG Ultrafine 5k]]), you will also want to increase the acceleration speed of both trackpoint and trackpad. Both of this can be achieved by configuring libinput:

```nix
services.xserver.libinput = {
  enable = true;
  # macOS like behaviour
  naturalScrolling = true;
  # Increase touchpad/trackpoint speed. 1.0 is maximum speed.
  # Changing this value won't take effect until X restart.
  accelSpeed = "0.5";
};
```
## Comments about this note

- [r/NixOS](https://www.reddit.com/r/NixOS/comments/k09cf2/setting_up_i3_on_thinkpads_running_nixos/)

## Links

- Link to my config: 
  - [nixos/i3.nix](https://github.com/srid/nix-config/blob/593418b1d7dc6f5d022b05452c5e1483a51d3e9b/nixos/i3.nix)
  - [nixos/i3.conf](https://github.com/srid/nix-config/blob/593418b1d7dc6f5d022b05452c5e1483a51d3e9b/nixos/i3.conf)
  - home-manager [i3-config.nix](https://github.com/srid/nix-config/blob/593418b1d7dc6f5d022b05452c5e1483a51d3e9b/nix/i3-config.nix)