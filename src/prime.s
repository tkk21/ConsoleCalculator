.data
Prompt: .asciiz "Enter a positive number to check if prime press ENTER.) \n"
Prime: .asciiz "\nThe number is Prime"
notPrime: .asciiz "\nThe number is not prime. It is divisible by "
.globl find_prime
.text

find_prime:
    li $v0,4        # syscall to print String
    la $a0,Prompt   # load address of Prompt
    syscall         # print Prompt String  
	
    li $v0,5        # syscall to read integer
    syscall         # read first intger
    move $a0,$v0    # move integer in $v0 to $a0
	
	addi $a1, $a0, -1 # sets a0 to a1 -1
	addi $a3, $zero, 1	# sets a3 to 1
	beq $a1, $zero, prime	# if a1 is 0, number is prime
	beq $a1, $a3, prime	# if a1 is 1, number is prime

loop:
	div $a0, $a1	# divides a0 by a1
	mfhi $a2        # reminder to $a2
	beq $a2, $zero, notprime	# if remainder is 0, number is not prime
	
	addi $a1, $a1, -1 # decrements $a1
	beq $a1, $a3, prime	# if a1 is 1, number is prime
	j loop
	
prime:
	li $v0,4        # syscall to print String
    la $a0,Prime   # load address of Prompt
    syscall         # print Prompt String  
	j exit

notprime:
	li $v0,4        # syscall to print String
    la $a0,notPrime   # load address of Prompt
    syscall         # print Prompt String 
	
	li $v0, 1        # syscall to print integer
	addi $a0, $a1, 0 # prepares return value for printing
    syscall          # prints result

	j exit

exit:
	li $v0, 10 		# system call to end program
	syscall
