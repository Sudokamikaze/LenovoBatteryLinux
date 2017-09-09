#!/bin/bash

function check_kernel {
case "$(uname -r)" in
  *-xkernel) cd /tmp
  git clone https://github.com/Sudokamikaze/XKernel-modules.git && cd XKernel-modules/
  export lenovo_enabled=true
  ./modules.sh
  ;;
  *-ARCH) sudo pacman -S acpi_call
  ;;
esac

}

function distro {
  case $(head -n1 /etc/issue | cut -f 1 -d ' ') in
    Arch ) check_kernel
    ;;
    Ubuntu | Debian)
    sudo apt-get install dkms git build-essential linux-headers-$(uname -r)
    cd /tmp
    git clone http://github.com/mkottman/acpi_call.git
    cd acpi_call && sed -i 's|acpi/acpi.h|linux/acpi.h|' acpi_call.c && cd ../
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
