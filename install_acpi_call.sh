#!/bin/bash

function check_kernel {
kernel=$(uname -r)
case "$kernel" in
  *-xkernel) cd /tmp
  git clone https://github.com/Sudokamikaze/XKernel-modules.git
  cd XKernel-modules/acpi_call && makepkg -sri
  ;;
  *-ARCH) sudo pacman -S acpi_call
  ;;
esac

}

function distro {
  eval $(grep ID= /etc/os-release)
  case "$ID" in
    arch) check_kernel
    ;;
    ubuntu|debian)
    sudo apt-get install dkms git build-essential linux-headers-$(uname -r)
    cd /tmp
    git clone http://github.com/mkottman/acpi_call.git
    sudo mkdir /usr/src/acpi_call-0.0.1
    sudo cp -rp acpi_call/* /usr/src/acpi_call-0.0.1
    sudo dkms add -m acpi_call -v 0.0.1
    sudo dkms build -m acpi_call -v 0.0.1
    sudo dkms install -m acpi_call -v 0.0.1
    sudo modprobe acpi_call
    ;;
  esac
}

echo -n "Do u want to install? [Y/N]: "
read item
case "$item" in
  y|Y) distro
  ;;
  n|N) exit 1
  ;;
esac
