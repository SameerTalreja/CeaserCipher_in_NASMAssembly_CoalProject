section .data
    msg_mode     db "Encrypt or Decrypt (E/D): ", 0
    msg_shift    db "Enter shift value: ", 0
    msg_text     db "Enter text: ", 0
    msg_result   db "Result: ", 0
    msg_error    db "Invalid shift value!", 10, 0
    newline      db 10, 0

section .bss
    shift_inp    resb 8
    text_inp     resb 128
    encrypted    resb 128
    shift_val    resb 1
    enc_or_dec   resb 2

section .text
    global _start

_start:

    ; Ask for E or D
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mode
    call print_string

    mov eax, 3
    mov ebx, 0
    mov ecx, enc_or_dec
    mov edx, 2
    int 0x80

    ; Ask for shift
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_shift
    call print_string

    mov eax, 3
    mov ebx, 0
    mov ecx, shift_inp
    mov edx, 8
    int 0x80

    ; Convert shift to integer
    mov eax, shift_inp
    call str_to_int
    cmp bl, 0
    jl invalid_input
    mov [shift_val], bl

    ; Ask for text
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_text
    call print_string

    mov eax, 3
    mov ebx, 0
    mov ecx, text_inp
    mov edx, 128
    int 0x80

    ; Remove newline from text input
    mov esi, text_inp
.clean_input:
    mov al, [esi]
    cmp al, 10
    je .null_end
    cmp al, 0
    je .null_end
    inc esi
    jmp .clean_input
.null_end:
    mov byte [esi], 0

    ; Clear encrypted buffer
    mov ecx, 128
    mov edi, encrypted
.clear_loop:
    mov byte [edi], 0
    inc edi
    loop .clear_loop

    ; Setup pointers
    mov esi, text_inp
    mov edi, encrypted
    mov bl, [shift_val]

encrypt_loop:
    mov al, [esi]
    cmp al, 0
    je print_result

    ; Uppercase
    cmp al, 'A'
    jl check_lower
    cmp al, 'Z'
    jg check_lower
    sub al, 'A'
    cmp byte [enc_or_dec], 'D'
    jne .enc1
    sub al, bl
    add al, 26
    jmp .mod1
.enc1:
    add al, bl
.mod1:
    xor ah, ah
    mov dl, 26
    div dl
    mov al, ah
    add al, 'A'
    jmp store

check_lower:
    cmp al, 'a'
    jl store
    cmp al, 'z'
    jg store
    sub al, 'a'
    cmp byte [enc_or_dec], 'D'
    jne .enc2
    sub al, bl
    add al, 26
    jmp .mod2
.enc2:
    add al, bl
.mod2:
    xor ah, ah
    mov dl, 26
    div dl
    mov al, ah
    add al, 'a'

store:
    mov [edi], al
    inc esi
    inc edi
    jmp encrypt_loop

print_result:
    mov byte [edi], 0

    ; Print "Result: "
    mov ecx, msg_result
    call print_string

    ; Print encrypted or decrypted text
    mov ecx, encrypted
    call print_string

    ; Print newline
    mov ecx, newline
    call print_string

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

invalid_input:
    mov ecx, msg_error
    call print_string

    mov eax, 1
    mov ebx, 1
    int 0x80

; -----------------------------------------------------------
; Convert ASCII string to integer (result in bl)
; eax = pointer to ASCII digits
; returns: bl = result (or negative if '-' found)
; -----------------------------------------------------------
str_to_int:
    xor ebx, ebx
    mov ecx, eax
    mov al, [ecx]
    cmp al, '-'
    je .negative

.convert_loop:
    mov al, [ecx]
    cmp al, 10
    je .done
    cmp al, 0
    je .done
    sub al, '0'
    cmp al, 9
    ja .done
    imul ebx, ebx, 10
    add ebx, eax
    inc ecx
    jmp .convert_loop

.negative:
    mov bl, -1
    ret

.done:
    ret

; -----------------------------------------------------------
; Print string until null-terminator
; ecx = pointer to string
; -----------------------------------------------------------
print_string:
    pusha
    mov edx, 0
.next_char:
    cmp byte [ecx + edx], 0
    je .done_print
    inc edx
    jmp .next_char
.done_print:
    mov eax, 4
    mov ebx, 1
    int 0x80
    popa
    ret

