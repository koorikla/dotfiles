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
    oh-my-zsh
  ];

  shellHook = ''
    cat > "/root/.zshrc" << 'EOF'      
        eval "$(starship init zsh)"

        # Ensure zsh completion system is initialized
        autoload -Uz compinit
        compinit
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt '%SScrolling active: %p%s'

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

        ## hacky way till i find how to ask this from a variable
        export ZSH="/nix/store/2691wlffz70nl98596s96ka6llh2z1ja-oh-my-zsh-2025-04-29/share/oh-my-zsh/"
  #      ZSH_THEME="starship"
        plugins=(git kubectl)
        source $ZSH/oh-my-zsh.sh  
EOF

    exec ${pkgs.zsh}/bin/zsh
  '';
}