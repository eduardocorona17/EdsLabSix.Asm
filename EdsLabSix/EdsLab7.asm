//
//  EdsLab7.s
//  EdsLabSix
//
//  Created by Eduardo Corona on 3/20/23.
//
.global _main
.section __TEXT,__text,regular,pure_instructions

_main:
    ; You can set the initial values of w0 (num1), w1 (ecx), and w2 (edx) here
    mov w0, #5   ; num1 = 5
    mov w1, #3   ; ecx = 3
    mov w2, #1   ; edx = 1

    cmp w0, w1   ; Compare num1 with ecx
    ble EC       ; If num1 <= ecx, branch to label EC
    cmp w1, w2   ; Compare ecx with edx
    ble EC       ; If ecx <= edx, branch to label EC

    mov w3, #1   ; Set RESULT to 1
    b done       ; Jump to the done label

EC:
    mov w3, #2   ; Set RESULT to 2

done:
    ; w3 now contains the RESULT

    ; Exit the program
    mov w8, #1          ; Prepare the exit syscall number (1)
    mov x0, x3          ; Put the RESULT into x0 to be used as the exit status
    svc #0x80           ; Make the syscall (0x80)
