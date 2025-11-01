export ZSH="$HOME/.oh-my-zsh"
export HIST_STAMPS="mm/dd/yyyy"
plugins=(kubectl starship git)
source $ZSH/oh-my-zsh.sh

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

# helm completion
if [[ $commands[helm] ]]; then
  source <(helm completion zsh)
fi

# argocd completion
if [[ $commands[argocd] ]]; then
  source <(argocd completion zsh)
fi

# kargo completion
if [[ $commands[kargo] ]]; then
  source <(kargo completion zsh)
fi

if [[ $commands[crossplane] ]]; then
  source <(crossplane completions)
fi

if [[ $commands[kind] ]]; then
  source <(kind completion zsh)
fi