# NixOS and Home Manager configurations

## To rebuild the system 

```sh
sudo nixos-rebuild switch --flake .
```

## To update user dotfiles

```sh
home-manager switch --flake .
```
