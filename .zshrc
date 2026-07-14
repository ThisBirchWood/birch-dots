# INSTANT PROMPT
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

# ENVIRONMENT
export EDITOR=nvim
export VISUAL=nvim
export QT_QPA_PLATFORMTHEME=qt6ct   # Qt6 apps

# ALIASES
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# COMPLETION (before plugins that hook into it)
autoload -Uz compinit && compinit

# PLUGINS
source ~/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # keep LAST

# THEME CONFIG (after theme is loaded)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
