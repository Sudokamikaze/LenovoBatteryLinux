# LenovoBatteryLinux
Battery Management for Ideapads(tested on Lenovo G580)

## Usage
If you using older ubuntu, please remove this line from installer
```
 cd acpi_call && sed -i 's|acpi/acpi.h|linux/acpi.h|' acpi_call.c && cd ../
```

And then, execute this command
`./install_acpi_call.sh`

After installing acpi_call module you can configure battery charge by executing main script

`./battery_management.sh`
