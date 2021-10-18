; bios loads bootrom at '0x7c00'
org 0x7c00

; set stack location so indexing works?
mov bp, 0x7c00
mov sp, bp

mov bx, some_string
call print_string

jmp $

; uses `bx` as pointer to data to print
print_string:
    mov ah, 0x0e
    mov al, [bx]
    cmp al, 0
    je .end
    int 0x10
    inc bx
    jmp print_string
    .end:
    ret

some_string:
    db 'Hello world!',0

; fill remaining space with zeros
times 510 - ($ - $$) db 0

; add magic bytes
dw 0xaa55
