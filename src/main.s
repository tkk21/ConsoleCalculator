	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register


#actual start of the main program





	.text
take_argument:
	li	$v0, 4		#print_str (system call 4)
	la	$a0, intro	# takes the address of the string prompt as an argument 
	syscall
	
	li	$v0, 4		#print_str (system call 4)
	la	$a0, argument_inst	# takes the address of the string prompt as an argument 
	syscall
	
	li $v0, 5 #read_int
	syscall
	
	#branch to the proper subroutione
	addi $t0, $zero, 1 
	beq $v0, $t0, call_add
	addi $t0, $t0, 1
	beq $v0, $t0, call_sub
	addi $t0, $t0, 1
	beq $v0, $t0, call_mult
	addi $t0, $t0, 1
	beq $v0, $t0, call_div
	addi $t0, $t0, 1
	beq $v0, $t0, call_gcd
	addi $t0, $t0, 1
	beq $v0, $t0, call_fact
	addi $t0, $t0, 1
	beq $v0, $t0, call_mod
	addi $t0, $t0, 1
	beq $v0, $t0, call_exp
	addi $t0, $t0, 1
	beq $v0, $t0, call_and
	addi $t0, $t0, 1
	beq $v0, $t0, call_or
	addi $t0, $t0, 1
	beq $v0, $t0, call_lcm
	addi $t0, $t0, 1
	beq $v0, $t0, call_var
	addi $t0, $t0, 1
	beq $v0, $t0, call_mean
	addi $t0, $t0, 1
	beq $v0, $t0, call_median
	addi $t0, $t0, 1
	beq $v0, $t0, call_mode
	addi $t0, $t0, 1
	
	
call_add:
	jal prompt_array
	
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal addition
	add $t0, $v0, $zero
	
	li $v0, 4
	la $a0, result_string
	syscall
	#print result int
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	j end
call_sub:
	jal prompt_array
	
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal subtraction
	add $t0, $v0, $zero
	
	li $v0, 4
	la $a0, result_string
	syscall
	#print result int
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	j end
call_mult:
	jal prompt_array
	
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal multiplication
	add $t0, $v0, $zero
	
	li $v0, 4
	la $a0, result_string
	syscall
	#print result int
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	j end
call_div:
	jal prompt_array
	
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal division
	
	add.d $f12, $f0, $f0
	sub.d $f12, $f12, $f0
	
	li $v0, 4
	la $a0, result_string
	syscall
	#print result double
	li $v0, 3
	syscall
	
	j end

call_gcd:
	jal gcd
	j end
call_fact:
	jal factorial
	j end
call_mod:
	jal modulus
	j end
call_exp:
	jal exponent
	j end
call_and:
	jal andfunc
	j end
call_or:
	jal orfunc
	j end
call_lcm:
	jal lcm
	j end
call_var:
	jal prompt_array
		
	add $a0, $zero, $v0
	add $a1, $zero, $v1

	jal variance
	add.d $f12, $f0, $f0
	sub.d $f12, $f12, $f0
	
	li $v0, 4
	la $a0, result_string
	syscall
	#print result double
	li $v0, 3
	syscall
	
	j end
call_mean:
	jal prompt_array
	
	add $a0, $zero, $v0
	add $a1, $zero, $v1

	jal mean
	add.d $f12, $f0, $f0
	sub.d $f12, $f12, $f0
	
	li $v0, 4
	la $a0, result_string
	syscall
	#print result double
	li $v0, 3
	syscall
	
	j end
call_median:
	jal prompt_array
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal median
	add $t0, $v0, $zero
	
	li $v0, 4
	la $a0, result_string
	syscall
	
	li $v0, 3
	add.d $f12, $f0, $f0
	sub.d $f12, $f12, $f0
	syscall
	
	j end
	
call_mode:

prompt_array:
	li	$v0, 4		#print_str (system call 4)
	la	$a0, prompt_array_string	# takes the address of the string prompt as an argument 
	syscall
	li $v0, 5 #read int
	syscall
	add $t0, $v0, $zero #saves array size into t0
	sll $a0, $t0, 2 #multiply size by 4, because word is 4 bytes
	
	li $v0, 9 #allocate heap
	syscall
	
	add $t1, $zero, $v0 #save address of array to t1
	add $t2, $zero, $v0 #pointer to array that we will iterate
	
	add $t3, $0, $0 #initialize index
array_populate:
	li $v0, 5
	syscall
	sw $v0, ($t2) #arr[i] = $v0
	addi $t2, $t2, 4 #increment ptr by a word
	addi $t3, $t3, 1 #increment index by 1
	blt $t3, $t0, array_populate
	add $v0, $zero, $t1 #return the pointer to the array
	add $v1, $t0, $0 #return the size of the array
	jr $ra


end: 
                       #Usual stuff at the end of the main
	addu	$ra, $0, $s7	#restore the return address
	jr	$ra		#return to the main program
	add	$0, $0, $0	#nop

	.data
intro: .asciiz "\n Welcome to Console Calculator \n Please enter the proper argument to use the following functions \n"  
argument_inst: .asciiz "\n 1: addition \n 2: subtraction \n 3: multiplication \n 4: division \n 5: Greatest Common Divisor \n 6: factorial \n 7: modulus \n 8: integer exponent \n 9: logical and \n 10: logical or \n 11: Least Common Multiple \n 12: variance \n 13: mean \n 14: median \n 15: mode \n"
prompt_array_string: .asciiz "\n Please Enter the number of arguments you want to enter \n"
result_string: .asciiz "\n The result is: "