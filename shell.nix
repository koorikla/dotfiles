{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "kube-dev-env";

  buildInputs = with pkgs; [
    kubectl
    helm
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
    bash-completion
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  shellHook = ''
    echo "🚀 Welcome to your Kubernetes Dev Shell!"

    # Alias for kubectl
    alias k=kubectl

    # Bash autocomplete
    if [ -n "$BASH_VERSION" ]; then
      source ${pkgs.bash-completion}/etc/profile.d/bash_completion.sh 2>/dev/null || true
      source <(kubectl completion bash)
      complete -F __start_kubectl k
    fi

    # Zsh setup
    if [ -n "$ZSH_VERSION" ]; then
      # Enable compinit
      autoload -Uz compinit
      compinit

      # Kubectl autocomplete
      source <(kubectl completion zsh)
      compdef __start_kubectl k

      # Starship prompt
      eval "$(starship init zsh)"

      # Zsh plugins
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
  '';
}
