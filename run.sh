#!/bin/sh
rm wolf.rom wolf.lst 2> /dev/null
~/jzintv/bin/as1600 -o wolf.rom -l wolf.lst main.asm 2> /dev/null

if [ $? -eq 0 ]; then
    ~/jzintv/bin/jzintv wolf.rom -z3 -v1
else
    cat wolf.lst | grep "ERROR\|WARNING"
fi
