#!/bin/python

import sys,getpass,time

class BATC:

    __60per = "\_SB.PCI0.LPCB.EC0.VPC0.SBMC 4"
    __100per = "\_SB.PCI0.LPCB.EC0.VPC0.SBMC 5"
    __batpath = '/sys/class/power_supply/BAT1/capacity'
    __acpipath = '/proc/acpi/call'

    def __init__(self):
        print('Current battery charge level is: ', self.printbatlevel())
        choised = input(int(
            '1. Set battery charge limit to 100%', '\n',
            '2. Set battery charge limit to 60%', '\n',
            '3. Charge battery to 60% and exit'
        ))
        self.setlevel(choised)

    def setlevel(self,choised):
        f = open(self.__acpipath, 'w')
        if choised == 1:
            f.write(self.__100per)
        elif choised == 2:
            f.write(self.__60per)
        elif choised == 3:
            self.charger()
        f.close()

    def printbatlevel(self):
        tmpbatlevel = open(self.__batpath, 'r')
        return int(tmpbatlevel)
        tmpbatlevel.close()

    def charger(self):
        if self.printbatlevel() >= '60':
            print('Current battery level higher than 60')
            sys.exit(1)
        else:
            print('Charging...')
            self.setlevel(choised=1)
            loop = True
            while loop == True:
                time.sleep(60)
                if self.printbatlevel() >= '60':
                    print('Done!')
                    self.setlevel(choised=2)
                    sys.exit(0)

if getpass.getuser() != 'root':
    print('Error: this script can only be executed by root')
    sys.exit(1)
else:
    calltheclass = BATC()