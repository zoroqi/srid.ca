---
slug: 45997a20
date: 2020-11-21T15:05
tags: [x1c7/issues]
---

# System freeze on wake-up w/ Thunderbolt

If a 5k monitor is connected to the Thunderbolt port of [[X1C7]], and the laptop suspends after a timeout, then a wake-up will do nothing, creating the impression that the system has frozen. The only solution is a hard reboot.

- [ ] Verify that this happens only if audio is plugged to the back of the LG Ultrafine 5k monitor.
- [ ] Gather last boot logs, and look for bug reports

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
