# Check if fzf is installed
if (( ! $+commands[fzf] )); then
  print "fzh: fzf not found. Please install fzf (https://github.com/junegunn/fzf) to use this plugin." >&2
  return 1
fi

# Check if HISTFILE is set
if [[ -z "$HISTFILE" ]]; then
  print "fzh: HISTFILE is not set. Please set HISTFILE to use this plugin." >&2
  return 1
fi

# Fuzzy search your history with fzf
fzh() {
  if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "╔═╗╔═╗╔═╗  ╦ ╦ ╦ ╔═╗╔╦╗╔═╗╦═╗╦ ╦"
    echo "╠╣ ╔═╝╠╣   ╠═╣ ║ ╚═╗ ║ ║ ║╠╦╝╚╦╝"
    echo "╚  ╚═╝╚    ╩ ╩ ╩ ╚═╝ ╩ ╚═╝╩╚═ ╩ "
    echo "--------------------------------"
    echo "Zsh plugin to fuzzy search your history for [search_term] and load the result into the prompt."
    echo ""
    echo "Usage:"
    echo "------"
    echo "fzh [search_term]"
    return 0
  fi
  # Filter history with grep first to ensure strict matching & pass those matches to fzf for interactive selection
  local selected=$(history -n 1 | grep -v '^fzh' | grep -i "$*" | awk '!x[$0]++' | fzf +s --tac --no-sort | sed 's/^[ ]*//')

  # Only print to the buffer if a selection was made
  if [ -n "$selected" ]; then
    print -z "$selected"
  fi
}
