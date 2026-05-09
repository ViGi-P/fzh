<p align="center">
  <img src="./fzh.png" height="64" alt="fzh logo">
</p>

<p align="center">
  A Zsh plugin to fuzzy search your history and load the result into the prompt using `fzf`.
</p>

---

## Prerequisites

- **[fzf](https://github.com/junegunn/fzf)** must be installed.
- **Windows users**: If you use **WSL**, you are 100% safe. Other Windows Zsh users must have the standard Unix utilities (`awk`, `grep`, `sed`) installed along with `fzf`.

## Usage

```bash
fzh --help # Display help
fzh [search_term] [--mode=fuzzy]
```

### Example:
```bash
fzh git commit
```

## Installation

### Method A: Manual Loading

1. Clone this repo.
2. Add this to your `.zshrc`:
   ```bash
   source /path/to/fzh/fzh.plugin.zsh
   ```

### Method B: Oh My Zsh

1. Clone this repo to your oh-my-zsh custom plugins directory.
2. Open your `.zshrc` and add `fzh` to your plugins list:
   ```bash
   plugins=(git docker fzh)
   ```


### Method C: GitHub (Antigen, Zplug)

- **Antigen**: `antigen bundle ViGi-P/fzh`
- **Zplug**: `zplug "ViGi-P/fzh", as:plugin`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
