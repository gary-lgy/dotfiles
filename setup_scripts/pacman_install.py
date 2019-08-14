#!/usr/bin/env python3

"""Install packages listed in packages.yaml."""

import os
import shutil
import signal
import sys
from subprocess import DEVNULL, CalledProcessError, call, check_call, check_output, run

import yaml

COLORS = {
    'normal': '\033[0m',
    'red': '\033[1;31m',
    'green': '\033[1;32m',
    'yellow': '\033[1;33m',
    'blue': '\033[1;34m'
}


def error(message):
    """Print an error message."""
    print(COLORS['red'] + message + COLORS['normal'])


def warning(message):
    """Print a warning."""
    print(COLORS['yellow'] + message + COLORS['normal'])


def info(message):
    """Print information."""
    print(COLORS['blue'] + message + COLORS['normal'])


def success(message):
    """Print a success message."""
    print(COLORS['green'] + message + COLORS['normal'])


def sigint_handler(*_args):
    """Handle SIGINT."""
    error('Cancelled')
    sys.exit(130)


class Pacman:
    """Class to handle package installation with pacman."""

    def __init__(self):
        self.need_system_upgrade = True

    def system_upgrade(self):
        """Perform system upgrade if needed."""
        if self.need_system_upgrade:
            warning('Performing system upgrade.')
            try:
                check_call(['sudo', 'pacman', '-Syu'])
                self.need_system_upgrade = False
            except CalledProcessError:
                error('System upgrade failed.')
                raise

    def install_pikaur(self):
        """Install pikaur as AUR helper."""
        info('Checking if pikaur is installed.')
        if shutil.which('pikaur'):
            success('pikaur is installed.')
            return

        warning('pikaur is not installed. Installing from AUR.')
        try:
            self.system_upgrade()
            pikaur_dir = os.path.expanduser('~/src/pikaur')
            check_call(
                ['git', 'clone', 'https://aur.archlinux.org/pikaur.git', pikaur_dir])
            os.chdir(pikaur_dir)
            check_call(['makepkg', '-fsri'])
            shutil.rmtree(pikaur_dir)
        except (CalledProcessError, OSError):
            error(f'Could not install pikaur. Source in {pikaur_dir}')
            raise

    def check_installed(self, package):
        """
        Check if a package is installed.
        Also make sure its install reaons is 'explicitly installed'.
        Return True if it is installed, and False otherwise.
        """
        process = run(['pacman', '-Qi', package],
                      capture_output=True, text=True)
        if process.returncode != 0:
            warning(f'{package} is not installed.')
            return False

        success(f'{package} is installed.')
        if 'Installed as a dependency for another package' in process.stdout:
            info(f'Changing install reason of {package} to explicit')
            call(['sudo', 'pacman', '-D', '--asexplicit', package])
        return True

    def install_package(self, package):
        """Install a given package."""
        if self.check_installed(package):
            return

        try:
            self.system_upgrade()
            if call(['pacman', '-Si', package], stdout=DEVNULL, stderr=DEVNULL) == 0:
                info(f'Installing {package} from official repo.')
                check_call(['sudo', 'pacman', '-S', package])
            else:
                info(f'(Installing {package} from AUR.')
                check_call(['pikaur', '-S', package])
        except CalledProcessError:
            error(f'Cound not install {package}.')
            raise

    def install_group(self, group):
        """Install a package group."""
        try:
            packages = check_output(
                ['pacman', '-Sgq', group], text=True)
        except CalledProcessError:
            error(f'{group} is not a package group')
            raise

        warning(f'Installing {group} as a package group.')
        for package in packages.rstrip().split('\n'):
            self.install_package(package)


def main():
    """Entry point."""
    packages = yaml.safe_load(open('packages.yaml'))['packages']
    pacman = Pacman()
    optional = []
    for package in packages:
        name = package['name']
        if package.get('optional'):
            optional.append(name)
        elif package.get('group'):
            pacman.install_group(name)
        else:
            pacman.install_package(name)

    print()
    for package in optional:
        warning(f'You may also want to install {package}')


if __name__ == '__main__':
    # Handle SIGINT
    signal.signal(signal.SIGINT, sigint_handler)

    main()
