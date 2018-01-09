#!/bin/bash

if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

function chargeto() {
if (("$(cat /sys/class/power_supply/BAT1/capacity)" >= "60")); then
  echo "Battery level higher than 60%"
  exit 1
else
    echo "Charging battery. Please wait"
    echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 5' > /proc/acpi/call
    loop=yes
    while [ "$loop" = "yes" ]; do
    sleep 1m
    if (("$(cat /sys/class/power_supply/BAT1/capacity)" >= "60")); then
       echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 4' > /proc/acpi/call
       echo "Done, battery charged to $(cat /sys/class/power_supply/BAT1/capacity)%"
       exit 1
    fi
done
fi
}

function charger() {
case "$1" in
    "60") echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 4' > /proc/acpi/call ;;
    "100") echo '\_SB.PCI0.LPCB.EC0.VPC0.SBMC 5' > /proc/acpi/call ;;
    "recharge") chargeto ;;
esac
}

echo "Current charge level: $(cat /sys/class/power_supply/BAT1/capacity)%"
echo ==================================
echo "1. Enable battery protection mode(Charge level about 55~59%)"
echo "2. Disable battery protection mode(Charge level 100%)"
echo "3. Charge battery to 60% and exit"
echo ==================================
echo -n "Choose an action: "
read menu
case "$menu" in
    1) charger 60 ;;
    2) charger 100 ;;
    3) charger recharge ;;
esac

