#!/bin/sh
rm wolf.rom wolf.lst
~/jzintv/bin/as1600 -o wolf.rom -l wolf.lst main.asm
~/jzintv/bin/jzintv wolf.rom -z4 -v1
