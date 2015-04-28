	.text
	.globl addition
	.globl subtraction
	.globl multiplication
	.globl division
#a0 = pointer to array
#a1 = size of array

addition:
	add $t0, $zero, $zero #initialize the accumulator
	add $t1, $zero, $zero #initialize iteration
add_loop:
	lw $t2, ($a0) # $t2 contains arr[i]
	add $t0, $t0, $t2 # accumulator += arr[i]
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
	blt $t1, $a1, add_loop #while iteration < size of arr
	add $v0, $zero, $t0 #add accumulator to the return
	jr $ra #return

subtraction:
	lw $t2, ($a0) # $t1 contains arr[i]
	add $t0, $zero, $t2 #initialize the accumulator
	add $t1, $zero, $zero #initialize iteration
	
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
sub_loop:
	lw $t2, ($a0) # $t1 contains arr[i]
	sub $t0, $t0, $t2 # accumulator -= arr[i]
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
	blt $t1, $a1, sub_loop #while iteration < size of arr
	add $v0, $zero, $t0 #add accumulator to the return
	jr $ra #return
	
multiplication:
	lw $t2, ($a0) # $t1 contains arr[i]
	add $t0, $zero, $t2 #initialize the accumulator
	add $t1, $zero, $zero #initialize iteration
	
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
mult_loop:
	lw $t2, ($a0) # $t1 contains arr[i]
	mult  $t0, $t2 # accumulator *= arr[i]
	mflo $t0 #put product into the accumulator
	
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
	blt $t1, $a1, mult_loop #while iteration < size of arr
	add $v0, $zero, $t0 #add accumulator to the return
	jr $ra #return
	
division:
	lw $t2, ($a0) # $t1 contains arr[i]
	add $t0, $zero, $t2 #initialize the accumulator
	add $t1, $zero, $zero #initialize iteration
	
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
div_loop:
	lw $t2, ($a0) # $t1 contains arr[i]
	div $t0, $t2 # accumulator /= arr[i]
	mflo $t0 #put quotient into the accumulator
	
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
	blt $t1, $a1, div_loop #while iteration < size of arr
	add $v0, $zero, $t0 #add accumulator to the return
	jr $ra #return
