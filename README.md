# LenovoBatteryLinux
Battery Management for Ideapads(tested on Lenovo G580)

## Usage
If you building acpi_call on ubuntu with kernel 3.17 and higher run this command on acpi_call sources

` sed -i 's|acpi/acpi.h|linux/acpi.h|' acpi_call.c`

And then execute this command
`./install_acpi_call.sh`

After installing acpi_call module u may configure battery charge by this command :

`./battery_management.sh`
