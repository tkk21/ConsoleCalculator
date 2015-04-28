.data
Prompt: .asciiz "Type the first number (A) for first binary, press ENTER. Type the second number (B) for second binary \n"
Result: .asciiz "\nThe result is: "
.globl orfunc
.text

orfunc:

  li $v0,4        # syscall to print String
    la $a0,Prompt   # load address of Prompt
    syscall         # print Prompt String  
	
    li $v0,5        # syscall to read integer A
    syscall         # read first intger
    move $a0,$v0    # move integer in $v0 to $a0
	
    li $v0,5        # syscall to read integer B
    syscall         # read second integer
    move $a1,$v0    # move integer in $v0 to $a1
    
	or $a2, $a0, $a1

	li $v0, 4       # syscall to print result message
	la $a0,Result   # load address of Result
        syscall         # prints result
	
   	 li $v0, 1       # syscall to print integer
	addi $a0, $a2, 0# loads result
   	 syscall         # prints result
	
	li $v0, 10 		# system call to end program
	syscall 