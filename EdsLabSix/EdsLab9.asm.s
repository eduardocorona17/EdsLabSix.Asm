//
//  EdsLab9.asm.s
//
//
//  Created by Eduardo Corona on 4/14/23.
//
.global _main

.section __TEXT, __text

_main:
    // Test case 1: positive number
    mov w0, #4096
    bl sign_extend
    
    
    // Test case 2: negative number
    mov w0, #-4096
    bl sign_extend
    

    // Exit
    movz x8, #1
    lsl x8, x8, #21
    movz x0, #0
    svc 0

sign_extend:
    // Sign-extend the lower 16 bits of W0 into the upper 16 bits of W0
    sxtw x0, w0        // Sign-extend W0 into X0
    lsr x0, x0, #48    // Shift right the upper 16 bits of X0
    sxth w0, w0        // Sign-extend the lower 16 bits of W0 into W0
    orr w0, w0, w0, lsl #16  // Combine the upper 16 bits and lower 16 bits
    ret
