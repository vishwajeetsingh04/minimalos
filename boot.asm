[BITS 16]           ; We need 16-bit code for real mode
[ORG 0x7C00]        ; BIOS loads bootloader at this address

start:
    cli             ; Disable interrupts
    xor ax, ax      ; Clear AX register
    mov ds, ax      ; Set DS to 0
    mov es, ax      ; Set ES to 0
    mov ss, ax      ; Set SS to 0
    mov sp, 0x7C00  ; Set stack pointer
    sti             ; Enable interrupts

    mov si, welcome_msg
    call print_string

    ; Load kernel from disk
    mov ah, 0x02    ; BIOS read sector function
    mov al, 1       ; Number of sectors to read
    mov ch, 0       ; Cylinder number
    mov cl, 2       ; Sector number (1 is bootloader)
    mov dh, 0       ; Head number
    mov dl, 0x80    ; Drive number (first hard drive)
    mov bx, 0x1000  ; Load kernel to this address
    int 0x13        ; Call BIOS interrupt

    jmp 0x1000      ; Jump to kernel

print_string:
    lodsb           ; Load byte from SI into AL
    or al, al       ; Check if AL is 0 (end of string)
    jz done         ; If zero, we're done
    mov ah, 0x0E    ; BIOS teletype function
    int 0x10        ; Call BIOS interrupt
    jmp print_string
done:
    ret

welcome_msg db 'MinimalOS Bootloader...', 13, 10, 0

times 510-($-$$) db 0   ; Pad with zeros
dw 0xAA55              ; Boot signature 