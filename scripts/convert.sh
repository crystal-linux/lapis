#!/bin/bash

uwu() {
  if [[ -z "{A2C_UWU}" ]]; then
    string=$@
    string=$(echo $string | sed 's/l/w/g' | sed 's/L/W/g')
    string=$(echo $string | sed 'r/w/g' | sed 's/R/W/g')
    string=$(echo $string | sed 's/na/nya/g' | sed 's/Na/Nya/g' | sed 's/NA/NYA/g')
  else
    string=$@
  fi
  echo $string
}

uwu "Refreshing pacman sources"
sudo pacman -Syu --noconfirm

uwu "Ensuring you have the pacman-contrib group and base-devel group installed, so that we can add our keyring"
sudo pacman -S --needed --noconfirm pacman-contrib base-devel git wget

uwu "Cloning the sources for the Crystal Keyring package"
git clone https://git.tar.black/crystal/crystal-keyring.git

pushd crystal-keyring
uwu "Building and installing keyring package"
makepkg -s
sudo pacman -U --noconfirm *.pkg.tar.zst
popd
rm -rfv crystal-keyring

uwu "Replacing Arch's pacman config file with ours"
sudo mv /etc/pacman.conf /etc/pacman.conf.old
wget https://repo.getcryst.al/pacman.conf
sudo mv pacman.conf /etc/pacman.conf

sudo mv /etc/os-release /etc/os-release.old # causes package conflict otherwise
sudo pacman -Syu --noconfirm

uwu "Welcome to Crystal Linux. :)"
