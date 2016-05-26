#!/bin/bash
echo ===========================================================
echo "1. ArchLinux install(Supported all kernels and zenreiser)"
echo "2. Ubuntu install(Supported all kernels)"
echo ===========================================================
echo -n "You are using Archlinux or ubuntu(1/2)"
read item
case "$item" in
    1) echo ====================================
      echo "1. If u using not zenreiser kernel"
      echo "2. If u using zenreiser kernel"
      echo ====================================
      echo -n "Choose an action: "
      read option
      if [ $option == 1 ]; then sudo pacman -S acpi_call
    elif [ $option == 2 ]; then
      mkdir work_dir && cd work_dir
      git clone https://github.com/Sudokamikaze/ZenReiser4-modules.git
      cd ZenReiser4-modules/acpi_call && makepkg -sri
    else
      echo "Unknown symbol"
    fi
        ;;
    2)echo "Installing for Ubuntu"
      sudo apt-get install dkms git build-essential linux-headers-$(uname -r)
      git clone http://github.com/mkottman/acpi_call.git
      sudo mkdir /usr/src/acpi_call-0.0.1
      sudo cp -rp acpi_call/* /usr/src/acpi_call-0.0.1 && sudo dkms add -m acpi_call -v 0.0.1 && sudo dkms build -m acpi_call -v 0.0.1 && sudo dkms install -m acpi_call -v 0.0.1 && sudo modprobe acpi_call
        ;;
    *) echo "Nothing entered."
        ;;
esac
echo Complete!
