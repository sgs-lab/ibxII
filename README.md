# IBX || Software

This is the Software for the Information Barrier Experimental ||. IBX || is an information barrier setup for nuclear warhead verification with an Apple IIe ([Details](http://www.vintageverification.org)). An early version was presented at [34C3](https://media.ccc.de/v/34c3-8994-vintage_computing_for_trusted_radiation_measurements_and_a_world_free_of_nuclear_weapons).

## Assemble

The software is written in 6502 assembler, and can be assembled using the [ca65 assembler](http://www.cc65.org).
To create disk images, it is also necessary to have [dos33fsprogs](https://github.com/deater/dos33fsprogs) (Tools do manipulate DOS 3.3 disk images) installed in the path. To create .nib files, also [dsk2nib](https://github.com/slotek/dsk2nib) needs to be in the path. We used a [SD Disk][ Plus](https://quick09.tistory.com/1362) for development, debugging and longer measurements, and the device can only write to .nib files.

After installing prerequisites, the included makefile allows for compilation of three different versions:
* Plain Version. Uses screen for user interaction. Build with `make screenib`
* Demo Version. Shows gamma spectrum while measuring. Build with `make withspectrum`
* Measurement Version. Can carry out multiple measurements automatically. Build with `make measure`

## Running the disks

The disks are programmed to read and write memory positions associated to the extension cards. An emulator will most likely not work (or not give expected results).
