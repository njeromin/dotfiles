# exports
export ZSH_CONFIG="${HOME}/.config/zshconfig"
export MACHINE_KERNEL=$(echo $(uname -s) | sed 's/.*/\L&/')
export MACHINE_ARCH=$(uname -m)

# source plugins
source "${ZSH_CONFIG}/plugins.zsh"

# histfile
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=${HISTSIZE}
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# editor
export EDITOR="nvim"

# aliases
alias ls="exa --icons"
alias la="ls -a"
alias ll="ls --long --accessed --header --git"

# automatically install zinit
if [[ ! -d "/${HOME}/.local/share/zinit/zinit.git" ]]; then
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  mkdir -p "$(dirname ${ZINIT_HOME})"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
  if [[ -d "/${HOME}/.zinit/bin" ]]; then
    rm -rf "/${HOME}/.zinit/bin"
  fi
  source "${ZINIT_HOME}/zinit.zsh"
fi

#  automatically install asdf
if [[ ! -d "/${HOME}/.asdf" ]]; then
   git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
   autoload -Uz compinit && compinit
   . ${HOME}/.asdf/asdf.sh
   asdf update
fi

# asdf install helper function
function asdfInstall {
   # return if command alreay exists
   if (( $+commands[$1] )); then
      return
   fi
   
   asdf plugin add $@ | sed '/already added/d'
   asdf install $1 latest | sed '/is already installed/d'
   asdf global $1 latest
}

# auto installers
asdfInstall "chezmoi" "https://github.com/joke/asdf-chezmoi.git"
asdfInstall "fzf" "https://github.com/kompiro/asdf-fzf.git"
asdfInstall "ripgrep"
asdfInstall "exa"
asdfInstall "neovim"

if $INSTALL_TOOL_TASK; then; asdfInstall "task" "https://github.com/particledecay/asdf-task.git"; fi
if $INSTALL_TOOL_AWS_CLI; then; asdfInstall "awscli"; fi

if $INSTALL_LANG_RUST; then; asdfInstall "rust"; fi
if $INSTALL_LANG_GOLANG; then; asdfInstall "golang"; fi
if $INSTALL_LANG_PYTHON; then; asdfInstall "python"; fi
if $INSTALL_LANG_NODE; then; asdfInstall "nodejs" "https://github.com/asdf-vm/asdf-nodejs.git"; fi
if $INSTALL_LANG_BUN; then; asdfInstall "bun"; fi

