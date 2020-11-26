---
slug: xmonad-conf-ide
date: 2020-11-26
tags: [nixos, mtsa]
---

:::{.ui .message}
The second step of the [[Make Tech Simple Again]] project was to switch from [[i3]] to [[XMonad]]. Why? Because this opens me up to write complex workflows in Haskell with its type-safety benefits.
:::

[Over at FP Zulip](https://funprog.srid.ca/haskell/i3-configuration-in-haskell.html#217619324), when I floated the idea of writing Haskell DSL for i3 configuration, someone suggested to just use [[XMonad]] instead. XMonad is a window manager where your configuration file is just Haskell code. 

Because it is all Haskell, we can use [`haskell-language-server`](https://github.com/haskell/haskell-language-server) to provide full IDE support -- autocomplete, hover popups, documentation links, etc. -- for editing window manager configuration.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Editing <a href="https://twitter.com/xmonad?ref_src=twsrc%5Etfw">@xmonad</a> &quot;configuration&quot; with full IDE support in <a href="https://twitter.com/code?ref_src=twsrc%5Etfw">@code</a> thanks to <a href="https://twitter.com/nixos_org?ref_src=twsrc%5Etfw">@nixos_org</a>, nix and haskell-language-server.<br><br>Can your window manager do this?<a href="https://t.co/xOtcnmzq3b">https://t.co/xOtcnmzq3b</a> <a href="https://t.co/bc2hrMfQYn">pic.twitter.com/bc2hrMfQYn</a></p>&mdash; Devil May Care (@sridca) <a href="https://twitter.com/sridca/status/1331701938556166150?ref_src=twsrc%5Etfw">November 25, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Here's how you do it:

1. Create a cabal project (see [[Creating a new Haskell project with IDE support using Nix]])
2. Add your XMonad configuration to the `Main.hs`
3. Add `xmonad`, `xmonad-contrib` and other dependencies to the cabal file
4. Adjust your NixOS XMonad configuration to use this project

Step 4 basically involves using the `Main.hs` as the config file, as well as copying over the Cabal dependencies. So, in your `configuration.nix` you would do something like:

```nix
services.xserver.windowManager.xmonad = {
  enable = true;
  extraPackages = haskellPackages: [
    haskellPackages.xmonad-contrib
    haskellPackages.containers
  ];
  enableContribAndExtras = true;
  config = pkgs.lib.readFile ./xmonad-config/Main.hs;
};
```

Your Cabal project lives at `./xmonad-config` ... and, if you followed the instructions in [[Creating a new Haskell project with IDE support using Nix]] to setup IDE configuration, you can simply launch [[VSCode]] using `code ./xmonad-config` to start editing your configuration.

## Example

- [My config: nixos/xmonad-srid](https://github.com/srid/nix-config/tree/64e3d5de3383172e95b504dd8e410e62302f3632/nixos/xmonad-srid)