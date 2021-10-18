print_string:
    mov ah, 0x0e
    mov al, [bx]
    cmp al, 0
    je .end
    cmp al, 0x0a
    je .newline
    int 0x10
    inc bx
    jmp print_string
    .newline:
    ; print carriage return
    mov al, 0x0d
    int 0x10
    ; print line feed
    mov al, 0x0a
    int 0x10
    inc bx
    jmp print_string
    .end:
    ret
