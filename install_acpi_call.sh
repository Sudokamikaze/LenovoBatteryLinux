#!/bin/bash
echo 1 ArchLinux install(WARNING, SUPPORTED ONLY LINUX-ZEN KERNEL)
echo 2 Ubuntu install(Supported all kernels)
echo -n "You are using Archlinux or ubuntu(1/2)"
read item
case "$item" in
    1)echo "Installing for Arclinux"
      mkdir work_dir && cd work_dir && git clone https://github.com/Pulshen/ZenReiser4-modules.git && cd ZenReiser4-modules/acpi_call && makepkg -sri
        ;;
    2)echo "installing for Ubuntu"
      sudo apt-get install dkms git build-essential gedit linux-headers-$(uname -r) && git clone http://github.com/mkottman/acpi_call.git && sudo mkdir /usr/src/acpi_call-0.0.1 && sudo cp -rp acpi_call/* /usr/src/acpi_call-0.0.1 && sudo dkms add -m acpi_call -v 0.0.1 && sudo dkms build -m acpi_call -v 0.0.1 && sudo dkms install -m acpi_call -v 0.0.1 && sudo modprobe acpi_call
        ;;
    *) echo "Ничего не ввели. Ожидание ввода"
        ;;
esac
echo Complete!
