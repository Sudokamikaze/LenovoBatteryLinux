#!/bin/bash
sudo apt-get install dkms git build-essential gedit
sudo apt-get install linux-headers-$(uname -r)
git clone http://github.com/mkottman/acpi_call.git
mkdir /usr/src/acpi_call-0.0.1
cp -rp acpi_call/* /usr/src/acpi_call-0.0.1
cp dkms.conf /usr/src/acpi_call-0.0.1
sudo dkms add -m acpi_call -v 0.0.1
sudo dkms build -m acpi_call -v 0.0.1
sudo dkms install -m acpi_call -v 0.0.1
sudo modprobe acpi_call
echo Complete!