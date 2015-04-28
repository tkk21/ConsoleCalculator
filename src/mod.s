.data
Prompt: .asciiz "Type the first number (A) for the modular (A mod B), press ENTER. Type the second number (B) for the modular (A mod B) \n"
Result: .asciiz "\nThe result is "
.globl modulus
.text

modulus:

    li $v0,4        # syscall to print String
    la $a0,Prompt   # load address of Prompt
    syscall         # print Prompt String  
	
    li $v0,5        # syscall to read integer A
    syscall         # read first intger
    move $a0,$v0    # move integer in $v0 to $a0
	
    li $v0,5        # syscall to read integer B
    syscall         # read second integer
    move $a1,$v0    # move integer in $v0 to $a1
	
mod:
	div $a0, $a1	# divides A and B
	mfhi $a2        # reminder to $a2

	li $v0, 4       # syscall to print result message
	la $a0,Result   # load address of Result
    syscall         # prints result
	
    li $v0, 1       # syscall to print integer
	addi $a0, $a2, 0# loads remainder
    syscall         # prints result
	
	li $v0, 10 		# system call to end program
	syscall 

