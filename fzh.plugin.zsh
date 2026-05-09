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
    echo ""
    echo "Zsh plugin to search your history for [search_term] and load the result into the prompt."
    echo "By default, fzh uses exact matching. You can enable fuzzy matching with --mode=fuzzy."
    echo ""
    echo "Usage:"
    echo "------"
    echo "fzh [search_term] [--mode=fuzzy]"
    echo ""
    echo "Example:"
    echo "--------"
    echo "fzh --mode=fuzzy git commit"
    return 0
  fi
  local query=""
  local fzf_flags="--exact"

  # Parse arguments
  for arg in "$@"; do
    if [[ "$arg" == "--mode=fuzzy" ]]; then
      fzf_flags=""
    else
      if [[ -z "$query" ]]; then
        query="$arg"
      else
        query="$query $arg"
      fi
    fi
  done

  # Pass all unique history entries to fzf and use the constructed query
  local selected=$(history -n 1 | grep -v '^fzh' | awk '!x[$0]++' | fzf ${=fzf_flags} --query "$query" +s --tac --no-sort | sed 's/^[ ]*//')

  # Only print to the buffer if a selection was made
  if [ -n "$selected" ]; then
    print -z "$selected"
  fi
}
