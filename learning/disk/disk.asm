; bios loads bootrom at '0x7c00'
[org 0x7c00]

; store bootrom disk id
mov [bootrom_disk], dl

; set stack location so indexing works?
mov bp, 0x7c00
mov sp, bp

; jump to start
jmp start

; location of extended program space
program_space equ 0x7e00

; loads sector 2 from the disk containing the bootrom to 0x7e00
read_disk:
    ; clear ax and ds
    mov ax, 0x00
    mov ds, ax
    mov es, ax

    ; set up interrupt
    mov ah, 0x02
    mov al, 4              ; number of sectors
    mov ch, 0x00           ; cylinder
    mov cl, 0x02           ; sector to start at
    mov dh, 0x00           ; head number
    mov dl, [bootrom_disk] ; drive number
    mov bx, program_space  ; dst
    int 0x13
    ; print error if failed to read disk
    jc .failed
    jmp .end
    .failed:
    mov bx, disk_read_error_str
    call print_string
    jmp $
    .end:
    ret

start:
    mov bx, bootrom_string
    call print_string
    call read_disk
    jmp program_space

; store disk number for bootrom in address
bootrom_disk:
    db 0

bootrom_string:
    db 'Hello world from the bootrom sector!', 0x0a, 0

disk_read_error_str:
    db 'Disk read failed!', 0x0a, 0

%include "print.asm"

; fill remaining space with zeros
times 510 - ($ - $$) db 0

; add magic bytes
dw 0xaa55
