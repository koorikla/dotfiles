# Just for testing, it makes sense to actually install nix on system lvl

# 1. create gitconfig (if using ssh auth)

# git config --global user.email "yourname@gmail.com"
# git config --global user.name "yourname"


# docker run -it --rm \
#   -v $(pwd):/workdir \
#   -v ~/.config/starship.toml:/root/.config/starship.toml:ro \
#   -v /var/run/docker.sock:/var/run/docker.sock \
#   -v $HOME/.gitconfig:/root/.gitconfig:ro \
#   -v $SSH_AUTH_SOCK:/ssh-agent \
#   -e SSH_AUTH_SOCK=/ssh-agent \
#   -w /workdir \
#   nixos/nix \
#   nix-shell


docker run -it --rm \
  -v $(pwd):/workdir \
  -v ~/.config/starship.toml:/root/.config/starship.toml:ro \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME/.gitconfig:/root/.gitconfig:ro \
  -v $SSH_AUTH_SOCK:/ssh-agent \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -w /workdir \
  test \
  nix-shell
