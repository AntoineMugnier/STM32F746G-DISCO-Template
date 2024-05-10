# Template project for STM32F746G-DK board

## Prerequisites
- gcc-arm-none-eabi toolchain: For compiling the sources.
- CMake: For creating the build systems of Makefiles.
- OpenOCD: for flashing the binary to the MCU.
- tio: for serial communication between host and MCU.

Tested development environment: Ubuntu 22.0.4

## Useful commands
Enter all those commands from project root.
### Configure
```
mkdir build
cmake  -B build/ 
```
### Build
```
cmake  --build build/ --target F746.elf
```

### Flash
```
openocd -f board/stm32f746g-disco.cfg -c "program build/F746.elf verify reset exit"
```

### Serial
If you have only one serial bridge connected, then only one id should appear in the `by-id` directory.
```
tio -b 115200 /dev/serial/by-id/<probe-id>
```
