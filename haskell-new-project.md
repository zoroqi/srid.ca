---
date: 2020-11-04T14:31
tags: [nix]
---

# Creating a new Haskell project using Nix

With [[58bc09d0]] support too.

First, install [nix-thunk](https://github.com/obsidiansystems/nix-thunk) (alternatively, you may use niv or flakes).

```bash
# Initialize project layout using cabal
PKGNAME=foo
mkdir $PKGNAME && cd $PKGNAME
nix-shell -p cabal-install -p ghc --run "cabal init -m -l BSD3 -p $PKGNAME"

# Add to git
git init && git add . && git commit -m "Initial commit"

# Remove, or update, version constraint on base to match compiler
vim ${PKGNAME}.cabal  # and remove version constraint on `base`

# Pin nixpkgs
# You might want to pass --rev, using the value from status.nixos.org
nix-thunk create https://github.com/nixos/nixpkgs.git dep/nixpkgs

# Write template default.nix
cat << EOF > default.nix
let 
  pkgs = import ./dep/nixpkgs { };
in 
  pkgs.haskellPackages.developPackage {
    root = ./.;
    modifier = drv:
      pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages;
        [ cabal-install
          ghcid
          haskell-language-server
        ]);
  }
EOF

# Test your changes
nix-build
nix-shell --run 'ghcid -T :main'

# Create .gitignore and commit
echo -e "dist-newstyle\nresult" > .gitignore
git add . && git commit -m "Nixify"
```

Copy [.vscode template](https://github.com/srid/reflex-stone/tree/master/.vscode) to `./.vscode` (note: settings.json should point to default.nix instead of shell.nix) and open this project in VSCode.