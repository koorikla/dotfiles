eval "$(starship init zsh)"

# Ensure zsh completion system is initialized
autoload -Uz compinit
compinit

# kubectl completion
if [[ $commands[kubectl] ]]; then
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef __start_kubectl k
fi
