# Just for testing, it makes sense to actually install nix on system lvl

docker run -it --rm \
  -v $(pwd):/workdir \
  -v ~/.config/starship.toml:/root/.config/starship.toml:ro \
  -w /workdir \
  nixos/nix \
  nix-shell



docker run -it --rm \
  -v $(pwd):/workdir \
  -v ~/.config/starship.toml:/root/.config/starship.toml:ro \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $SSH_AUTH_SOCK:/ssh-agent \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -w /workdir \
  nixos/nix \
  nix-shell
