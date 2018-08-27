# dotfiles
Contains configuration files for utilities and script for automated
installation of said utilities.

## Usage
1. Clone the repo, then make `setup.sh` executable:
   ```
   chmod +x ./setup.sh
   ```
2. Execute `setup.sh`.

## Setup options
`setup.sh` supports the following options:

1. `BREW_INSTALL_EXTRAS`: install extra Homebrew packages and casks from the
   extras Brewfile, `extras.Brewfile`.
2. `IGNORE_BREW_DOCTOR`: Ignore warnings and errors reported by `brew doctor`
   and continue script execution.
