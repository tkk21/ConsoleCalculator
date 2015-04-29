.globl median
.text
#a0= array ptr
#a1 = size of arr

#sort the array
#find the middle
median:
	addu	$s4, $0, $ra	#save the return address in a global register
	add $t0, $zero, $a0 #save array to t0
	add $t6, $zero, $t0 #save the initial pointer to array so we can recover it
	
	add $t3, $a1, $zero #initialize end index
	
	
	add $a0, $zero, $a1 #allocate an array of size of input arr
	li $v0, 9 #allocate heap
	syscall
	
	add $t1, $v0, $zero #save new array in t1

	sll $t7, $a1, 2 #turn size into word
	add $t1, $t1, $t7 #set the newArr to end of arr
	
foundMax:
	add $t4, $zero, $zero #initialize begin index
	add $t5, $zero, $zero #initialize MAX
	add $t0, $zero, $t6 #reset the array
findMax: 
	lw $t2, ($t0) # t2 = arr[i]
	bgt  $t5, $t2, greater #max > arr[i] so no need to set
	add $t5, $zero, $t2
greater:
	addi $t4, $t4, 1 #increment index by 1
	addi $t0, $t0, 4 #increment ptr by a word
	blt $t4, $t3, findMax #while int i <size
	
	
	sw $t5 ($t1) #save the largest element into the end of the new arr
	subi $t1, $t1, 4 #decrement newArr ptr by a word
	subi $t3, $t3, 1 #decrement end index

	
	bgt $t3, $zero, foundMax #keep doing this until we sort the array completely
	
	add $t0, $a1, $zero #set t0 to size of arr
	srl $t0, $t0, 1 #divide by 2 for median
	sll, $t0, $t0, 2 #turn into word and div by 2
	add $t1, $t1, $t0 #go to middle of the array
	
	#odd or even check
	addi $t2, $zero, 2
	div $a1, $t2
	mfhi $t2 #size % 2 = t2
	
	beq $t2, $zero, even
odd:
	addi $t1, $t1, 4 #add a word if odd
	lw $v0, ($t1)
	#convert return to float
	mtc1 $v0, $f0
	cvt.d.w $f0, $f0
	jr $ra #return
even:
	add $a0, $zero, 8 # 2 words
	li $v0, 9 #allocate heap
	syscall
	addi $a1, $zero, 2 #size of arr
	add $a0, $zero, $v0 #ptr to arr

	lw $t2, ($t1) #get first of the two median to average	
	sw $t2, ($a0) #save to mean[0]
	
	addi $a0, $a0, 4 #go to mean[1]
	addi $t1, $t1, 4 #go to second median
	lw $t2, ($t1) #get second of the two median to average
	sw $t2, ($a0) #save to mean[1]
	add $a0, $zero, $v0
	jal mean
	# $f0 now contains the mean
	addu	$ra, $0, $s4	#restore the return address
	jr $ra #return