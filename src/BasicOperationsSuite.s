	.text
	.globl addition
	.globl subtraction
	.globl multiplication
	.globl division
	.globl reset_arr
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
	j reset_arr

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
	j reset_arr
	
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
	j reset_arr
	
division:
	lw $t2, ($a0) # $t1 contains arr[i]
	#convert int to float
	mtc1 $t2, $f0
	cvt.d.w $f0, $f0
	
	add $t1, $zero, $zero #initialize iteration
	
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
div_loop:
	lw $t2, ($a0) # $t1 contains arr[i]
	#convert int to float
	mtc1 $t2, $f2
	cvt.d.w $f2, $f2
	
	div.d $f0, $f0, $f2# accumulator /= arr[i]
	
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
	blt $t1, $a1, div_loop #while iteration < size of arr
	
	
	j reset_arr
	
reset_arr:
	#reset array ptr
	add $t0, $a1, $zero #get size of arr
	sll $t0, $t0, 2 #turn into word length
	sub $a0, $a0, $t0 #restore arr ptr to normal
	
	#lw $t0, ($a0)
	#li $v0, 1
	#add $a0, $zero, $t0
	#syscall
	jr $ra 
