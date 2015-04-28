.data
Prompt: .asciiz "Type positive integer 1, press ENTER. Type the positive integer 2 press Enter) \n"
Result: .asciiz "\nThe least common multiple is "
.globl lcm
.text

lcm:
    li $v0,4        # syscall to print String
    la $a0,Prompt   # load address of Prompt
    syscall         # print Prompt String  
	
    li $v0,5        # syscall to read integer 1
    syscall         # read first intger
    move $a0,$v0    # move integer in $v0 to $a0
	addi $t1, $a0, 0	#stores a0 into t1
	
    li $v0,5        # syscall to read integer 2
    syscall         # read second integer
    move $a1,$v0    # move integer in $v0 to $a1
	addi $t2, $a1, 0	#stores a1 into t2


check:
	beq $t1, $t2, exit	#if integer 1 = integer 2, jump to exit
	
	slt $t3,$t2,$t1      # checks if $t1 > $t2
	beq $t3,1, inc2     # if $t1 > $t2, goes to inc2
	j inc1				# else ($t2>$t1) goes to inc1

inc1:
	add $t1, $t1, $a0	# increments t1 by a0 
	j check
	
inc2:
	add $t2, $t2, $a1	# increments t2 by a1 
	j check
	
exit:
	li $v0, 4       # syscall to print result message
	la $a0,Result   # load address of Result
    syscall         # prints result
	
    li $v0, 1       # syscall to print integer LCM
	addi $a0, $t1, 0# prepares return value for printing
    syscall         # prints result
	
	li $v0, 10 		# system call to end program
	syscall 
