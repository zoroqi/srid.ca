---
date: 2020-11-04T14:31
tags: [nix]
---

# Creating a new Haskell project using Nix

With [[58bc09d0]] support too.

```bash
nix-shell -p cabal-install -p ghc --run 'cabal init'
echo "..." > LICENSE
git init && git add . && git commit -m "Initial commit"

vim *.cabal  # and remove version constraint on `base`
niv init
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

```