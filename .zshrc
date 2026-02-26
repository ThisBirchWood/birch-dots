# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
[[ -o interactive ]] && neofetch

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Environment for apps
export QT_QPA_PLATFORMTHEME=qt5ct  # for Qt5
export QT_QPA_PLATFORMTHEME=qt6ct  # for Qt6

alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias modelio="GTK_THEME=Adwaita GDK_BACKEND=x11 /opt/modelio/modelio"

source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Path updates
export PATH=/home/dylan/.local/bin:$PATH
export PATH=/home/dylan/.opencode/bin:$PATH

# Env Variables
export EDITOR=nvim
export VISUAL=nvim
