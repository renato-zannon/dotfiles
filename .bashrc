attach_to_tmux() {
  if tmux has-session -t default 2>/dev/null; then
    tmux attach-session -t default
  else
    tmux new-session -s default
  fi
  exit $?
}

if [[ $- == *i* ]]; then
  if [[ -z "${TMUX}" ]]; then
    attach_to_tmux
  fi

  source $HOME/.bashrc.interactive
fi

source $HOME/.bashrc.noninteractive
