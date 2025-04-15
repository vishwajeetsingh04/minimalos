# MinimalOS

A minimal operating system written in C++ that demonstrates basic OS concepts.

## Features

- VGA text mode display (80x25)
- Basic command-line interface
- Keyboard input handling
- System control commands (reboot, halt)
- Simple command processing

## Commands

- `clear` - Clear the screen
- `help` - Show available commands
- `echo` - Echo back the input text
- `reboot` - Restart the system
- `halt` - Stop the system

## Building

This project requires:
- A C++ compiler
- NASM (for assembly files)
- QEMU (for testing)

## Running

1. Build the project
2. Run in QEMU:
```bash
qemu-system-i386 -kernel kernel.bin
```

## Project Structure

- `kernel.cpp` - Main kernel code
- `boot.asm` - Bootloader code
- `linker.ld` - Linker script

## License

This project is open source and available under the MIT License. 