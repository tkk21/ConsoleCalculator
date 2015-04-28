.data
A:  .word 0
B:  .word 0
Prompt: .asciiz "Type integer for A, press ENTER. Type integer for B, press ENTER \n"
Result: .asciiz "\nThe GCD is "
.globl gcd
.text

gcd:

    li $v0,4        # syscall to print String
    la $a0,Prompt   # load address of Prompt
    syscall         # print Prompt String  
	
    li $v0,5        # syscall to read integer
    syscall         # read first intger
    move $a0,$v0    # move integer in $v0 to $a0
	
    li $v0,5        # syscall to read integer
    syscall         # read next integer
    move $a1,$v0    # move integer in $v0 to $a1
	
	bge $a1, $a0, swap 
	
baseCase:

    bne $a1,$zero,recCase   # if $a1 != 0 branch to recCase
    li $v0,4        # syscall to print String
    la $a0,Result   # load address of Result
    syscall         # print result String
	
    lw $a0,A        # load A
    li $v0,1        # syscall to print integer
    syscall         # print A
	
    li $v0,10       # terminate prog running
    syscall         # return control to system

recCase:

    sub $sp,$sp,12      # push stack
    sw $ra,0($sp)       # save return address
    sw $a0,4($sp)       # save registers
    sw $a1,8($sp)      
    move $t0,$a1        # move $a1 to $t0
    rem $a1,$a0,$a1     # $a1 =  A%B
    sw $t0,A            # store A for output
    jal baseCase        # jump to baseCase
    lw $ra,0($sp)       # load main
	
    addi $sp,$sp,12     #
    jr $ra              # return to main

swap:

    move	$t1,$a0  #  $t1 = $a0
	move	$a0,$a1  #  $a0 = $a1
	move	$a1,$t1  #  $a1 = $t1
	jal baseCase