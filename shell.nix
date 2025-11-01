{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "kube-dev-env-zsh";

  buildInputs = with pkgs; [
    ncurses
    kubectl
    kubectl-neat
    kubernetes-helm
    git
    k9s
    docker
    yq
    curl
    awscli2
    jq
    argocd
    kargo
    crossplane
    starship
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  ZDOTDIR = "$TMPDIR/zdotdir";

  shellHook = ''
    export ZDOTDIR="$TMPDIR/zdotdir"
    mkdir -p "$ZDOTDIR"

    cat > "$ZDOTDIR/.zshrc" << 'EOF'      
        eval "$(starship init zsh)"

        # Ensure zsh completion system is initialized
        autoload -Uz compinit
        compinit
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt '%SScrolling active: %p%s'

        # kubectl completion
        if [[ $commands[kubectl] ]]; then
        source <(kubectl completion zsh)
        alias k=kubectl
        compdef __start_kubectl k
        fi

        # argocd completion
        if [[ $commands[argocd] ]]; then
        source <(argocd completion zsh)
        fi

        # kargo completion
        if [[ $commands[kargo] ]]; then
        source <(kargo completion zsh)
        fi

        # helm completion
        if [[ $commands[helm] ]]; then
        source <(helm completion zsh)
        fi      
EOF

    exec ${pkgs.zsh}/bin/zsh
  '';
}