; extended program asm starts after the initial 512 byte sector at 0x7e00
org 0x7e00

mov bx, extended_space_string
call print_string
jmp $

extended_space_string:
    db 'Hello world from extended space!', 0x0a, 0

%include "print.asm"

; fill space up to 4 sectors
times 2048 - ($ - $$) db 0
