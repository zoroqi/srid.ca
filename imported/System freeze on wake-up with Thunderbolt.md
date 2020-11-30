---
slug: 45997a20
date: 2020-11-21T15:05
tags: [x1c7/issues/resolved]
---

# System freeze on wake-up w/ Thunderbolt

If a 5k monitor is connected to the Thunderbolt port of [[X1C7]], and the laptop suspends after a timeout, then a wake-up will do nothing, creating the impression that the system has frozen. The only solution is a hard reboot.

## Workaround

Prevent idle suspend, or delay it.

```nix
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    IdleAction=suspend
    IdleActionSec=40m
  '';
```

On GNOME, you will have to disable the naughty GDM behaviour by [configuring systemd](https://discourse.nixos.org/t/stop-pc-from-sleep/5757).

## Resolution

This issue automatically resolved at one point. Around that time I had updated to Linux kernel 5.9.11. It is not clear if that was the factor.