# LenovoBatteryLinux
Battery Management on Lenovo G580 (20150)

The script for controlling battery charge


## Usage
Firstfully install acpi_call module perform this command :

If you building acpi_call on ubuntu with kernel 3.17 and higher run this command on acpi_call sources

` sed -i 's|acpi/acpi.h|linux/acpi.h|' acpi_call.c`

`./install_acpi_call.sh`


After installing acpi_call module u may configure battery charge by this command :

`./battery_management.sh`
