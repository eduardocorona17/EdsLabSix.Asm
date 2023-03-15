//
//  EduardosLab6.s
//  EdsLabSix
//
//  Created by Eduardo Corona on 3/14/23.
//
.text
.globl _main
_main:
// Set up the string and colors
adrp x0, message@page // Load the page address of the message string
ldr x0, [x0, message@pageoff] // Load the offset of the message string from the GOT
mov x1, #0 // policy parameter
mov x2, #0 // process ID parameter
mov x16, #410 // setiopolicy_np system call number

// Loop over the four colors
mov w10, #0 // color counter
loop:
cmp w10, #4 // check if we have done four colors
b.eq endloop // if so, exit the loop
mov w0, w10 // move the color number into the first parameter register
svc #0 // call the setiopolicy_np system call
adrp x1, message@page // Load the page address of the message string
add x1, x1, message@pageoff // Add the offset of the message string from the GOT
bl _puts // print the message using the standard library function puts
add w10, w10, #1 // increment the color counter
b loop // repeat the loop
endloop:
// Exit the program
mov x0, #0 // set the exit code to 0
mov x16, #1 // set the system call number to exit
svc #0 // call the exit system call

// Data section with the message string
.data
.align 2
message:
.quad 0 // Placeholder for the offset of the message string in the GOT
.ascii "This line is displayed in Eduardo's color!\n\0"
