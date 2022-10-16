.data
ofile: .asciiz "/dev/tty"
clear: .byte 0x1B 0x5B 0x33 0x3B 0x4A 0x1B 0x5B 0x48 0x1B 0x5B 0x32 0x4A
      # .byte 0x00

sprintf_buf:
    .space  0x50
    
sprintf_bufe:

    .text
    .globl main
    
main:
    li $v0, 0xd                   # open file
    la $a0, ofile                 # filename to open
    li $a1, 0x1                   # 1=O_WRONLY
    li $a2, 0x0                   # mode [ignored]
    syscall
    move $s7, $v0                 # remember open unit

main_loop:
    la $a1,clear
    jal fputs
    li $v0, 0x1e
    syscall
    divu $a0, $a0, 0x3e8
    mflo $a0
    li $t0, 0x20000000
    mtc1 $t0, $f0
    cvt.d.w $f0, $f0
    li $t0, 0x7d
    mtc1 $t0, $f2
    cvt.d.w $f2, $f2
    div.d $f0, $f0, $f2
    mtc1 $a1, $f2
    cvt.d.w $f2, $f2
    mul.d $f0, $f0, $f2
    cvt.w.d $f0, $f0
    mfc1 $a1, $f0
    add $a0, $a0, $a1
    addi $a0, $a0, 0x4d58
    li $t0, 0x15180
    div $a0, $t0
    mfhi $a0
    move $a1, $a0
    li $t0, 0xe10
    divu $a0, $t0
    mflo $a0
    bgeu $a0, 0xa, c1
    jal zero_pad
c1:
    li $v0, 0x1
    syscall
    li $a0, 0x3a
    li $v0, 0xb
    syscall
    mfhi $a0
    li $t0, 0x3c
    div $a0, $t0
    mflo $a0
    bgeu $a0, 0xa, c2
    jal zero_pad
c2:
    li $v0, 0x1
    syscall
    li $a0, 0x3a
    li $v0, 0xb
    syscall
    mfhi $a0
    bgeu $a0, 0xa, c3
    jal zero_pad
c3:
    li $v0, 0x1
    syscall
    j main_delay

zero_pad:
	move $a1, $a0
	li $a0, 0x30
	li $v0, 0xb
	syscall
	move $a0, $a1
	jr $ra

    li $t0, 0x8000
main_delay:
    subiu $t0, $t0, 0x1
    bnez $t0, main_delay
    j main_loop

# fputs -- output string to "console"
# arguments:
#   s7 -- file descriptor
#   a1 -- pointer to string
fputs:
    move $a2, $a1                # get buffer address
# get string length
fputs_loop:
    lb $t0, ($a2)                # get next char -- is it EOS?
    addiu $a2, $a2, 0x1          # increment length/buffer pointer
    bnez $t0, fputs_loop         # no, loop
    subu $a2, $a2, $a1           # get the length
    move $a0,$s7                 # get file descriptor
    li $v0, 0xf                  # syscall for write
    syscall
    jr $ra                       # return
