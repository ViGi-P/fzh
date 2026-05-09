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
  # Pass all unique history entries to fzf and use command-line arguments as the initial query
  local selected=$(history -n 1 | grep -v '^fzh' | awk '!x[$0]++' | fzf --query "$*" +s --tac --no-sort | sed 's/^[ ]*//')

  # Only print to the buffer if a selection was made
  if [ -n "$selected" ]; then
    print -z "$selected"
  fi
}
