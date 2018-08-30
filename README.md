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
2. `IGNORE_BREW_DOCTOR`: ignore warnings and errors reported by `brew doctor`
   and continue script execution.
3. `SYMLINK_USER_DIRS`: whether to remove default directories in `~` and
   replace with symlinks to `/Volumes/Storage/$dir`.
