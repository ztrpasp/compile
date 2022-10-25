	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
a:
b:
max(int, int):
        push    {r7}
        sub     sp, sp, #12
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7]
        ldr     r2, [r7, #4]
        ldr     r3, [r7]
        cmp     r2, r3
        blt     .L2
        ldr     r3, [r7, #4]
        b       .L3
.L2:
        ldr     r3, [r7]
.L3:
        mov     r0, r3
        adds    r7, r7, #12
        mov     sp, r7
        ldr     r7, [sp], #4
        bx      lr
.LC0:
        .ascii  "%d %d\000"
.LC1:
        .ascii  "max is: %d\012\000"
main:
        push    {r7, lr}
        add     r7, sp, #0
        movw    r2, #:lower16:b
        movt    r2, #:upper16:b
        movw    r1, #:lower16:a
        movt    r1, #:upper16:a
        movw    r0, #:lower16:.LC0
        movt    r0, #:upper16:.LC0
        bl      __isoc99_scanf
        movw    r3, #:lower16:a
        movt    r3, #:upper16:a
        ldr     r2, [r3]
        movw    r3, #:lower16:b
        movt    r3, #:upper16:b
        ldr     r3, [r3]
        mov     r1, r3
        mov     r0, r2
        bl      max(int, int)
        mov     r3, r0
        mov     r1, r3
        movw    r0, #:lower16:.LC1
        movt    r0, #:upper16:.LC1
        bl      printf
        movs    r3, #0
        mov     r0, r3
        pop     {r7, pc}