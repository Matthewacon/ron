; load bootrom at '0x7c00'
org 0x7c00
;org 0x0
; work in 16-bit mode
bits 16

jmp _run

_alpha:
    ; `bl` is the character to be written
    ; write 'X' to screen and jump infinitely
    mov bl, '0'
alpha:
    mov ah, 0x0e
    mov al, bl
    int 0x10
    mov cl, bl
    inc bl
    cmp cl, 'z'
    jne alpha
    jmp run

_run:
    ; print alphabet
    jmp _alpha
run:
    ; write '\r\n' when done
    mov ah, 0x0e
    mov al, 0x0d
    int 0x10
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
run_check:
    ; read keyboard input status
    mov ah, 0x1
    mov al, 0
    int 0x16
    cmp al, 0x1
    jne run_print
    jmp run_check
run_print:
    ; get entered character
    mov ah, 0
    int 0x16
    ; if carriage return entered, print carriage return and line feed
    cmp al, 0x0d
    je run_print_newline
    ; if backspace entered, move cursor back
    cmp al, 0x08
    je run_decr_cursor
    jmp run_print_cont
run_print_newline:
    ; print carriage return
    mov ah, 0x0e
    mov al, 0x0d
    int 0x10
    ; print line feed
    mov al, 0x0a
    int 0x10
    jmp run_check
run_decr_cursor:
    ; get cursor position for page 0
    mov ah, 0x3
    mov bh, 0
    int 0x10
    ; decrement column if column is not zero
    cmp dl, 0
    je run_decr_cursor_col
    mov bh, 0
    dec dl
    mov ah, 0x2
    int 0x10
    jmp run_check
run_decr_cursor_col:
    ; decrement row if column is zero
    mov bh, 0
    dec dh
    mov ah, 0x2
    int 0x10
    jmp run_check
run_print_cont:
    mov ah, 0x0e
    int 0x10
    jmp run_check

;; fill remaining space with zeros
times 510 - ($ - $$) db 0
dw 0xaa55
