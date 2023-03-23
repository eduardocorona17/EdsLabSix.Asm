//
//  EdsLab8.s
//  EdsLabSix
//
//  Created by Eduardo Corona on 3/22/23.
//
.global _main
.global _parity_check

.section __DATA,__data
array_even: .byte 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55
array_odd:  .byte 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x54

.section __TEXT,__text
_main:
    // Save callee-saved registers
    stp x19, x20, [sp, #-16]!

    // Test array_even (result in w0)
    mov x0, 10
    adrp x1, array_even@PAGE
    add x1, x1, array_even@PAGEOFF
    bl _parity_check

    // Test array_odd (result in w0)
    mov x0, 10
    adrp x1, array_odd@PAGE
    add x1, x1, array_odd@PAGEOFF
    bl _parity_check

    // Restore callee-saved registers and return
    ldp x19, x20, [sp], #16
    mov x8, 0
    ret

_parity_check:
    // Save callee-saved registers
    stp x19, x20, [sp, #-16]!

    // Parity checking
    mov x19, 0                  // Initialize bit count
    mov x20, x1                 // Save array pointer
1:
    ldrb w1, [x20], #1          // Load byte and post-increment pointer
    clz w2, w1                  // Count leading zeros
    sub w1, w1, w2, lsr #1      // Remove leading zeros, divide by 2
    add x19, x19, x1            // Accumulate bit count
    subs x0, x0, #1             // Decrement length counter
    bne 1b                      // Loop until done

    // Check parity
    and w0, w19, #1             // Check if bit count is odd or even
    eor w0, w0, #1              // Set w0 to 1 if even, 0 if odd

    // Restore callee-saved registers and return
    ldp x19, x20, [sp], #16
    ret
