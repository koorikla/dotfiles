FROM nixos/nix

COPY shell.nix /shell.nix
RUN nix-shell /shell.nix --run "echo 'Nix shell is ready!'"