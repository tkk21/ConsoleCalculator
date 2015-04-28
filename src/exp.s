.data
Prompt: .asciiz "Type the base number for the exponent, press ENTER. Type the exponent number (positive integer or 0), press Enter) \n"
Result: .asciiz "\nThe value is "
.globl exponent
.text

exponent:
    li $v0,4        # syscall to print String
    la $a0,Prompt   # load address of Prompt
    syscall         # print Prompt String  
	
    li $v0,5        # syscall to read integer base
    syscall         # read first intger
    move $a0,$v0    # move integer in $v0 to $a0
	
    li $v0,5        # syscall to read integer exponent
    syscall         # read second integer
    move $a1,$v0    # move integer in $v0 to $a1
	
	addi $t1, $zero, 1	# sets return value to 1 
	beq $a1,$zero,exit  # if exponent = 0 branch to exit

	addi $t1, $a0, 0	# sets return value to base 
	addi $t0, $zero, 1	#stores count of iteration through loop
	beq $a1,$t0,exit    # if count = exponent branch to exit

exp:
	mult $t1, $a0	#multiplies base by the current return value
	mflo $t1		#sets return value to result of multiplication
	
	addi $t0, $t0, 1		#increments count of iteration through loop
	beq $a1,$t0,exit #count = exponent branch to exit
	j exp			#jump back to exponent
	
exit:
	li $v0, 4       # syscall to print result message
	la $a0,Result   # load address of Result
    syscall         # prints result
	
    li $v0, 1       # syscall to print integer
	addi $a0, $t1, 0# prepares return value for printing
    syscall         # prints result
	
	li $v0, 10 		# system call to end program
	syscall 