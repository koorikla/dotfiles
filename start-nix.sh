# Just for testing, it makes sense to actually install nix on system lvl

docker run -it --rm \
  -v $(pwd):/workdir \
  -v ~/.config/starship.toml:/root/.config/starship.toml:ro \
  -v /var/run/docker.sock:/var/run/docker.sock \
  nixos/nix \
  nix-shell /workdir/shell.nix