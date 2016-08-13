#!/bin/bash
# Pulshen battery management
# root checker
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi
echo ==================================
echo "1 Install battery protection mode(Charge level about 55~59%)"
echo "2 Disable battery protection mode(Charge level 100%)"
echo ==================================
echo -n "Choose an action: "
read item
case "$item" in
    1)echo "Installing battery protection mode"
      echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 4' > /proc/acpi/call
        ;;
    2)echo "Disabling battery protection mode"
      echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 5' > /proc/acpi/call
        ;;
    *) echo "Noting Entered"
        ;;
esac
