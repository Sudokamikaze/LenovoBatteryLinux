#!/bin/bash

if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

function charge_to_60 {
echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 5' > /proc/acpi/call
loop=yes
while [ "$loop" = "yes" ]
do
sleep 1m
if (("$(cat /sys/class/power_supply/BAT1/capacity)" >= "60")); then
  echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 4' > /proc/acpi/call
  echo "Done, battery charged to $(cat /sys/class/power_supply/BAT1/capacity)%"
  exit 1
fi
done
}

echo "Current charge level: $(cat /sys/class/power_supply/BAT1/capacity)%"
echo ==================================
echo "1 Install battery protection mode(Charge level about 55~59%)"
echo "2 Disable battery protection mode(Charge level 100%)"
echo "3 Charge battery to 60% and stop charge"
echo ==================================
echo -n "Choose an action: "
read item
case "$item" in
    1)echo "Charge level set to 60"
      echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 4' > /proc/acpi/call
        ;;
    2)echo "Charge level set to 100"
      echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 5' > /proc/acpi/call
        ;;
    3) 
if (("$(cat /sys/class/power_supply/BAT1/capacity)" >= "60")); then
  echo "Battery level higher then 60%"
  exit 1
else
    echo "Charging battery. Please wait"
    charge_to_60
fi
        ;;
    *) echo "Noting Entered"
        ;;
esac
