#!/bin/bash
echo If you do not run this script as Root it will not work
echo -n "Install the battery charge for 50% or 100%?(1/2)"
read item
case "$item" in
    1)echo "Installing battery charge 50%"
      echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 4' > /proc/acpi/call
        ;;
    2)echo "Installing battery charge 100%"
      echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 5' > /proc/acpi/call
        ;;
    *) echo "Ничего не ввели. Ожидание ввода"
        ;;
esac
