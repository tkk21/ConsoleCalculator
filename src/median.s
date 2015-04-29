.globl median
.text
#a0= array ptr
#a1 = size of arr

#sort the array
#find the middle
median:
	add $t0, $zero, $a0 #save array to t0
	add $t6, $zero, $t0 #save the initial pointer to array so we can recover it
	
	add $t3, $a1, $zero #initialize end index
	
	
	add $a0, $zero, $a1 #allocate an array of size of input arr
	li $v0, 9 #allocate heap
	syscall
	
	add $t1, $v0, $zero #save new array in t1

	sll $t7, $a1, 2 #turn size into word
	subi $t7, $t7,4 
	add $t1, $t1, $t7 #set the newArr to end of arr
	
foundMax:
	add $t4, $zero, $zero #initialize begin index
	add $t5, $zero, $zero #initialize MAX
	add $t0, $zero, $t6 #reset the array
findMax: 
	lw $t6, ($t0) # t5 = arr[i]
	bgt  $t5, $t6, greater #max > arr[i] so no need to set
	add $t5, $zero, $t6
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
	sll, $t0, $t0, 2 #turn into word
	add $t1, $t1, $t0 #go to middle of the array
	lw $v0, ($t1)
	jr $ra #return