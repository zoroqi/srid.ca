---
date: 2020-11-04T14:31
tags: [nix]
---

# Creating a new Haskell project using Nix

With [[58bc09d0]] support too.

```bash
PKGNAME=foo
mkdir $PKGNAME && cd $PKGNAME
nix-shell -p cabal-install -p ghc --run "cabal init -m -l BSD3 -p $PKGNAME"
git init && git add . && git commit -m "Initial commit"

vim ${PKGNAME}.cabal  # and remove version constraint on `base`
nix-shell -p niv --run 'niv init'
cat << EOF > default.nix
let 
  srcs = import nix/sources.nix {};
  pkgs = import srcs.nixpkgs { };
in 
  pkgs.haskellPackages.developPackage {
    root = ./.;
    modifier = drv:
      pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages;
        [ cabal-install
          ghcid
        ]);
  }
EOF

nix-build
nix-shell --run 'ghcid -T :main'
```

Copy [.vscode template](https://github.com/srid/reflex-stone/tree/master/.vscode) to `./.vscode` (note: settings.json should point to default.nix instead of shell.nix) and open this project in VSCode.