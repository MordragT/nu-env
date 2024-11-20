<div align=center>

# ❄️ nu-env 💻

[![NixOS](https://img.shields.io/badge/Flakes-Nix-informational.svg?logo=nixos&style=for-the-badge)](https://nixos.org) ![License](https://img.shields.io/github/license/mordragt/nu-env?style=for-the-badge) 


Alternative environment for **Nix** using **NuShell** instead of Bash

</div>

## About

Given that the [nuenv](https://github.com/DeterminateSystems/nuenv/tree/main) repository of DeterminateSystems was archived, this is a new approach to bring the power of nushell to nix.
Apart from basic functionality to create derivations this project also implements support for NuShell packages (see `nuenv/build-nu-package` and `nupkgs/all-to`).


## Usage

In Progress...

Take a look at the make-derivation or build-nu-package files inside the `nuenv` directory. You can use nix-flakes to register the overlay

## Reference

1. [wiki/Flakes](https://nixos.wiki/wiki/Flakes)
2. [DeterminateSystems nuenv]((https://github.com/DeterminateSystems/nuenv/tree/main) )