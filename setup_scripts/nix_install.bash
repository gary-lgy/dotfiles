#!/usr/bin/env bash

# nix packages:
## for Arch: nox (asdf)
## for Debian/Ubuntu: nox fzf diff-so-fancy direnv bat tldr albert
# Copy and paste before running the script
nix_packages=(nox)

nix_install() {
  # Do nothing if the package is already installed
  command -v "$1" &>/dev/null && echo "$1 is present." && return

  echo "$1 might not be present. Attempt to install with nix..."

  nix-env -i "$1"
}

# Install nix
if command -v nix &>/dev/null; then
  echo "nix is present."
else
  echo "nix is not present. Installing from installation script..."
  sudo sysctl kernel.unprivileged_userns_clone=1 &&
  curl https://nixos.org/nix/install | sh &&
  echo 'Remember to setup cron jobs to collect garbage for nix.' &&
  source ~/.nix-profile/etc/profile.d/nix.sh ||
  (echo >&2 "Could not install nix." && exit 1)
fi

echo "Installing nix packages..."
for pac in "${nix_packages[@]}"; do
  nix_install "$pac"
done

echo "Done"
