.data
	array: .space 808
	promptA: .asciiz "Enter up to 100 numbers to average. '0' will end inputs."
	promptB: .asciiz "Enter a number: "
	answer: .asciiz "The average is: "
	slash: .asciiz "/"
	newline: .asciiz "\n"
	space: .asciiz " "
.text

main:
	la $t0, array   #initializes some variables
	li $v0,4        # syscall to print String
    la $a0,promptA  # load address of Prompt
    syscall         # print Prompt String

	la $a0, newline #prints a newline
	li $v0, 4
	syscall

input:
	li $v0,4        	# syscall to print String
    la $a0,promptB  	# load address of Prompt
    syscall         	# print Prompt String

	li $v0, 7 			#gets user input
	syscall

	s.d $f0, 0($t0) 	#puts integer into array
	addi $t0, $t0, 8 	#moves to next array index

	c.eq.d $f0, $f2 	#continues asking for input if last input was not 0
	bc1t resetIndex
	jal input
	jr $ra				#returns to main

resetIndex:
	la $t0, array 		#resets array index

summation:
	l.d $f0, 0($t0)     #load the index's value and move to the next index
	addi $t0, $t0, 8
	add.d $f2, $f2, $f0	#calculating total of all values

	c.eq.d $f0, $f4 	#continues loop through array if 0 was not the input
	bc1t findingMean
	jal summation
	jr $ra				#returns to main

findingMean:
	la $t3, array			#gets the total number of entries
	sub $t0, $t0, $t3
	div $t0, $t0, 8
	addi $t0, $t0, -1

	mtc1 $t0, $f6			#calculates the average
	cvt.d.w $f6, $f6
	div.d $f12, $f2, $f6

	la $a0, answer 			#prints the average for the user
	li $v0, 4
	syscall
	li $v0, 3
	syscall
	jr $ra					#returns to main